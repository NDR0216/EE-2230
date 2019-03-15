`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/08 00:29:58
// Design Name: 
// Module Name: decimal_adder
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


module decimal_adder(
    input [3:0] a,
    input [3:0] b,
    input ci,
    output reg [3:0] s,
    output reg co
    );
    
    always @*
    begin
    if(a + b + ci <= 5'd9)
        {co,s} = a+b+ci; 
    else
        {co,s} = a+b+ci+5'd6; 
    end
endmodule
