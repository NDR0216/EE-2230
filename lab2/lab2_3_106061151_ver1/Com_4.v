`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/15 17:04:21
// Design Name: 
// Module Name: Com_4
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


module Com_4(
    input [3:0] ai,
    input [3:0] bi,
    output [3:0] ao,
    output [3:0] bo,
    output X
    );
    
    reg X;
    
    assign ao = ai;
    assign bo = bi;
    
    always @*
    begin
    if(ai>bi)
        X = 1;
    else
        X = 0;
    end
    
endmodule
