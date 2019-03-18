`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/26 18:37:12
// Design Name: 
// Module Name: fsm_longpush_state
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


module fsm_longpush_state(
    output state,
    input in,
    input clk,
    input rst_n
    );
    
    wire longpush;
    wire one_pulse;
    
    fsm_longpush U0 (longpush, in, clk, rst_n);
    one_pulse U1 (one_pulse, longpush, clk, rst_n);
    fsm_button U2 (state, one_pulse, clk, rst_n);
    
endmodule
