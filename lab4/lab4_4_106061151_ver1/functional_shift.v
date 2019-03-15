`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/29 02:05:33
// Design Name: 
// Module Name: functional_shift
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


module functional_shift(
    output reg [3:0] out,
    input [3:0] in,
    input direction
    );
    
    always @*
    begin
        if(direction == 1)
            out = {in[2:0], 1'b0}; 
        else
            out = {1'b0, in[3:1]};
    end
    
endmodule
