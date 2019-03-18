`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/18 00:22:52
// Design Name: 
// Module Name: BCD_counter_4bit
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


module BCD_counter_4bit(
    output [3:0] value3,
    output [3:0] value2,
    output [3:0] value1,
    output [3:0] value0,
    input [3:0] init3,
    input [3:0] init2,
    input [3:0] init1,
    input [3:0] init0,
    input [3:0] limit3,
    input [3:0] limit2,
    input [3:0] limit1,
    input [3:0] limit0,
    input clk,
    input rst_n,
    input en
    );
    
    wire [2:0] carry;
    
    BCD_counter U0 (value0, carry[0], init0, limit0, clk, rst_n, en);
    BCD_counter U1 (value1, carry[1], init1, limit1, clk, rst_n, carry[0]);
    BCD_counter U2 (value2, carry[2], init2, limit2, clk, rst_n, carry[1]);
    BCD_counter U3 (value3, , init3, limit3, clk, rst_n, carry[2]);
    
endmodule
