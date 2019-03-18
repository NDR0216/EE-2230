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
    output [15:0] LED,
    input start_hr,
    input pause_min,
    input setting,
    input rst_n_init,
    input clk
    );
    
    wire clk1hz, clk_100hz, clk_100Khz;
    wire [1:0] clk_ctl;
    wire start, hr, start_hr_debounce, start_hr_one_pulse;
    wire pause, min, pause_min_debounce, pause_min_one_pulse;
    wire [3:0] init0, init1, init2, init3;
    wire [3:0] value0, value1, value2, value3;
    wire [3:0] BCD;
    reg zero;
    
    freq_div U0 (clk_1hz, clk_100hz, , clk_100Khz, clk_ctl, clk, rst_n_init);
    debounce U1 (start_hr_debounce, start_hr, clk_100hz, rst_n_init);
    debounce U2 (pause_min_debounce, pause_min, clk_100hz, rst_n_init);
    one_pulse U3 (start_hr_one_pulse, start_hr_debounce, clk_100hz, rst_n_init);
    one_pulse U4 (pause_min_one_pulse, pause_min_debounce, clk_100hz, rst_n_init);
    fsm_button U5 (start, start_hr_one_pulse, clk_100hz, ~setting);
    fsm_button U6 (pause, pause_min_one_pulse, clk_100hz, ~setting & start);
    fsm_longpush U7 (hr, start_hr_debounce, clk_1hz, rst_n_init);
    fsm_longpush U8 (min, pause_min_debounce, clk_1hz, rst_n_init);
    BCD_counter_2bit U9 (init1, init0, , 4'd0, 4'd0, 4'd5, 4'd9, clk_1hz, rst_n_init, min);
    BCD_counter_2bit U10 (init3, init2, , 4'd0, 4'd0, 4'd2, 4'd3, clk_1hz, rst_n_init, hr);
    downcounter_6bit U11 (value3, value2, value1, value0, , , init3, init2, init1, init0, 4'd0, 4'd0, 4'd2, 4'd3, 4'd5, 4'd9, 4'd5, 4'd9, clk_100hz, !setting & start, ~pause & ~zero);
    scan_ctl U12 (BCD, ssd_ctl, value3, value2, value1, value0, clk_ctl);
    D_ssd U13 (ssd, BCD);
    
    always @*
    begin
        if(value3 == 4'd0 && value2 == 4'd0 && value1 == 4'd0 && value0 == 4'd0)
            zero = 1'b1;
        else
            zero = 1'd0;
    end
    
    assign LED = {16{zero}};
    
endmodule
