`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/18 00:37:45
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
    output LED_mode,
    output reg LED_AMPM,
    input mode,
    input clk,
    input rst_n
    );
    
    wire clk_1Khz;
    wire [1:0] clk_ctl;    
    wire [3:0] sec1;
    wire [3:0] sec0;
    wire [3:0] min1;
    wire [3:0] min0;
    wire [3:0] hr1_24;
    wire [3:0] hr0_24;
    reg [3:0] hr1;
    reg [3:0] hr0;
    wire [1:0] carry;
    wire [3:0] BCD;
    
    freq_div U0 ( , , clk_1Khz, , clk_ctl, clk, rst_n);
    BCD_counter_2bit U1 (sec1, sec0, carry[0], 4'd0, 4'd0, 4'd5, 4'd9, clk_1Khz, rst_n, 1'd1);
    BCD_counter_2bit U2 (min1, min0, carry[1], 4'd0, 4'd0, 4'd5, 4'd9, clk_1Khz, rst_n, carry[0]);
    BCD_counter_2bit U3 (hr1_24, hr0_24, , 4'd0, 4'd0, 4'd2, 4'd3, clk_1Khz, rst_n, carry[1]);
    scan_ctl U4 (BCD, ssd_ctl, hr1, hr0, min1, min0, clk_ctl);
    D_ssd U5 (ssd, BCD);
    
    assign LED_mode = mode;
    
    always @*
    begin
        if(mode == 1'b0)
        begin
            hr1 = hr1_24;
            hr0 = hr0_24;
            LED_AMPM = 1'b0;
        end
        else
        begin
            if(hr1_24*4'd10+hr0_24 > 5'd12)
            begin
                hr1 = (hr1_24*4'd10+hr0_24-4'd12) / 4'd10;
                hr0 = (hr1_24*4'd10+hr0_24-4'd12) % 4'd10;
                LED_AMPM = 1'b1;
            end
            else if(hr1_24*4'd10+hr0_24 == 5'd12)
            begin
                hr1 = 4'd1;
                hr0 = 4'd2;
                LED_AMPM = 1'b1;
            end
            else if(hr1_24*4'd10+hr0_24 == 5'd0)
            begin
                hr1 = 4'd1;
                hr0 = 4'd2;
                LED_AMPM = 1'b0;                
            end 
            else
            begin
                hr1 = hr1_24;
                hr0 = hr0_24;
                LED_AMPM = 1'b0;            
            end            
        end
    end
    
endmodule
