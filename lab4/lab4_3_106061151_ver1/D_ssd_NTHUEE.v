`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/29 00:19:10
// Design Name: 
// Module Name: D_ssd_NTHUEE
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

`define SS_N 8'b11010101
`define SS_T 8'b11100001
`define SS_H 8'b10010001
`define SS_U 8'b10000011
`define SS_E 8'b01100001
`define SS_F 8'b01110001

module D_ssd_NTHUEE(
    output reg [7:0] ssd,
    input [3:0] i
    );
    
    always @*
    begin
        case(i)
            4'd0 : ssd = `SS_N;
            4'd1 : ssd = `SS_T;
            4'd2 : ssd = `SS_H;
            4'd3 : ssd = `SS_U;
            4'd4 : ssd = `SS_E;
            default: ssd = `SS_F;
        endcase
    end
    
endmodule
