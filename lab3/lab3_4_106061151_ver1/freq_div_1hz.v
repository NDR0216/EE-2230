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


module freq_div_1hz(
    output reg clk_out,
    output [1:0] clk_ctl,
    input clk,
    input rst_n
    );
    
    reg [25:0] cnt;
    reg [25:0] cnt_temp;
    
    assign clk_ctl = {cnt[16], cnt[15]};
        
    always @*
        cnt_temp = cnt + 1;
        
    always @(posedge clk or negedge rst_n)
    begin
        if(rst_n == 0)
        begin   
            cnt <= 26'd0;
            clk_out <= 0;
        end
        else if(cnt == 26'd50000000)
        begin
            cnt <= 26'd0;
            clk_out <= ~ clk_out;
        end
        else
            cnt <= cnt_temp;
    end
    
endmodule
