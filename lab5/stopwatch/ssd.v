`timescale 1ns / 1ps
`include "global.v"
module ssd(
  display, // 7-segment display output
  in  // binary input
);
output [`SSD_BIT_WIDTH-1:0] display; // 7-segment display out
input [`BCD_BIT_WIDTH-1:0] in; // binary input

reg [`SSD_BIT_WIDTH-1:0] display; 

// Combinatioanl Logic
always @(in)
  case (in)
    `BCD_BIT_WIDTH'd0: display = `SSD_ZERO;
	 `BCD_BIT_WIDTH'd1: display = `SSD_ONE;
	 `BCD_BIT_WIDTH'd2: display = `SSD_TWO;
	 `BCD_BIT_WIDTH'd3: display = `SSD_THREE;
	 `BCD_BIT_WIDTH'd4: display = `SSD_FOUR;
	 `BCD_BIT_WIDTH'd5: display = `SSD_FIVE;
	 `BCD_BIT_WIDTH'd6: display = `SSD_SIX;
	 `BCD_BIT_WIDTH'd7: display = `SSD_SEVEN;
	 `BCD_BIT_WIDTH'd8: display = `SSD_EIGHT;
	 `BCD_BIT_WIDTH'd9: display = `SSD_NINE;
	 `BCD_BIT_WIDTH'd10: display = `SSD_A;
	 `BCD_BIT_WIDTH'd11: display = `SSD_B;
	 `BCD_BIT_WIDTH'd12: display = `SSD_C;
	 `BCD_BIT_WIDTH'd13: display = `SSD_D;
	 `BCD_BIT_WIDTH'd14: display = `SSD_E;
	 `BCD_BIT_WIDTH'd15: display = `SSD_F;
	 default: display = `SSD_DEF;
  endcase
  
endmodule
