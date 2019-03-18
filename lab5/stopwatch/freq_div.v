`timescale 1ns / 1ps
`include "global.v"
module freq_div(
  clk_out, // divided clock output
  clk_ctl, // divided clock for seven-segment display scan
  clk, // clock from the crystal
  rst_n // low active reset
);

output clk_out; // divided clock output
output [`SSD_SCAN_CTL_BIT_WIDTH-1:0] clk_ctl; // divided clock for seven-segment display scan
input clk; // clock from the crystal
input rst_n; // low active reset

reg clk_out; // divided clock output (in the always block)
reg [`SSD_SCAN_CTL_BIT_WIDTH-1:0] clk_ctl; // divided clock for seven-segment display scan (in the always block)
reg [14:0] cnt_l; // temperatory buffer
reg [8:0] cnt_h; // temperatory buffer
reg [`FREQ_DIV_BIT-1:0] cnt_tmp; // input node to flip flops

// Combinational block : increase by 1 neglecting overflow
always @(clk_out or cnt_h or cnt_l or clk_ctl)
  cnt_tmp = {clk_out,cnt_h,clk_ctl,cnt_l} + `INCREMENT;

// Sequential block 
always @(posedge clk or negedge rst_n) 
  if (~rst_n) 
	 {clk_out,cnt_h,clk_ctl,cnt_l} <= `FREQ_DIV_BIT'b0; 
  else 
	 {clk_out,cnt_h,clk_ctl,cnt_l} <= cnt_tmp;

endmodule
