`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/16 02:33:31
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


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
    reg [3:0] BCD;
    
    KeyboardDecoder U0 (key_down, last_change, key_valid, PS2_DATA, PS2_CLK, rst, clk);
    D_ssd U1 (ssd, BCD);
    
    assign ssd_ctl = 4'b1110;
    
    always @*
    begin
        case(last_change)
            8'H16 : BCD = 4'd1;
            8'H1E : BCD = 4'd2;
            8'H26 : BCD = 4'd3;
            8'H25 : BCD = 4'd4;
            8'H2E : BCD = 4'd5;
            8'H36 : BCD = 4'd6;
            8'H3D : BCD = 4'd7;
            8'H3E : BCD = 4'd8;
            8'H46 : BCD = 4'd9;
            8'H45 : BCD = 4'd0;
            8'H1C : BCD = 4'd10;
            8'H1B : BCD = 4'd11;
            8'H3A : BCD = 4'd12;
            8'H5A : BCD = 4'd15;
        endcase
    end
    
endmodule
