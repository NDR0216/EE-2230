`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/12 01:13:05
// Design Name: 
// Module Name: downcounter_3bit
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


module downcounter_3bit(
    output [3:0] value2,
    output [3:0] value1,
    output [3:0] value0,
    input [3:0] init2,
    input [3:0] init1,
    input [3:0] init0,
    input [3:0] limit2,
    input [3:0] limit1,
    input [3:0] limit0,
    input clk,
    input rst_n,
    input en
    );
    
    wire [1:0] borrow;
    
    downcounter U0 (value0, borrow[0], init0, limit0, clk, rst_n, en);
    downcounter U1 (value1, borrow[1], init1, limit1, clk, rst_n, borrow[0]);
    downcounter U2 (value2, , init2, limit2, clk, rst_n, borrow[1]);
    
endmodule
