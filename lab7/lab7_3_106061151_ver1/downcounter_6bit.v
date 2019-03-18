`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/26 15:50:45
// Design Name: 
// Module Name: downcoumter_4bit
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


module downcounter_6bit(
    output [3:0] value5,
    output [3:0] value4,
    output [3:0] value3,
    output [3:0] value2,
    output [3:0] value1,
    output [3:0] value0,
    input [3:0] init5,
    input [3:0] init4,
    input [3:0] init3,
    input [3:0] init2,
    input [3:0] init1,
    input [3:0] init0,
    input [3:0] limit5,
    input [3:0] limit4,
    input [3:0] limit3,
    input [3:0] limit2,
    input [3:0] limit1,
    input [3:0] limit0,
    input clk, 
    input rst_n,
    input en
    );
    
    wire [4:0] borrow;
    
    downcounter U0 (value0, borrow[0], init0, limit0, clk, rst_n, en);
    downcounter U1 (value1, borrow[1], init1, limit1, clk, rst_n, borrow[0]);
    downcounter U2 (value2, borrow[2], init2, limit2, clk, rst_n, borrow[1]);
    downcounter U3 (value3, borrow[3], init3, limit3, clk, rst_n, borrow[2]);
    downcounter U4 (value4, borrow[4], init4, limit4, clk, rst_n, borrow[3]);
    downcounter U5 (value5, , init5, limit5, clk, rst_n, borrow[4]);
    
endmodule
