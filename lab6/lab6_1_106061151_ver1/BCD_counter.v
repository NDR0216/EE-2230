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
    output reg carry,
    input [3:0] init,
    input [3:0] limit,
    input clk,
    input rst_n,
    input en
    );
    
    reg [3:0] next_BCD;
    reg next_carry;
    
    always @(posedge clk or negedge rst_n)
    begin
        if(rst_n == 0)
        begin
            BCD <= init;
            carry <= next_carry;
        end
        else
        begin
            BCD <= next_BCD;
            carry <= next_carry;
        end
    end
       
    always @*
    begin
        if(en == 1'b0)
        begin
            next_BCD = BCD;
            next_carry = 1'b0;
        end
        else if(BCD == limit)
        begin
            next_BCD = init;
            next_carry = 1'b1;
        end
        else
        begin
            next_BCD = BCD + 1'b1;
            next_carry = 1'b0;
        end
    end
       
endmodule
