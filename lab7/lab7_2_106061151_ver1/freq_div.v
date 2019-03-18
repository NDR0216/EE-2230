`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/22 17:12:00
// Design Name: 
// Module Name: freq_div_1hz
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


module freq_div(
    output reg clk_1hz,
    output reg clk_100hz,
    output reg clk_1Khz,
    output reg clk_100Khz,
    output [1:0] clk_ctl,
    input clk,
    input rst_n
    );
    
    reg clk_1hz_next;
    reg clk_100hz_next;
    reg clk_1Khz_next;
    reg clk_100Khz_next;
    reg [25:0] cnt_50M;
    reg [25:0] cnt_50M_next;
    reg [18:0] cnt_500K;
    reg [18:0] cnt_500K_next;
    reg [15:0] cnt_50K;
    reg [15:0] cnt_50K_next;
    reg [8:0] cnt_500;
    reg [8:0] cnt_500_next;
    
    assign clk_ctl = {cnt_50M[16], cnt_50M[15]};
    
    always @(posedge clk or negedge rst_n)
    begin
        if(rst_n == 0)
        begin   
            cnt_50M <= 26'b0;
            clk_1hz <= 1'b0;
            cnt_500K <= 19'b0;
            clk_100hz <= 1'b0;
            cnt_50K <= 16'b0;
            clk_1Khz <= 1'b0;
            cnt_500 <= 9'b0;
            clk_100Khz <= 1'b0;
        end
        else
        begin
            cnt_50M <= cnt_50M_next;
            clk_1hz <= clk_1hz_next;
            cnt_500K <= cnt_500K_next;
            clk_100hz <= clk_100hz_next;
            cnt_50K <= cnt_50K_next;
            clk_1Khz <= clk_1Khz_next;
            cnt_500 <=  cnt_500_next;
            clk_100Khz <= clk_100Khz_next;
        end
    end
    
    always @*
    begin
        if(cnt_50M == 26'd50000000)
        begin
            cnt_50M_next = 26'd0;
            clk_1hz_next = ~ clk_1hz;
        end
        else
        begin
            cnt_50M_next = cnt_50M + 1'b1;
            clk_1hz_next = clk_1hz;
        end
        
        if(cnt_500K == 19'd500000)
        begin
            cnt_500K_next = 19'd0;
            clk_100hz_next = ~ clk_100hz;
        end
        else
        begin
            cnt_500K_next = cnt_500K + 1'b1;
            clk_100hz_next = clk_100hz;
        end
        
        if(cnt_50K == 16'd50000)
        begin
            cnt_50K_next = 16'd0;
            clk_1Khz_next = ~ clk_1Khz;
        end
        else
        begin
            cnt_50K_next = cnt_50K + 1'b1;
            clk_1Khz_next = clk_1Khz;
        end     
        
        if(cnt_500 == 9'd500)
        begin
            cnt_500_next = 9'd0;
            clk_100Khz_next = ~clk_100Khz;
        end
        else
        begin
            cnt_500_next = cnt_500 + 1'b1;
            clk_100Khz_next = clk_100Khz;
        end
        
    end
    
endmodule
