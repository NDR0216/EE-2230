`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/12 22:48:10
// Design Name: 
// Module Name: back_pulse
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


module back_pulse(
    input clk,
    input in,
    output reg pulse
    );
    reg in_delay;
    reg out_next;
    always @(posedge clk)
        in_delay <= in;
    always @*
        out_next = (~in) & in_delay;
    always @(posedge clk)
        pulse <= out_next;
endmodule

