`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/22 19:33:38
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
    input clk,
    input rst_n
    );
    
    wire clk_out;
    wire [3:0] BCD;
    
    freq_div_1hz U0 (clk_out, , clk, rst_n);
    BCD_counter U1 (BCD, clk_out, rst_n);
    D_ssd U2 (ssd, , BCD);
    
endmodule
