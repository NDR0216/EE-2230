`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/22 01:17:31
// Design Name: 
// Module Name: counter_4
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


module counter_4(
    output [3:0] q,
    input clk,
    input rst_n
    );
    
    reg [3:0] d;
    reg [3:0] q;
    
    always @(posedge clk or negedge rst_n)
    begin
        if(rst_n == 0)
            q <= 4'b0000;
        else
            q <= d;
    end
    
    always @*
        d = q + 1;
    
endmodule
