`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/22 16:16:16
// Design Name: 
// Module Name: freq_div_27
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


module freq_div_27(
    output clk_out,
    input clk,
    input rst_n
    );
    
    reg [26:0] cnt;
    reg [26:0] cnt_temp;
    
    assign clk_out = cnt[26];
    
    always @*
        cnt_temp = cnt + 1;
    
    always @(posedge clk or negedge rst_n)
    begin
        if(rst_n == 0)
            cnt <= 27'd0;
        else
            cnt <= cnt_temp;
    end
    
endmodule
