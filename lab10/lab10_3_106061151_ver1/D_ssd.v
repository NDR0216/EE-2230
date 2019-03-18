`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/15 16:24:46
// Design Name: 
// Module Name: D_ssd
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

`define SS_0 8'b00000011
`define SS_1 8'b10011111
`define SS_2 8'b00100101
`define SS_3 8'b00001101
`define SS_4 8'b10011001
`define SS_5 8'b01001001
`define SS_6 8'b01000001
`define SS_7 8'b00011111
`define SS_8 8'b00000001
`define SS_9 8'b00001001
`define SS_A 8'b00010001
`define SS_B 8'b11000001
`define SS_C 8'b01100011
`define SS_D 8'b10000101
`define SS_E 8'b01100001
`define SS_F 8'b01110001
`define SS_G 8'b00001000
`define SS_S 8'b11111101
`define SS_M 8'b10010011
`define SS_null 8'b11111111

module D_ssd(
    output reg [7:0] D_ssd,
    input [4:0] i
    );
    
    always @*
        case(i)
            5'd0: D_ssd = `SS_0;
            5'd1: D_ssd = `SS_1;
            5'd2: D_ssd = `SS_2;
            5'd3: D_ssd = `SS_3;
            5'd4: D_ssd = `SS_4;
            5'd5: D_ssd = `SS_5;
            5'd6: D_ssd = `SS_6;
            5'd7: D_ssd = `SS_7;
            5'd8: D_ssd = `SS_8;
            5'd9: D_ssd = `SS_9;
            5'd10 : D_ssd = `SS_A;
            5'd11 : D_ssd = `SS_B;
            5'd12 : D_ssd = `SS_C;
            5'd13 : D_ssd = `SS_D;
            5'd14 : D_ssd = `SS_E;
            5'd15 : D_ssd = `SS_F;
            5'd16 : D_ssd = `SS_G;
            5'd17 : D_ssd = `SS_S;
            5'd18 : D_ssd = `SS_M;
            default: D_ssd = `SS_null;
        endcase
    
endmodule
