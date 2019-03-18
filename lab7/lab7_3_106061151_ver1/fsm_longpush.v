`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/12 00:36:48
// Design Name: 
// Module Name: fsm_longpush
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


module fsm_longpush(
    output reg longpush,
    input button,
    input clk,
    input rst_n
    );
    
    reg  state;
    
    always @(posedge clk or negedge rst_n)
    begin
        if(rst_n == 0)
            state <= 1'b0;
        else 
            state <= button;
            longpush <= state & button;
    end
    
endmodule
