`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/07 03:55:38
// Design Name: 
// Module Name: LFSR_16bits
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


module LFSR_16bits(
    output [3:0] Y,
    input clk,
    input rst_n
    );
    
    reg [15:0] Q;
    wire [15:0] next_Q;
    
    assign Y = Q[15:12];
    
    assign next_Q = {Q[14:0], Q[3]^Q[12]^Q[14]^Q[15]};
    
    always @(posedge clk or negedge rst_n)
    begin
        if(rst_n == 0)
            Q <= 16'b1111111111111111;
        else
            Q <= next_Q; 
    end
    
endmodule
