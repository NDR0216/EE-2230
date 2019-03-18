`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/03 03:07:50
// Design Name: 
// Module Name: level
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


module level(
    output reg [3:0] level,
    input up,
    input down,
    input clk,
    input rst_n
    );
    
    reg [3:0] next_level;
    
    always @(posedge clk or negedge rst_n)
    begin
        if(rst_n == 1'b0)
            level <= 4'd0;
        else
            level <= next_level;
    end
    
    always @*
    begin
        if(up == 1'b1)
            next_level = level + 4'd1;
        else if(down == 1'b1)
            next_level = level - 4'd1;
        else
            next_level = level;
    end
    
endmodule
