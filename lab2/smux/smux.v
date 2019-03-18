`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2016 12:42:20 AM
// Design Name: 
// Module Name: smux
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


module smux(
    input a,
    input b,
    input sel,
    output out
    );
    
    assign out = (a&sel) | (b&(~sel));
endmodule
