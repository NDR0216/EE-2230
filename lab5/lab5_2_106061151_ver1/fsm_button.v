`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/10 22:06:17
// Design Name: 
// Module Name: fsm_button
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


module fsm_button(
    output reg state,
    input button,
    input clk,
    input rst_n
    );
    
    wire next_state;
    
    assign next_state = state ^ button;
    
    always @(posedge clk or negedge rst_n)
    begin
        if(rst_n == 0)
            state <= 1'b0;
        else
            state <= next_state;
    end
    
endmodule
