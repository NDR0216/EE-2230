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
    output [7:0] ssd,
    output [3:0] ssd_ctl, 
    inout PS2_DATA,
    inout PS2_CLK,
    input DIP,
    input clk,
    input rst_n
    );
    
    wire [511:0] key_down;
    wire [8:0] last_change;
    wire key_valid;
    wire [15:0] audio_l, audio_r;
    reg [3:0] note, pitch;
    wire [1:0] clk_ctl;
    wire [4:0] value;
    reg [4:0] display_note;
    reg [4:0] display_pitch;
    
    KeyboardDecoder U0 (key_down, last_change, key_valid, PS2_DATA, PS2_CLK, ~rst_n, clk);
    note U1 (audio_l, audio_r, note, pitch, 4'd5, DIP, clk, rst_n);
    speaker U2 (mclk, lrclk, sck, sdin, audio_l, audio_r, clk, rst_n);
    freq_div U3 ( , , , , clk_ctl, clk, rst_n);
    scan_ctl U4 (value, ssd_ctl, 5'd31, 5'd31, display_note, display_pitch, clk_ctl);
    D_ssd U5 (ssd, value);
    
    always @*
    begin
        if(key_down[54] == 1'b1)
        begin
            note = 4'd6;
            pitch = 4'd3;
            display_note = 5'd10;
            display_pitch = 5'd3;
        end
        else if(key_down[61] == 1'b1)
        begin
            note = 4'd7;
            pitch = 4'd3;
            display_note = 5'd11;
            display_pitch = 5'd3;
        end
        else if(key_down[21] == 1'b1)
        begin
            note = 4'd1;
            pitch = 4'd4;
            display_note = 5'd12;
            display_pitch = 5'd4;
        end
        else if(key_down[29] == 1'b1)
        begin
            note = 4'd2;
            pitch = 4'd4;
            display_note = 5'd13;
            display_pitch = 5'd4;
        end
        else if(key_down[36] == 1'b1)
        begin
            note = 4'd3;
            pitch = 4'd4;
            display_note = 5'd14;
            display_pitch = 5'd4;
        end
        else if(key_down[45] == 1'b1)
        begin
            note = 4'd4;                
            pitch = 4'd4;
            display_note = 5'd15;
            display_pitch = 5'd4;
        end
        else if(key_down[44] == 1'b1)
            begin
            note = 4'd5;
            pitch = 4'd4;
            display_note = 5'd16;
            display_pitch = 5'd4;
        end
        else if(key_down[53] == 1'b1)
        begin
            note = 4'd6;
            pitch = 4'd4;
            display_note = 5'd10;
            display_pitch = 5'd4;
        end
        else if(key_down[60] == 1'b1)
        begin
            note = 4'd7;
            pitch = 4'd4;
            display_note = 5'd11;
            display_pitch = 5'd4;
        end
        else if(key_down[28] == 1'b1)
        begin
            note = 4'd1;
            pitch = 4'd5;                
            display_note = 5'd12;
            display_pitch = 5'd5;
        end            
        else if(key_down[27] == 1'b1)
        begin
            note = 4'd2;
            pitch = 4'd5;                
            display_note = 5'd13;
            display_pitch = 5'd5;
        end            
        else if(key_down[35] == 1'b1)
        begin
            note = 4'd3;
            pitch = 4'd5;                
            display_note = 5'd14;
            display_pitch = 5'd5;
        end            
        else if(key_down[43] == 1'b1)            
        begin
            note = 4'd4;
            pitch = 4'd5;                
            display_note = 5'd15;
            display_pitch = 5'd5;
        end            
        else if(key_down[52] == 1'b1)
        begin
            note = 4'd5;
            pitch = 4'd5;
            display_note = 5'd16;
            display_pitch = 5'd5;
        end
        else if(key_down[51] == 1'b1)
        begin
            note = 4'd6;
            pitch = 4'd5;
            display_note = 5'd10;
            display_pitch = 5'd5;
        end
        else if(key_down[59] == 1'b1)
        begin
            note = 4'd7;
            pitch = 4'd5;
            display_note = 5'd11;
            display_pitch = 5'd5;
        end
        else begin
            note = 4'd0;
            display_note = 5'd31;
            display_pitch = 5'd31;
        end
    end        
    
endmodule
