`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/23 21:31:31
// Design Name: 
// Module Name: counter_down_30
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


module counter_down_30(
    output reg [7:0] cnt,
    input clk,
    input rst_n
    );
    
    reg [7:0] cnt_temp;
    
    always @*
        cnt_temp = cnt - 1;
        
    always @(posedge clk or posedge rst_n)
    begin
        if(rst_n == 0)
             cnt <= 8'b00110000;
        else if(cnt == 8'd0)
            cnt <= 8'd0;
        else if(cnt[3:0] == 4'b0000)
        begin
            cnt[7:4] <= cnt[7:4] -1;
            cnt[3:0] <= 4'b1001;
        end
        else
            cnt <= cnt_temp;
    end
    
endmodule
