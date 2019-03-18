`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/25 19:21:53
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
    input start_stop,
    input lap_rst_n,
    input rst_n_init,
    input clk
    );
    
    wire clk_1hz, clk_100hz;
    wire [1:0] clk_ctl;
    wire start_stop_debounce, start_stop_one_pulse;
    wire lap, lap_rst_n_debounce, lap_rst_n_one_pulse;
    wire en;    
    wire carry;    
    wire rst;
    wire [3:0] sec1, sec0, min1, min0;
    wire [3:0] value0, value1, value2, value3;
    wire [3:0] BCD;
    
    freq_div U0 (clk_1hz, clk_100hz, , , clk_ctl, clk, rst_n_init);
    debounce U1 (start_stop_debounce, start_stop, clk_100hz, rst_n_init);
    debounce U2 (lap_rst_n_debounce, lap_rst_n, clk_100hz, rst_n_init);
    one_pulse U3 (start_stop_one_pulse, start_stop_debounce, clk_100hz, rst_n_init);
    one_pulse U4 (lap_rst_n_one_pulse, lap_rst_n_debounce, clk_100hz, rst_n_init);
    fsm_button U5 (en, start_stop_one_pulse, clk_100hz, ~rst);
    fsm_button U6 (lap, lap_rst_n_one_pulse, clk_100hz, ~rst);
    fsm_longpush U7 (rst, lap_rst_n_debounce, clk_1hz, rst_n_init);
    BCD_counter_2bit U8 (sec1, sec0, carry, 4'd0, 4'd0, 4'd5, 4'd9, clk_1hz, ~rst, en);
    BCD_counter_2bit U9 (min1, min0, , 4'd0, 4'd0, 4'd5, 4'd9, clk_1hz, ~rst, carry);
    load_reg U10 (value0, sec0, lap, clk_100hz, rst_n_init);
    load_reg U11 (value1, sec1, lap, clk_100hz, rst_n_init);
    load_reg U12 (value2, min0, lap, clk_100hz, rst_n_init);
    load_reg U13 (value3, min1, lap, clk_100hz, rst_n_init);
    scan_ctl U14 (BCD, ssd_ctl, value3, value2, value1, value0, clk_ctl);
    D_ssd U15 (ssd, BCD);
    
endmodule
