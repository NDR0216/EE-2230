`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/15 22:21:29
// Design Name: 
// Module Name: one_pulse
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


module one_pulse(
    input clk,
    input in,
    output reg pulse
    );
    reg in_delay;
    reg out_next;
    always @(posedge clk)
        in_delay <= in;
    always @*
        out_next = in & (~in_delay);
    always @(posedge clk)
        pulse <= out_next;
endmodule
