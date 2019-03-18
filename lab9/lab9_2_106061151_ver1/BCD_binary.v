`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/03 03:23:24
// Design Name: 
// Module Name: BCD_binary
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


module BCD_binary(
    output reg [3:0] BCD1,
    output reg [3:0] BCD0,
    input [4:0] binary
    );
    
    always @*
    begin
        if(binary <= 5'd9)
        begin
            BCD1 = 4'd0;
            BCD0 = binary;
        end
        else
            {BCD1, BCD0} = binary + 5'd6;
    end
endmodule
