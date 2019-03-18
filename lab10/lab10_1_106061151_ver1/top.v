`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/23 19:28:34
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
    output mclk,
    output lrclk,
    output sck,
    output sdin,
    input clk,
    input rst_n
    );
    
    wire clk_1hz;
    wire [15:0] audio_l, audio_r;
    reg [3:0] note, pitch;
    
    reg [3:0] cnt, next_cnt;
    
    freq_div U0 (clk_1hz, , , , , clk, rst_n);
    note U1 (audio_l, audio_r, note, pitch, 4'd5, clk, rst_n);
    speaker U2 (mclk, lrclk, sck, sdin, audio_l, audio_r, clk, rst_n);
    
    always @(posedge clk_1hz or negedge rst_n)
    begin
        if(rst_n == 0)
            cnt <= 4'd0;
        else
            cnt <= next_cnt;
    end
    
    always @*
    begin
        next_cnt = cnt + 4'd1;
        
        case(cnt)
            4'd0:begin
                note = 4'd6;
                pitch = 4'd3;
            end
            4'd1:begin
                note = 4'd7;
                pitch = 4'd3;
            end
            4'd2:begin
                note = 4'd1;
                pitch = 4'd4;
            end
            4'd3:begin
                note = 4'd2;
                pitch = 4'd4;
            end
            4'd4:begin
                note = 4'd3;
                pitch = 4'd4;
            end
            4'd5:begin
                note = 4'd4;
                pitch = 4'd4;
            end
            4'd6:begin
                note = 4'd5;
                pitch = 4'd4;
            end
            4'd7:begin
                note = 4'd6;
                pitch = 4'd4;
            end
            4'd8:begin
                note = 4'd7;
                pitch = 4'd4;
            end
            4'd9:begin
                note = 4'd1;
                pitch = 4'd5;
            end            
            4'd10:begin
                note = 4'd2;
                pitch = 4'd5;
            end            
            4'd11:begin
                note = 4'd3;
                pitch = 4'd5;
            end            
            4'd12:begin
                note = 4'd4;
                pitch = 4'd5;
            end            
            4'd13:begin
                note = 4'd5;
                pitch = 4'd5;
            end
            4'd14:begin
                note = 4'd6;
                pitch = 4'd5;
            end
            4'd15:begin
                note = 4'd7;
                pitch = 4'd5;
            end
        endcase
    end
    
endmodule
