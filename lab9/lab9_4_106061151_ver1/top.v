`define S0 2'b00
`define S1 2'b01
`define S2 2'b10
`define S3 2'b11

module top(
    output [7:0] ssd,
    output [3:0] ssd_ctl,
    output caps_lock,
    output reg [6:0] ASCII,
    inout PS2_DATA,
    inout PS2_CLK,
    input rst,
    input clk
    );
    
    wire [511:0] key_down;
    wire [8:0] last_change;
    wire key_valid;
    wire [1:0] clk_ctl;
    wire [3:0] BCD, BCD2, BCD1, BCD0;
    
    reg [1:0] state, next_state;
    
    KeyboardDecoder U0 (key_down, last_change, key_valid, PS2_DATA, PS2_CLK, rst, clk);
    freq_div U1 ( , , , , clk_ctl, clk, ~rst);
    scan_ctl U2 (BCD, ssd_ctl, 4'd0, BCD2, BCD1, BCD0, clk_ctl);
    D_ssd U3 (ssd, BCD);
    
    always @(posedge clk or posedge rst)
    begin
        if(rst == 1'b1)
        begin
            state <= `S0;
        end
        else
        begin
            state <= next_state;
        end
    end
    
    assign caps_lock = state[1];
    assign BCD2 = ASCII/7'd100;
    assign BCD1 = (ASCII%7'd100) / 7'd10;
    assign BCD0 = ASCII%7'd10;
    
    always @*
    begin
        case(state)
            `S0 :
                next_state = (key_valid == 1'b1 && last_change == 9'H58) ? `S1 : `S0;
            `S1 ://press
                next_state = (key_valid == 1'b1) ? `S2 : `S1;
            `S2 :
                next_state = (key_valid == 1'b1 && last_change == 9'H58) ? `S3 : `S2;
            `S3 ://press
                next_state = (key_valid == 1'b1) ? `S0 : `S3;
        endcase
        
        if(caps_lock ^ key_down[18] == 1'b1)
        begin
            case(last_change)
                9'H1C : ASCII = 7'd65;//A
                9'H32 : ASCII = 7'd66;//B
                9'H21 : ASCII = 7'd67;//C
                9'H23 : ASCII = 7'd68;//D
                9'H24 : ASCII = 7'd69;//E
                9'H2B : ASCII = 7'd70;//F
                9'H34 : ASCII = 7'd71;//G
                9'H33 : ASCII = 7'd72;//H
                9'H43 : ASCII = 7'd73;//I
                9'H3B : ASCII = 7'd74;//J
                9'H42 : ASCII = 7'd75;//K
                9'H4B : ASCII = 7'd76;//L
                9'H3A : ASCII = 7'd77;//M
                9'H31 : ASCII = 7'd78;//N
                9'H44 : ASCII = 7'd79;//O
                9'H4D : ASCII = 7'd80;//P
                9'H15 : ASCII = 7'd81;//Q
                9'H2D : ASCII = 7'd82;//R
                9'H1B : ASCII = 7'd83;//S
                9'H2C : ASCII = 7'd84;//T
                9'H3C : ASCII = 7'd85;//U
                9'H2A : ASCII = 7'd86;//V
                9'H1D : ASCII = 7'd87;//W
                9'H22 : ASCII = 7'd88;//X
                9'H35 : ASCII = 7'd89;//Y
                9'H1A : ASCII = 7'd90;//Z
            endcase
        end
        else
        begin
            case(last_change)
                9'H1C : ASCII = 7'd97;//A
                9'H32 : ASCII = 7'd98;//B
                9'H21 : ASCII = 7'd99;//C
                9'H23 : ASCII = 7'd100;//D
                9'H24 : ASCII = 7'd101;//E
                9'H2B : ASCII = 7'd102;//F
                9'H34 : ASCII = 7'd103;//G
                9'H33 : ASCII = 7'd104;//H
                9'H43 : ASCII = 7'd105;//I
                9'H3B : ASCII = 7'd106;//J
                9'H42 : ASCII = 7'd107;//K
                9'H4B : ASCII = 7'd108;//L
                9'H3A : ASCII = 7'd109;//M
                9'H31 : ASCII = 7'd110;//N
                9'H44 : ASCII = 7'd111;//O
                9'H4D : ASCII = 7'd112;//P
                9'H15 : ASCII = 7'd113;//Q
                9'H2D : ASCII = 7'd114;//R
                9'H1B : ASCII = 7'd115;//S
                9'H2C : ASCII = 7'd116;//T
                9'H3C : ASCII = 7'd117;//U
                9'H2A : ASCII = 7'd118;//V
                9'H1D : ASCII = 7'd119;//W
                9'H22 : ASCII = 7'd120;//X
                9'H35 : ASCII = 7'd121;//Y
                9'H1A : ASCII = 7'd122;//Z
                    endcase            
        end        
    end
    
endmodule