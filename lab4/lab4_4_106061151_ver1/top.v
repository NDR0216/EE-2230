`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/29 02:22:13
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
    input button,
    input direction,
    input [2:0] kind,
    input clk
    );
    
    wire [1:0] clk_ctl;
    reg rst_n_freq;
    wire [3:0] arith;
    wire [3:0] bar;
    wire [3:0] func;
    reg [3:0] in;
    wire [3:0] out;
    
    initial
    begin
        rst_n_freq = 1;
        #10 rst_n_freq = 0;
        #10 rst_n_freq = 1;
    end
    
    always @*
    begin
        if(button == 1)
        begin
            case(kind)
                3'b100 : in = func;
                3'b010 : in = arith;
                3'b001 : in = bar;
                default : in = 4'd0;
            endcase
        end
        else
            in = 4'b1010;
    end
    
    freq_div_1hz U0 ( , clk_ctl, clk, rst_n_freq);
    arithmetic_shift U1 (arith, 4'b1010, direction);
    barrel_shift U2 (bar, 4'b1010, direction);
    functional_shift U3 (func, 4'b1010, direction);
    scan_ctl U4 (out, ssd_ctl, {3'd0, in[3]}, {3'd0, in[2]}, {3'd0, in[1]}, {3'd0, in[0]}, clk_ctl);
    D_ssd U5 (ssd, out);
    
endmodule
