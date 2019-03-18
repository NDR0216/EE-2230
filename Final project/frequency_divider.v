`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/12 23:17:49
// Design Name: 
// Module Name: frequency_divider
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


module frequency_divider(
    input clk,
    output clk_32
    );
    reg [20:0] f = 21'd0;
    reg clk_32 = 0;
    always@(posedge clk)
    if(f == 21'd781250)
    begin
        f <= 21'd0;
        clk_32 = ~clk_32;
    end
    else
        f <= f + 1'b1;
endmodule
