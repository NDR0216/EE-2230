//************************************************************************
// Filename      : downcounter.v
// Author        : hp
// Function      : Basic up counter module for digital watch
// Last Modified : Date: 2009-03-10
// Revision      : Revision: 1
// Copyright (c), Laboratory for Reliable Computing (LaRC), EE, NTHU
// All rights reserved
//************************************************************************
`include "global.v"
module downcounter(
  value,  // counter value 
  borrow,  // borrow indicator for counter to next stage
  clk, // global clock signal
  rst_n,  // low active reset
  decrease,  // decrease input from previous stage of counter
  init_value,  // initial value for the counter
  limit,  // limit for the counter
  en  // enable/disable of the counter
);

// outputs
output [`BCD_BIT_WIDTH-1:0] value; // counter value
output borrow; // borrow indicator for counter to next stage
// inputs
input clk; // global clock signal
input rst_n; // low active reset
input decrease; // decrease input from previous stage of counter
input [`BCD_BIT_WIDTH-1:0] init_value; // initial value for the counter
input [`BCD_BIT_WIDTH-1:0] limit; // limit for the counter
input en;

reg [`BCD_BIT_WIDTH-1:0] value; // counter value
reg [`BCD_BIT_WIDTH-1:0] value_tmp; // D input for counter register
reg borrow; // borrow indicator for counter to next stage

// combinational part for BCD counter
always @(value or decrease or en or limit)
  if (value == `BCD_ZERO && decrease && en)  // reach limit, go back to 0
  begin
    value_tmp = limit;
    borrow = `ENABLED;
  end
  else if (decrease && en) // count enabled
  begin
    value_tmp = value - `INCREMENT;
    borrow = `DISABLED;
  end
  else if (en) // count disabled
  begin
    value_tmp = value;
    borrow = `DISABLED;
  end
  else
  begin
    value_tmp = `BCD_ZERO;
	 borrow = `DISABLED;
  end

// register part for BCD counter
always @(posedge clk or negedge rst_n)
  if (~rst_n) value <= init_value;
  else value <= value_tmp;

endmodule

