`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/08 01:20:16
// Design Name: 
// Module Name: Dec38
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


module Dec38(
    input [2:0] in,
    input en,
    output [7:0] d
    );
    
    assign d[0] = en & ~in[2] & ~in[1] & ~in[0];
    assign d[1] = en & ~in[2] & ~in[1] & in[0];
    assign d[2] = en & ~in[2] & in[1] & ~in[0];
    assign d[3] = en & ~in[2] & in[1] & in[0];
    assign d[4] = en & in[2] & ~in[1] & ~in[0];
    assign d[5] = en & in[2] & ~in[1] & in[0];
    assign d[6] = en & in[2] & in[1] & ~in[0];
    assign d[7] = en & in[2] & in[1] & in[0];
    
endmodule
