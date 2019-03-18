`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/19 17:59:02
// Design Name: 
// Module Name: BCD_counter_2bit
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

module BCD_counter_2bit(
    output [3:0] value1,
    output [3:0] value0,
    output cout,
    input [3:0] init1,
    input [3:0] init0,
    input [3:0] limit1,
    input [3:0] limit0,
    input clk,
    input rst_n,
    input en
    );
    
    reg [3:0] limit0_temp;
    wire carry;
    
    BCD_counter U0 (value0, carry, init0, limit0_temp, clk, rst_n, en);
    BCD_counter U1 (value1, cout, init1, limit1, clk, rst_n, carry);
    
    always @*
    begin
        if(value1 == limit1)
            limit0_temp = limit0;
        else
            limit0_temp = 4'd9;
    end
    
endmodule
