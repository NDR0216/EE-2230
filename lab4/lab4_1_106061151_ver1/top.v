`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/27 21:27:39
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
    output [7:0] q,
    input clk,
    input rst_n
    );
    
    wire clk_out;
    
    freq_div_1hz U0 (clk_out, , clk, rst_n);
    shift_register_8 U1 (q, clk_out, rst_n);
    
endmodule
