`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/23 21:20:41
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
    output [7:0] D_ssd,
    output [3:0] ssd_ctl,
    input clk,
    input rst_n
    );
    
    wire clk_out;
    wire [1:0] clk_ctl;
    wire [7:0] cnt;
    wire [3:0] ssd;
    reg rst_n_freq;
    
    freq_div_1hz U0 (clk_out, clk_ctl,clk, rst_n_freq);
    counter_down_30 U1 (cnt, clk_out, rst_n);
    scan_ctl U2 (ssd, ssd_ctl, 0, 0, cnt[7:4], cnt[3:0], {1, clk_ctl[0]});
    D_ssd U3 (D_ssd, ssd);
    
    initial
    begin
        rst_n_freq = 1;
        #10 rst_n_freq = 0;
        #10 rst_n_freq = 1;
    end
    
endmodule
