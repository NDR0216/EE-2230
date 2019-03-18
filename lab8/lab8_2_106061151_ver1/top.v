`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/03 02:50:02
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
    output mclk,
    output lrclk,
    output sck,
    output sdin,
    output [7:0] ssd,
    output [3:0] ssd_ctl,
    input C,
    input D,
    input E,
    input up,
    input down,
    input clk,
    input rst_n_init
    );
    
    wire clk_100hz;
    wire [1:0] clk_ctl;
    wire debounce_up, one_pulse_up;
    wire debounce_down, one_pulse_down;
    wire [15:0] audio_l, audio_r;
    reg [3:0] note;
    wire [3:0] level;
    wire [3:0] value1, value0;
    wire [3:0] BCD;
    
    freq_div U0 (, clk_100hz, , , clk_ctl, clk, rst_n_init);
    debounce U1 (debounce_up, up, clk_100hz, rst_n_init);
    debounce U2 (debounce_down, down, clk_100hz, rst_n_init);
    one_pulse U3 (one_pulse_up, debounce_up, clk_100hz, rst_n_init);
    one_pulse U4 (one_pulse_down, debounce_down, clk_100hz, rst_n_init);
    level U5 (level, one_pulse_up, one_pulse_down, clk_100hz, rst_n_init);
    note U6 (audio_l, audio_r, note, level, clk, rst_n_init);
    speaker U7 (mclk, lrclk, sck, sdin, audio_l, audio_r, clk, rst_n_init);
    BCD_binary U8 (value1, value0, level);
    scan_ctl U9 (BCD, ssd_ctl, 4'd0, 4'd0, value1, value0, clk_ctl);
    D_ssd U10 (ssd, BCD);
    
    always @*
    begin
        if(C == 1'b1)
            note = 4'd1;
        else if(D == 1'b1)
            note = 4'd2;
        else if(E == 1'b1)
            note = 4'd3;
        else
            note = 4'd0;
    end
    
endmodule
