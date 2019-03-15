`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/29 02:19:34
// Design Name: 
// Module Name: barrel_shift
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


module barrel_shift(
    output reg [3:0] out,
    input [3:0] in,
    input direction
    );
    
    always @*
    begin
    if(direction == 1)
        out = {in[2:0], in[3]}; 
    else
        out = {in[0], in[3:1]};
    end
    
endmodule
