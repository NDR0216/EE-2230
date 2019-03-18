`timescale 1ns / 1ps
`include "global.v"
module binary_counter(
  display,  // 7-segment display
  ssd_ctl, // scan control for 7-segment display
  clk,  // clock from oscillator
  rst_n  // active low reset
);

output [`SSD_BIT_WIDTH-1:0] display; // 7-segment display out
output [`SSD_NUM-1:0] ssd_ctl;
input  clk;  // clock from oscillator
input  rst_n;  // active low reset

wire clk_d; //divided clock
wire [`CNT_BIT_WIDTH-1:0] cnt_out; // Binary counter output
wire [`SSD_SCAN_CTL_BIT_WIDTH-1:0] ssd_ctl_en;
wire [`SSD_NUM-1:0] ssd_ctl;
wire [`CNT_BIT_WIDTH-1:0] ssd_in;

// Frequency Divider
freqdiv27 U_FD0(
  .clk_out(clk_d), //divided clock output
  .clk_ctl(ssd_ctl_en), // divided scan clock for 7-segment display scan
  .clk(clk), // clock from the 40MHz oscillator
  .rst_n(rst_n) // low active reset
);

// Binary Counter
bincnt U_BC(
  .out(cnt_out), //counter output
  .clk(clk_d), // clock
  .rst_n(rst_n) //active low reset
);

// Scan control
scan_ctl U_SC(
  .ssd_ctl(ssd_ctl), // ssd display control signal 
  .ssd_in(ssd_in), // output to ssd display
  .in0(cnt_out), // 1st input
  .in1(4'b1111), // 2nd input
  .in2(4'b1111), // 3rd input
  .in3(4'b1111),  // 4th input
  .ssd_ctl_en(ssd_ctl_en) // divided clock for scan control
);

// binary to 7-segment display decoder
display U_display(
  .display(display), // 7-segment display output
  .in(ssd_in)  // BCD number input
);

endmodule
