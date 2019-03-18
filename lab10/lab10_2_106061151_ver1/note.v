`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/03 01:05:51
// Design Name: 
// Module Name: note
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


module note(
    output reg [15:0] audio_l,
    output reg [15:0] audio_r,
    input [3:0] note,
    input [3:0] pitch,
    input [3:0] level,
    input clk,
    input rst_n
    );
    
    reg b_clk, next_b_clk;
    reg [18:0] cnt, next_cnt;
    reg [18:0] limit;
    
    always @(posedge clk or negedge rst_n)
    begin
        if(rst_n == 1'd0)
        begin
            b_clk <= 1'b0;
            cnt <= 19'd0;
        end
        else
        begin
            b_clk <= next_b_clk;
            cnt <= next_cnt;
        end
    end
    
    always @*
    begin
        if(cnt == limit && note != 4'b0)
        begin
            next_cnt = 19'd0;
            next_b_clk = ~b_clk;
        end
        else
        begin
            next_cnt = cnt + 19'd1; 
            next_b_clk = b_clk;
        end
        
        case(level)
            4'd15, 4'd14, 4'd13:begin
                audio_l = (b_clk == 1'b0) ? 16'hB000 : 16'h5FFF;
                audio_r = (b_clk == 1'b0) ? 16'hB000 : 16'h5FFF;
            end
            4'd12:begin
                audio_l = (b_clk == 1'b0) ? 16'hB800 : 16'h57FF;
                audio_r = (b_clk == 1'b0) ? 16'hB800 : 16'h57FF;
            end
            4'd11:begin
                audio_l = (b_clk == 1'b0) ? 16'hC000 : 16'h4FFF;
                audio_r = (b_clk == 1'b0) ? 16'hC000 : 16'h4FFF;
            end
            4'd10:begin
                audio_l = (b_clk == 1'b0) ? 16'hC800 : 16'h47FF;
                audio_r = (b_clk == 1'b0) ? 16'hC800 : 16'h47FF;
            end
            4'd9:begin
                audio_l = (b_clk == 1'b0) ? 16'hD000 : 16'h3FFF;
                audio_r = (b_clk == 1'b0) ? 16'hD000 : 16'h3FFF;
            end
            4'd8:begin
                audio_l = (b_clk == 1'b0) ? 16'hD800 : 16'h37FF;
                audio_r = (b_clk == 1'b0) ? 16'hD800 : 16'h37FF;
            end
            4'd7:begin
                audio_l = (b_clk == 1'b0) ? 16'hE000 : 16'h2FFF;
                audio_r = (b_clk == 1'b0) ? 16'hE000 : 16'h2FFF;
            end
            4'd6:begin
                audio_l = (b_clk == 1'b0) ? 16'hE800 : 16'h27FF;
                audio_r = (b_clk == 1'b0) ? 16'hE800 : 16'h27FF;
            end
            4'd5:begin
                audio_l = (b_clk == 1'b0) ? 16'hF000 : 16'h1FFF;
                audio_r = (b_clk == 1'b0) ? 16'hF000 : 16'h1FFF;
            end
            4'd4:begin
                audio_l = (b_clk == 1'b0) ? 16'hF800 : 16'h17FF;
                audio_r = (b_clk == 1'b0) ? 16'hF800 : 16'h17FF;
            end
            4'd3:begin
                audio_l = (b_clk == 1'b0) ? 16'h0000 : 16'h0FFF;
                audio_r = (b_clk == 1'b0) ? 16'h0000 : 16'h0FFF;
            end
            4'd2, 4'd1, 4'd0:begin
                audio_l = (b_clk == 1'b0) ? 16'h0000 : 16'h0000;
                audio_r = (b_clk == 1'b0) ? 16'h0000 : 16'h0000;
            end                                                      
        endcase 
        
        case(pitch)
            4'd3:begin
                case(note)
                    4'd1: limit = 19'd382220;
                    4'd2: limit = 19'd340528;
                    4'd3: limit = 19'd303370;
                    4'd4: limit = 19'd286344;
                    4'd5: limit = 19'd255102;
                    4'd6: limit = 19'd227272;
                    4'd7: limit = 19'd202478;
                endcase
            end
            4'd4:begin
                case(note)
                    4'd1: limit = 19'd191110;
                    4'd2: limit = 19'd170264;
                    4'd3: limit = 19'd151685;
                    4'd4: limit = 19'd143172;
                    4'd5: limit = 19'd127551;
                    4'd6: limit = 19'd113636;
                    4'd7: limit = 19'd101239;
                endcase
            end
            4'd5:begin
                case(note)
                    4'd1: limit = 19'd95555;
                    4'd2: limit = 19'd85132;
                    4'd3: limit = 19'd75843;
                    4'd4: limit = 19'd71586;
                    4'd5: limit = 19'd63776;
                    4'd6: limit = 19'd56818;
                    4'd7: limit = 19'd50620;
            endcase
            end
        endcase
    end
    
    
    
endmodule
