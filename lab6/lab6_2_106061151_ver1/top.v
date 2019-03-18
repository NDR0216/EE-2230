`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/19 01:10:18
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
    output reg [4:0] LED,
    input mode,
    input [2:0] state,
    input clk,
    input rst_n
    );
    
    wire clk_100Khz;
    wire [1:0] clk_ctl;
    wire [3:0] sec1;
    wire [3:0] sec0;    
    wire [3:0] min1;
    wire [3:0] min0;
    wire [3:0] hr1_24;
    wire [3:0] hr0_24;
    reg [3:0] hr1;
    reg [3:0] hr0;
    wire [3:0] month1;
    wire [3:0] month0;
    wire [3:0] day1;
    wire [3:0] day0;
    wire [3:0] yr3;
    wire [3:0] yr2;
    wire [3:0] yr1;
    wire [3:0] yr0;    
    wire [3:0] carry;
    reg [3:0] value3;
    reg [3:0] value2;
    reg [3:0] value1;
    reg [3:0] value0;

    wire [3:0] BCD;
    
    freq_div U0 ( , , , clk_100Khz, clk_ctl, clk, rst_n);
    BCD_counter_2bit U1 (sec1, sec0, carry[0], 4'd0, 4'd0, 4'd5, 4'd9, clk_100Khz, rst_n, 1'd1);
    BCD_counter_2bit U2 (min1, min0, carry[1], 4'd0, 4'd0, 4'd5, 4'd9, clk_100Khz, rst_n, carry[0]);
    BCD_counter_2bit U3 (hr1_24, hr0_24, carry[2], 4'd0, 4'd0, 4'd2, 4'd3, clk_100Khz, rst_n, carry[1]);
    date U4 (month1, month0, day1, day0, carry[3], clk_100Khz, rst_n, carry[2]);
    BCD_counter_4bit U5 (yr3, yr2, yr1, yr0, 4'd2, 4'd0, 4'd0, 4'd0, 4'd9, 4'd9, 4'd9, 4'd9, clk_100Khz, rst_n, carry[3]);
    scan_ctl U6 (BCD, ssd_ctl, value3, value2, value1, value0, clk_ctl);
    D_ssd U7 (ssd, BCD);
    
    always @*
    begin
        casex(state)
        3'b1xx:begin
            value3 = yr3;
            value2 = yr2;
            value1 = yr1;
            value0 = yr0;
            LED[4:2] = 3'b100;
        end
        3'b01x:begin
            value3 = month1;
            value2 = month0;
            value1 = day1;
            value0 = day0;
            LED[4:2] = 3'b010;
        end
        3'b001:begin
            value3 = hr1;
            value2 = hr0;
            value1 = min1;
            value0 = min0;
            LED[4:2] = 3'b001;
        end
        endcase
    end
        
    always @*
    begin
        LED[0] = mode;
        if(mode == 1'b0)
        begin
            hr1 = hr1_24;
            hr0 = hr0_24;
            LED[1] = 1'b0;
        end
        else
        begin
            if(hr1_24*4'd10+hr0_24 > 5'd12)
            begin
                hr1 = (hr1_24*4'd10+hr0_24-4'd12) / 4'd10;
                hr0 = (hr1_24*4'd10+hr0_24-4'd12) % 4'd10;
                LED[1] = 1'b1;
            end
            else if(hr1_24*4'd10+hr0_24 == 5'd12)
            begin
                hr1 = 4'd1;
                hr0 = 4'd2;
                LED[1] = 1'b1;
            end
            else if(hr1_24*4'd10+hr0_24 == 5'd0)
            begin
                hr1 = 4'd1;
                hr0 = 4'd2;
                LED[1] = 1'b0;                
            end 
            else
            begin
                hr1 = hr1_24;
                hr0 = hr0_24;
                LED[1] = 1'b0;        
            end
        end
    end
    
endmodule
