`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/15 22:24:38
// Design Name: 
// Module Name: state
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


module state(
    input clk,
    input rst,
    input in,
    output reg en
    );
    reg state = 1'b0;
    reg next_state = 1'b0;
    always @*
    begin
        next_state = (in == 1)?(~state):state;
        en = (in == 1)?(~state):state;
    end
    always @(posedge clk or posedge rst)
    if(rst)
        state <= 1'b0;
    else
        state <= next_state;    
endmodule
