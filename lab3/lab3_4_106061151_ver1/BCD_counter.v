`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/22 19:28:28
// Design Name: 
// Module Name: BCD_counter
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


module BCD_counter(
    output reg [3:0] BCD,
    input clk,
    input rst_n
    );
    
     reg [3:0] d;
       
     always @(posedge clk or negedge rst_n)
     begin
         if(rst_n == 0)
            BCD <= 4'b0000;
         else if(d == 4'b1010)
            BCD <= 4'b0000;
         else
            BCD <= d;
       end
       
       always @*
           d = BCD + 1;
       
    
endmodule
