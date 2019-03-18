`timescale 1ns / 1ps
module top(
  clk, // Clock from crystal
  rst_n, //active low reset
  pb_in, //push button input
  led_1, // 1Hz divided clock
  led_pb, // LED display output (push button)
  led_1pulse // LED display output (1 pulse)
);

// Declare I/Os
input clk; // Clock from crystal
input rst_n; //active low reset
input pb_in; //push button input
output led_1; // 1Hz divided clock
output led_pb; // LED display output (push button)
output led_1pulse; // LED display output (1 pulse)

// Declare internal nodes
wire pb_debounced; // push button debounced output

// Clock generator module
clock_generator U_cg(
  .clk(clk), // clock from crystal
  .rst_n(rst_n), // active low reset
  .clk_1(led_1), // generated 1 Hz clock
  .clk_100(clk_100) // generated 100 Hz clock
);

// debounce circuit
debounce_circuit U_dc(
  .clk(clk_100), // clock control
  .rst_n(rst_n), // reset
  .pb_in(pb_in), //push button input
  .pb_debounced(led_pb) // debounced push button output
);

// 1 pulse generation circuit
one_pulse U_op(
  .clk(led_1),  // clock input
  .rst_n(rst_n), //active low reset
  .in_trig(led_pb), // input trigger
  .out_pulse(led_1pulse) // output one pulse 
);

endmodule
