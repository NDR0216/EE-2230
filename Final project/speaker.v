`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/21 02:23:49
// Design Name: 
// Module Name: speaker_clk_divisor
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

`define D 26'd170648
`define B_high 26'd50607


module speaker(
    input clk,
    input rst,
    input back_pulse,
    output sclk,
    output lrclk,
    output mclk,
    output bclk,
    output reg sd_in
    );
    reg [1:0]f_m = 2'b0; 
    reg [3:0] f_s = 3'd0; 
    reg [8:0]f_lr = 9'd0;
    reg [25:0]f_b = 26'd0;
    reg [25:0]f = 26'd0;
    reg [25:0]note;
    reg mclk = 1'b0; reg sclk = 1'b0; reg lrclk = 1'b0; reg bclk= 1'b0; reg clk_1s = 1'b0;
    reg [9:0] v;
    reg en;
    reg note_sel;
    reg [15:0] left, right;
    reg [3:0] c;
    always@(posedge clk or posedge rst)
    if(rst)
    begin
        f_m <= 2'd0;
        f_s <= 4'd0;
        f_lr <= 9'd0;
    end
    else
    begin
        f_m <= f_m + 1'b1;
        f_s <= f_s + 1'b1;
        f_lr <= f_lr + 1'b1;
    end
    always@*
    begin
    mclk <= f_m[1];
    sclk <= f_s[3];
    lrclk <= f_lr[8];
    end
    
    always@(posedge clk or posedge rst)
    if(rst)
        en <= 1'b0;
    else if(f > 26'd12500000)
        en <= 1'b0;
    else if(f <= 26'd12500000)
        en <= 1'b1;
        
    always@(posedge clk or posedge rst)
    if(rst)
        f <= 26'd25000000;
    else if(f == 26'd12500000)
        f <= 26'd25000000;
    else if(back_pulse)
        f <= 26'd1;
    else if(f <= 26'd12500000)
        f <= f + 1'b1;
        
    always@*
    if(1 <= f && f <= 26'd6250000)
        note_sel = 1'b0;
    else if(26'd6250000 < f && f <= 26'd12500000)
        note_sel = 1'b1;
    else note_sel = 1'b0;
    
    always@*
    note = (note_sel)?`B_high:`D;
    
    always@(posedge clk or posedge rst)
    if(rst)
    begin
       bclk <= 1'b0;
       f_b <= 26'd0;
   end
   else if(f_b >= note)
   begin
       f_b <= 26'd0;
       bclk <= ~bclk;
   end
   else if(en)
       f_b <= f_b + 1'b1;
       
       
    always@*
       begin
       left = (bclk == 1'b1)?16'h0FFA:16'hB000;
       right = (bclk == 1'b1)?16'h0FFA:16'hB000;
       end
       
       always@(posedge sclk or posedge rst)
       if(rst)
       begin
           c <= 4'd15;
           sd_in <= 1'b0;
       end
       else if(en)
       begin
           sd_in <= (lrclk == 1'b1)?right[c]:left[c];
           c <= c - 1'b1;;
       end
endmodule
