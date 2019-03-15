`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/29 00:40:01
// Design Name: 
// Module Name: top
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


module top(
    output [7:0] ssd,
    output [3:0] ssd_ctl,
    input clk,
    input rst_n
    );
    
    wire clk_out;
    wire [1:0] clk_ctl;
    wire [3:0] in0;
    wire [3:0] in1;
    wire [3:0] in2;
    wire [3:0] in3;
    wire [3:0] i;
    
    reg rst_n_freq;
    
    initial
    begin
        rst_n_freq = 1;
        #10 rst_n_freq = 0;
        #10 rst_n_freq = 1;
    end
    
    freq_div_1hz U0 (clk_out, clk_ctl, clk, rst_n_freq);
    shift_register_BCD_6 U1 (in0, in1, in2, in3, , , 0, 1, 2, 3, 4, 4, clk_out, rst_n);
    scan_ctl U2 (i, ssd_ctl, in0, in1, in2, in3, clk_ctl);
    D_ssd_NTHUEE U3 (ssd, i);
    
endmodule
