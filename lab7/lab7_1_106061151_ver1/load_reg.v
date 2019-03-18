`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/26 01:22:04
// Design Name: 
// Module Name: load_reg
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


module load_reg(
    output reg [3:0] out,
    input [3:0] in,
    input load_n,
    input clk,
    input rst_n
    );
    
    reg [3:0] next_out;
    
    always @(posedge clk or negedge rst_n)
    begin
        if(rst_n ==0)
            out <= 4'd0;
        else
            out <= next_out;
    end
    
    always @*
    begin
        if(load_n == 0)
            next_out = in;
        else
            next_out = out;
    end
    
endmodule
