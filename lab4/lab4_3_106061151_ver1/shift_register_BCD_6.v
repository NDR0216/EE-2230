`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/29 00:30:06
// Design Name: 
// Module Name: shift_register_BCD_6
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


module shift_register_BCD_6(
    output reg [3:0] BCD_5,
    output reg [3:0] BCD_4,
    output reg [3:0] BCD_3,
    output reg [3:0] BCD_2,
    output reg [3:0] BCD_1,
    output reg [3:0] BCD_0,
    input [3:0] d_5,
    input [3:0] d_4,
    input [3:0] d_3,
    input [3:0] d_2,
    input [3:0] d_1,
    input [3:0] d_0,  
    input clk,
    input rst_n
    );
    
    always @(posedge clk or negedge rst_n)
    begin
        if(rst_n == 0)
        begin
            BCD_5 <= d_5;
            BCD_4 <= d_4;
            BCD_3 <= d_3;
            BCD_2 <= d_2;
            BCD_1 <= d_1;
            BCD_0 <= d_0;
        end
        else
        begin
            BCD_5 <= BCD_4;
            BCD_4 <= BCD_3;
            BCD_3 <= BCD_2;
            BCD_2 <= BCD_1;
            BCD_1 <= BCD_0;
            BCD_0 <= BCD_5;
        end
    end
    
endmodule
