`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/22 17:43:43
// Design Name: 
// Module Name: counter_4_1hz
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


module counter_4_1hz(
    output [3:0] b,
    input clk,
    input rst_n
    );
    
    wire clk_out;
    
    freq_div_1hz U0 (clk_out, , clk, rst_n);
    counter_4 U1 (b, clk_out, rst_n);
    
endmodule
