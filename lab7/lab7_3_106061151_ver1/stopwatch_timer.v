`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/26 17:02:19
// Design Name: 
// Module Name: stopwatch_timer
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


module stopwatch_timer(
    output [7:0] ssd,
    output [3:0] ssd_ctl,
    output [15:0] LED,
    input start_hr,
    input pause_min,
    input mode_setting,
    input rst_n_init,
    input clk
    );
    
    wire clk1hz, clk_100hz;
    wire [1:0] clk_ctl;
    wire start, hr, start_hr_debounce, start_hr_one_pulse;
    wire pause, min, pause_min_debounce, pause_min_one_pulse;
    wire mode, setting, set_longpush, mode_setting_debounce, mode_setting_one_pulse;
    wire [3:0] min1, min0, sec1, sec0;
    wire [3:0] init0, init1, init2, init3;
    wire [3:0] sw3, sw2, sw1, sw0;
    wire [3:0] timer3, timer2, timer1, timer0;
    reg [3:0] value0, value1, value2, value3;
    wire [3:0] BCD;
    wire carry;
    reg zero;
    
    freq_div U0 (clk_1hz, clk_100hz, , , clk_ctl, clk, rst_n_init);
    debounce U1 (start_hr_debounce, start_hr, clk_100hz, rst_n_init);
    debounce U2 (pause_min_debounce, pause_min, clk_100hz, rst_n_init);
    debounce U3 (mode_setting_debounce, mode_setting, clk_100hz, rst_n_init);
    one_pulse U4 (start_hr_one_pulse, start_hr_debounce, clk_100hz, rst_n_init);
    one_pulse U5 (pause_min_one_pulse, pause_min_debounce, clk_100hz, rst_n_init);
    one_pulse U6 (mode_setting_one_pulse, mode_setting_debounce, clk_100hz, rst_n_init);
    fsm_button U7 (start, start_hr_one_pulse, clk_100hz, ~setting);
    fsm_button U8 (pause, pause_min_one_pulse, clk_100hz, ~setting & start);
    fsm_button U9 (mode, mode_setting_one_pulse, clk_100hz, rst_n_init);
    fsm_longpush U10 (hr, start_hr_debounce, clk_1hz, rst_n_init);
    fsm_longpush U11 (min, pause_min_debounce, clk_1hz, rst_n_init);
    fsm_longpush_state U12 (setting, mode_setting_debounce, clk_1hz, rst_n_init);
    BCD_counter_2bit U14 (sec1, sec0, carry, 4'd0, 4'd0, 4'd5, 4'd9, clk_1hz, ~setting, start);
    BCD_counter_2bit U15 (min1, min0, , 4'd0, 4'd0, 4'd5, 4'd9, clk_1hz, ~setting, carry);
    load_reg U16 (sw0, sec0, pause, clk_100hz, rst_n_init);
    load_reg U17 (sw1, sec1, pause, clk_100hz, rst_n_init);
    load_reg U18 (sw2, min0, pause, clk_100hz, rst_n_init);
    load_reg U19 (sw3, min1, pause, clk_100hz, rst_n_init);
    BCD_counter_2bit U20 (init1, init0, , 4'd0, 4'd0, 4'd5, 4'd9, clk_1hz, rst_n_init, min);
    BCD_counter_2bit U21 (init3, init2, , 4'd0, 4'd0, 4'd2, 4'd3, clk_1hz, rst_n_init, hr);
    downcounter_6bit U22 (timer3, timer2, timer1, timer0, , , init3, init2, init1, init0, 4'd0, 4'd0, 4'd2, 4'd3, 4'd5, 4'd9, 4'd5, 4'd9, clk_100hz, ~setting & start, ~pause & ~zero);
    scan_ctl U23 (BCD, ssd_ctl, value3, value2, value1, value0, clk_ctl);
    D_ssd U24 (ssd, BCD);
       
    always @*
    begin
        if(setting == 1'b1)
        begin
            value3 = init3;
            value2 = init2;
            value1 = init1;
            value0 = init0;
        end
        else if(mode == 1'd0)
        begin
            value3 = sw3;
            value2 = sw2;
            value1 = sw1;
            value0 = sw0;
        end
        else
        begin
            value3 = timer3;
            value2 = timer2;
            value1 = timer1;
            value0 = timer0;
        end
        
        if(value3 == 4'd0 && value2 == 4'd0 && value1 == 4'd0 && value0 == 4'd0)
            zero = 1'b1;
        else
            zero = 1'd0;
    end
    
    assign LED = {{14{zero}} & {14{mode}}, setting, mode};
  
endmodule
