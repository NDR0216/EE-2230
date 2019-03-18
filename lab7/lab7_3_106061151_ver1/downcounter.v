`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/10 22:36:17
// Design Name: 
// Module Name: downcounter
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


module downcounter(
    output reg [3:0] value,
    output reg borrow,
    input [3:0] init,
    input [3:0] limit,
    input clk,
    input rst_n,
    input en
    );
    
    reg [3:0] next_value;
    
    always @(posedge clk or negedge rst_n)
    begin
        if(rst_n == 0)
            value <= init;
        else
            value <= next_value;
    end
    
    always @*
    begin
        if(en == 0)
        begin
            next_value = value;
            borrow = 1'b0;
        end
        else if(value == 4'b0)
        begin
            next_value = limit;
            borrow = 1'b1;
        end
        else
        begin
            next_value = value - 1'b1;
            borrow = 1'b0;
        end
    end
    
endmodule
