`define S0 4'b0000
`define S1 4'b0001
`define S2 4'b0010
`define S3 4'b0011
`define S4 4'b0100
`define S5 4'b0101
`define S6 4'b0110
`define S7 4'b0111
`define S8 4'b1000
`define S9 4'b1001
`define S10 4'b1010
`define S11 4'b1011

module top(
    output [7:0] ssd,
    output [3:0] ssd_ctl,
    output [3:0] LED,
    inout PS2_DATA,
    inout PS2_CLK,
    input rst,
    input clk
    );
    
    wire [511:0] key_down;
    wire [8:0] last_change;
    wire key_valid;
    wire [3:0] key;
    wire [1:0] clk_ctl;
    reg [3:0] BCD3, next_BCD3;
    reg [3:0] BCD2, next_BCD2;
    reg [3:0] BCD1, next_BCD1;
    reg [3:0] BCD0, next_BCD0;
    wire [3:0] BCD;
    
    reg [3:0] state, next_state;
    wire [6:0] num1;
    wire [3:0] operand;
    wire [6:0] num2;
    reg [13:0] ans;
    
    KeyboardDecoder U0 (key_down, last_change, key_valid, PS2_DATA, PS2_CLK, rst, clk);
    kb_convert U1 (key, last_change);
    freq_div U2 ( , , , , clk_ctl, clk, ~rst);
    scan_ctl U3 (BCD, ssd_ctl, BCD3, BCD2, BCD1, BCD0, clk_ctl);
    D_ssd U4 (ssd, BCD);
    
    always @(posedge clk or posedge rst)
    begin
        if(rst == 1'b1)
        begin
            BCD3 <= 4'd15;
            BCD2 <= 4'd15;
            BCD1 <= 4'd15;
            BCD0 <= 4'd15;
            state <= `S0;
        end
        else
        begin
            BCD3 <= next_BCD3;
            BCD2 <= next_BCD2;
            BCD1 <= next_BCD1;
            BCD0 <= next_BCD0;
            state <= next_state;
        end
    end
    
    assign num1 = (state == `S3) ? 7'd10*BCD1 + key : num1;
    assign operand = (state == `S5) ? key : operand;
    assign num2 = (state == `S9) ? 7'd10*BCD1 + key : num2;
    
    assign LED[3] = ( state == `S1 || state == `S2 || state == `S3 || state == `S4) ? 1'b1 : 1'b0;
    assign LED[2] = (state == `S5 || state == `S6) ? 1'b1 : 1'b0;
    assign LED[1] = (state == `S7 || state == `S8 || state == `S9 || state == `S10) ? 1'b1 : 1'b0;
    assign LED[0] = (state == `S11 || state == `S0) ? 1'b1 : 1'b0;
    
    always @*
    begin
        next_BCD3 = BCD3;
        next_BCD2 = BCD2;
        next_BCD1 = BCD1;
        next_BCD0 = BCD0;
        
        case(state)
            `S0 : begin
                next_state = (key_valid == 1'b1) ? `S1 : `S0;
            end
            `S1 : begin//press
                next_state = (key_valid == 1'b1) ? `S2 : `S1;
                next_BCD3 = 4'd15;
                next_BCD2 = 4'd15;
                next_BCD1 = 4'd15;
                next_BCD0 = key;
            end
            `S2 : begin
                next_state = (key_valid == 1'b1) ? `S3 : `S2;
                if(key_valid == 1'b1)
                    next_BCD1 = BCD0;
            end
            `S3 : begin//press
                next_state = (key_valid == 1'b1) ? `S4 : `S3;
                next_BCD0 = key;
            end
            `S4 : begin
                if(key_valid == 1'b0)
                    next_state = `S4;
                else if(key == 4'd10 || key == 4'd11 || key == 4'd12)
                    next_state = `S5;
                else
                    next_state = `S1;
            end
            `S5 : begin//press operand
                next_state = (key_valid == 1'b1) ? `S6 : `S5;
                next_BCD1 = 4'd15;
                next_BCD0 = key;
            end
            `S6 :
                next_state = (key_valid == 1'b1) ? `S7 : `S6;
            `S7 : begin//press
                next_state = (key_valid == 1'b1) ? `S8 : `S7;
                next_BCD1 = 4'd15;
                next_BCD0 = key;
            end
            `S8 :begin
                next_state = (key_valid == 1'b1) ? `S9 : `S8;
                if(key_valid == 1'b1)
                    next_BCD1 = BCD0;
            end
            `S9 : begin//press
                next_state = (key_valid == 1'b1) ? `S10 : `S9;
                next_BCD0 = key;
            end
            `S10 : begin
                if(key_valid == 1'b0)
                    next_state = `S10;
                else if(last_change == 9'H5A)
                    next_state = `S11;
                else
                    next_state = `S7;
            end
            `S11 : begin//enter
                next_state = (key_valid == 1'b1) ? `S0 : `S11;
                next_BCD3 = (operand == 4'd11 && num1 < num2)? 4'd11 : ans/14'd1000;
                next_BCD2 = (ans%14'd1000) / 14'd100;
                next_BCD1 = (ans%14'd100) / 14'd10;
                next_BCD0 = ans%14'd10;
            end
        endcase
        
        case(operand)
            4'd10 : ans = num1 + num2;
            4'd11 : ans = (num1 >= num2) ? num1 - num2 : num2 - num1;
            4'd12 : ans = num1 * num2;
        endcase
    end
    
endmodule