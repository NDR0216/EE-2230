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
    input mode,
    input clk,
    input rst_n
    );
    
    reg l_b_clk, next_l_b_clk;
    reg r_b_clk, next_r_b_clk;
    reg [18:0] l_cnt, next_l_cnt;
    reg [18:0] r_cnt, next_r_cnt;
    reg [18:0] l_limit, r_limit;
    
    always @(posedge clk or negedge rst_n)
    begin
        if(rst_n == 1'd0)
        begin
            l_b_clk <= 1'b0;
            r_b_clk <= 1'b0;
            l_cnt <= 19'd0;
            r_cnt <= 19'd0;
        end
        else
        begin
            l_b_clk <= next_l_b_clk;
            r_b_clk <= next_r_b_clk;
            l_cnt <= next_l_cnt;
            r_cnt <= next_r_cnt;
        end
    end
    
    always @*
    begin
        if(l_cnt == l_limit && note != 4'b0)
        begin
            next_l_cnt = 19'd0;
            next_l_b_clk = ~l_b_clk;
        end
        else
        begin
            next_l_cnt = l_cnt + 19'd1; 
            next_l_b_clk = l_b_clk;
        end
        
        if(r_cnt == r_limit && note != 4'b0)
        begin
            next_r_cnt = 19'd0;
            next_r_b_clk = ~r_b_clk;
        end
        else
        begin
            next_r_cnt = r_cnt + 19'd1; 
            next_r_b_clk = r_b_clk;
        end
                
        case(level)
            4'd15, 4'd14, 4'd13:begin
                audio_l = (l_b_clk == 1'b0) ? 16'hB000 : 16'h5FFF;
                audio_r = (r_b_clk == 1'b0) ? 16'hB000 : 16'h5FFF;
            end
            4'd12:begin
                audio_l = (l_b_clk == 1'b0) ? 16'hB800 : 16'h57FF;
                audio_r = (r_b_clk == 1'b0) ? 16'hB800 : 16'h57FF;
            end
            4'd11:begin
                audio_l = (l_b_clk == 1'b0) ? 16'hC000 : 16'h4FFF;
                audio_r = (r_b_clk == 1'b0) ? 16'hC000 : 16'h4FFF;
            end
            4'd10:begin
                audio_l = (l_b_clk == 1'b0) ? 16'hC800 : 16'h47FF;
                audio_r = (r_b_clk == 1'b0) ? 16'hC800 : 16'h47FF;
            end
            4'd9:begin
                audio_l = (l_b_clk == 1'b0) ? 16'hD000 : 16'h3FFF;
                audio_r = (r_b_clk == 1'b0) ? 16'hD000 : 16'h3FFF;
            end
            4'd8:begin
                audio_l = (l_b_clk == 1'b0) ? 16'hD800 : 16'h37FF;
                audio_r = (r_b_clk == 1'b0) ? 16'hD800 : 16'h37FF;
            end
            4'd7:begin
                audio_l = (l_b_clk == 1'b0) ? 16'hE000 : 16'h2FFF;
                audio_r = (r_b_clk == 1'b0) ? 16'hE000 : 16'h2FFF;
            end
            4'd6:begin
                audio_l = (l_b_clk == 1'b0) ? 16'hE800 : 16'h27FF;
                audio_r = (r_b_clk == 1'b0) ? 16'hE800 : 16'h27FF;
            end
            4'd5:begin
                audio_l = (l_b_clk == 1'b0) ? 16'hF000 : 16'h1FFF;
                audio_r = (r_b_clk == 1'b0) ? 16'hF000 : 16'h1FFF;
            end
            4'd4:begin
                audio_l = (l_b_clk == 1'b0) ? 16'hF800 : 16'h17FF;
                audio_r = (r_b_clk == 1'b0) ? 16'hF800 : 16'h17FF;
            end
            4'd3:begin
                audio_l = (l_b_clk == 1'b0) ? 16'h0000 : 16'h0FFF;
                audio_r = (r_b_clk == 1'b0) ? 16'h0000 : 16'h0FFF;
            end
            4'd2, 4'd1, 4'd0:begin
                audio_l = (l_b_clk == 1'b0) ? 16'h0000 : 16'h0000;
                audio_r = (r_b_clk == 1'b0) ? 16'h0000 : 16'h0000;
            end                                                      
        endcase 
        
        case(pitch)
            4'd3:begin
                case(note)
                    4'd1: begin
                        l_limit = 19'd382220;
                        r_limit = (mode == 1) ? 19'd303370 : 19'd382220;
                    end
                    4'd2: begin
                        l_limit = 19'd340528;
                        r_limit = (mode == 1) ? 19'd286344 : 19'd340528;
                    end
                    4'd3: begin
                        l_limit = 19'd303370;
                        r_limit = (mode == 1) ? 19'd255102 : 19'd303370;
                    end
                    4'd4: begin
                        l_limit = 19'd286344;
                        r_limit = (mode == 1) ? 19'd227272 : 19'd286344;
                    end
                    4'd5: begin
                        l_limit = 19'd255102;
                        r_limit = (mode == 1) ? 19'd202478 : 19'd255102;
                    end
                    4'd6: begin 
                        l_limit = 19'd227272;
                        r_limit = (mode == 1) ? 19'd191110 : 19'd227272;
                    end
                    4'd7: begin 
                        l_limit = 19'd202478;
                        r_limit = (mode == 1) ? 19'd170264 : 19'd202478;
                    end
                endcase
            end
            4'd4:begin
                case(note)
                    4'd1: begin
                        l_limit = 19'd191110;
                        r_limit = (mode == 1) ? 19'd151685 : 19'd191110;
                    end
                    4'd2: begin
                        l_limit = 19'd170264;
                        r_limit = (mode == 1) ? 19'd143172 :  19'd170264;
                    end
                    4'd3: begin
                        l_limit = 19'd151685;
                        r_limit = (mode == 1) ? 19'd127551 : 19'd151685;
                    end
                    4'd4: begin
                        l_limit = 19'd143172;
                        r_limit = (mode == 1) ? 19'd113636 : 19'd143172;
                    end
                    4'd5: begin
                        l_limit = 19'd127551;
                        r_limit = (mode == 1) ? 19'd101239 : 19'd127551;
                    end
                    4'd6: begin
                        l_limit = 19'd113636;
                        r_limit = (mode == 1) ? 19'd95555 : 19'd113636;
                    end
                    4'd7: begin
                        l_limit = 19'd101239;
                        r_limit = (mode == 1) ? 19'd85132 : 19'd101239;
                    end
                endcase
            end
            4'd5:begin
                case(note)
                    4'd1: begin
                        l_limit = 19'd95555;
                        r_limit = (mode == 1) ? 19'd75843 : 19'd95555;
                    end
                    4'd2: begin
                        l_limit = 19'd85132;
                        r_limit = (mode == 1) ? 19'd71586 : 19'd85132;
                    end
                    4'd3: begin
                        l_limit = 19'd75843;
                        r_limit = (mode == 1) ? 19'd63776 : 19'd75843;
                    end
                    4'd4: begin
                        l_limit = 19'd71586;
                        r_limit = (mode == 1) ? 19'd56818 : 19'd71586;
                    end
                    4'd5: begin
                        l_limit = 19'd63776;
                        r_limit = (mode == 1) ? 19'd50620 : 19'd63776;
                    end
                    4'd6: begin
                        l_limit = 19'd56818;
                        r_limit = (mode == 1) ? 19'd47778 : 19'd56818;
                    end
                    4'd7: begin
                        l_limit = 19'd50620;
                        r_limit = (mode == 1) ? 19'd42566 : 19'd50620;
                    end
            endcase
            end
        endcase
    end
    
    
    
endmodule
