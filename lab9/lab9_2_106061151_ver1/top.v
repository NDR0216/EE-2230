`define S0 2'b00
`define S1 2'b01
`define S2 2'b10
`define S3 2'b11

module top(
    output [7:0] ssd,
    output [3:0] ssd_ctl,
    inout PS2_DATA,
    inout PS2_CLK,
    input rst,
    input clk
    );
    
    wire [511:0] key_down;
    wire [8:0] last_change;
    wire key_valid;
    wire [3:0] key;
    reg [3:0] BCD3, next_BCD3;
    reg [3:0] BCD2, next_BCD2;
    wire [3:0] BCD1;
    wire [3:0] BCD0;
    wire [4:0] add;
    wire [1:0] clk_ctl;
    wire [3:0] BCD;
    
    
    reg [1:0] state, next_state;
    
    KeyboardDecoder U0 (key_down, last_change, key_valid, PS2_DATA, PS2_CLK, rst, clk);
    kb_convert U1 (key, last_change);
    BCD_binary U2 (BCD1, BCD0, add);
    freq_div U3 ( , , , , clk_ctl, clk, ~rst);
    scan_ctl U4 (BCD, ssd_ctl, BCD3, BCD2, BCD1, BCD0, clk_ctl);
    D_ssd U5 (ssd, BCD);
    
    always @(posedge clk or posedge rst)
    begin
        if(rst == 1'b1)
        begin
            BCD3 <= 4'd0;
            BCD2 <= 4'd0;
            state <= `S0;
        end
        else
        begin
            BCD3 <= next_BCD3;
            BCD2 <= next_BCD2;
            state <= next_state;
        end
    end
    
    assign add = (state == `S1 || state == `S2) ? BCD3 : BCD3 + BCD2;
    
    always @*
    begin
        next_BCD3 = BCD3;
        next_BCD2 = BCD2;
        case(state)
            `S0 :
                next_state = (key_valid == 1'b1) ? `S1 : `S0;
            `S1 : begin
                next_state = (key_valid == 1'b1) ? `S2 : `S1;
                next_BCD3 = key;
                next_BCD2 = 4'd15;
            end
            `S2 :
                next_state = (key_valid == 1'b1) ? `S3 : `S2;
            `S3 : begin
                next_state = (key_valid == 1'b1) ? `S0 : `S3;
                next_BCD2 = key;
            end                           
        endcase
    end
    
endmodule