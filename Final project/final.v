`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/12 22:37:08
// Design Name: 
// Module Name: final
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


module final(
    input clk,
    input rst,
    input show,
    input switch,
    input acc,
    inout ps2_data,
    inout ps2_clk,
    output [15:0] led,
    output [7:0] ssd,
    output [3:0] ssd_ctl,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue,
    output hsync,
    output vsync,
    output mclk,
    output lrclk,
    output sclk,
    output sd_in
    );
    wire b_switch, b_acc, switch_pulse, acc_pulse;
    wire player;
    wire clk_32;
    wire [15:0] led_temp;
    wire [4:0] str;
    wire valid;
    wire [5:0] x, y, score0, score1;
    wire [511:0] key_down;
    wire key_valid;
    wire [8:0] last_change;
    wire [3:0] d1, d2, d3, d4;
    wire valid_pulse;
    wire endgame;
    wire [3:0] round;
    wire [2:0] winner;
    wire mclk_temp, sclk_temp, lrclk_temp, bclk;
    assign led = {led_temp};
    assign mclk = mclk_temp;
    assign sclk = sclk_temp;
    assign lrclk = lrclk_temp;
    assign d1 = (show == 0)?score0/10:x/10;
    assign d2 = (show == 0)?score0%10:x%10;
    assign d3 = (show == 0)?score1/10:y/10;
    assign d4 = (show == 0)?score1%10:y%10;
    button U0(.clk(clk),.in(switch),.out(b_switch));
    button U1(.clk(clk),.in(acc),.out(b_acc));
    one_pulse U2(.clk(clk),.in(b_switch),.pulse(switch_pulse));
    back_pulse U3(.clk(clk),.in(b_acc),.pulse(acc_pulse));
    state U4(.clk(clk),.rst(rst),.in(switch_pulse),.en(player));
    back_pulse valid_back_pulse(.clk(clk),.in(valid),.pulse(valid_pulse));
    
    KeyboardDecoder Keyboard(
    .key_down(key_down),
    .last_change(last_change),
    .key_valid(key_valid),
    .PS2_DATA(ps2_data),
    .PS2_CLK(ps2_clk),
    .rst(rst),
    .clk(clk)
    );
    
    frequency_divider clk_32HZ(
    .clk(clk),
    .clk_32(clk_32)
    );
    
    dart_shoot U5(
    .clk_32(clk_32),
    .rst(rst),
    .switch(switch_pulse),
    .acc_pulse(acc_pulse),
    .acc(b_acc),
    .led(led_temp),
    .str(str),
    .valid(valid)
    );
    
    aim U6(
    .clk(clk),
    .rst(rst),
    .switch(switch_pulse),
    .acc(b_acc),
    .valid(valid),
    .key_down(key_down),
    .key_valid(key_valid),
    .last_change(last_change),
    .str(str),
    .x_temp(x),
    .y_temp(y)
    );
    
    score_calculate U7(
    .x(x),
    .y(y),
    .rst(rst),
    .player(player),
    .valid_pulse(valid_pulse),
    .score0(score0),
    .score1(score1)
    );
    
    ssd U8(
    .clk(clk),
    .player(player),
    .d1(d1),
    .d2(d2),
    .d3(d3),
    .d4(d4),
    .ssd(ssd),
    .ssd_ctl(ssd_ctl)
    );
    
    judge_winner U9(
    .switch(switch_pulse),
    .rst(rst),
    .player(player),
    .score0(score0),
    .score1(score1),
    //.round(round),
    .endgame(endgame),
    .winner(winner)
    );
    
    speaker U10(
    .clk(clk),
    .rst(rst),
    .back_pulse(acc_pulse),
    .mclk(mclk_temp),
    .sclk(sclk_temp),
    .lrclk(lrclk_temp),
    .bclk(bclk),
    .sd_in(sd_in)
    );
    
    top U11 (clk, rst, x[4:0], y, ~valid, winner, endgame, vgaRed, vgaGreen, vgaBlue, hsync, vsync);
    
endmodule
