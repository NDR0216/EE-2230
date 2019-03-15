`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/11 02:16:54
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
    output [7:0] D_ssd,
    output [3:0] ssd_ctl,
    output reg [15:0] LED,
    input button_en,
    input clk,
    input rst,
    input rst_n_init
    );
    
    wire clk_1hz;
    wire clk_100hz;
    wire [1:0] clk_ctl;
    wire button_en_debounce;
    wire en;
    wire [3:0] value2;
    wire [3:0] value1;
    wire [3:0] value0;
    wire [3:0] ssd;
    reg zero;
    
    always@*
    begin    
        if(value2 == 4'd0 && value1 == 4'd0 && value0 == 4'd0)
        begin
            zero = 1'b0;
            LED = 16'b1111111111111111;
        end
        else
        begin
            zero = 1'b1;
            LED = {15'b0, en};
        end
    end
    
    freq_div U0 (clk_1hz, clk_100hz, clk_ctl, clk, rst_n_init);
    debounce U1 (button_en_debounce, button_en, clk_100hz, rst_n_init);
    fsm_button U4 (en, button_en_debounce, clk_1hz, ~rst);
    downcounter_3bit U6 (value2, value1, value0, 4'd0, 4'd3, 4'd0, 4'd9, 4'd5, 4'd9, clk_1hz, ~rst, en & zero);
    scan_ctl U8 (ssd, ssd_ctl, 4'b1111, value2, value1, value0, clk_ctl);
    D_ssd U9 (D_ssd, ssd);
    
endmodule
