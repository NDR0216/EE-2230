`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/15 22:16:57
// Design Name: 
// Module Name: button
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


module button(
    input clk,
    input in,
    output reg out
    );
    reg next = 1'b0;
    reg [3:0]trigger = 4'b0000;
    always@(posedge clk)
        trigger <= {trigger[2:0], in};
    always@*
    if(trigger == 4'b1111)
        next = 1'b1;
    else 
        next = 1'b0;
    always@(posedge clk)
        out <= next;  
    
endmodule
