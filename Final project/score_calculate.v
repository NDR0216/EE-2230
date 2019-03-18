`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/13 01:05:56
// Design Name: 
// Module Name: score_calculate
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


module score_calculate(
    input [5:0] x,
    input [5:0] y,
    input rst,
    input player,
    input valid_pulse,
    output [5:0] score0,
    output [5:0] score1
    );
    reg [4:0] score_temp;
    reg [5:0] score_next0, score_next1;
    reg [5:0] score0 = 6'd50;
    reg [5:0] score1 = 6'd50;
    always@*
    if(player == 0)
        score_next0 = (score0 >= score_temp)?(score0 - score_temp):score0;
    else if (player == 1)
        score_next1 = (score1 >= score_temp)?(score1 - score_temp):score1;
        
    always@(negedge valid_pulse or posedge rst)
    if(rst)
    begin
        score0 <= 6'd50;
        score1 <= 6'd50;
    end
    else
    begin
        score0 <= (player == 0)?score_next0:score0;
        score1 <= (player == 1)?score_next1:score1;
    end
    always@*
    case({x, y})
    {6'd8, 6'd35}, {6'd9, 6'd35}, {6'd10, 6'd35}, {6'd11, 6'd35} : score_temp = 5'd1;
    {6'd8, 6'd34}, {6'd9, 6'd34}, {6'd10, 6'd34}, {6'd11, 6'd34} : score_temp = 5'd1;
    {6'd8, 6'd33}, {6'd9, 6'd33}, {6'd10, 6'd33}, {6'd11, 6'd33} : score_temp = 5'd1;
    {6'd9, 6'd32}, {6'd10, 6'd32}, {6'd11, 6'd32} : score_temp = 5'd1;
    {6'd10, 6'd31}, {6'd11, 6'd31} : score_temp = 5'd1;
    
    {6'd17, 6'd34}, {6'd18, 6'd34}: score_temp = 5'd1;
    {6'd17, 6'd33}, {6'd18, 6'd33}, {6'd19, 6'd33}: score_temp = 5'd1;
    {6'd16, 6'd32}, {6'd17, 6'd32}, {6'd18, 6'd32}, {6'd19, 6'd32}, {6'd20, 6'd32}: score_temp = 5'd1;
    {6'd15, 6'd31}, {6'd16, 6'd31}, {6'd17, 6'd31}, {6'd18, 6'd31}, {6'd19, 6'd31}, {6'd20, 6'd31}: score_temp = 5'd1;
    {6'd16, 6'd30}, {6'd17, 6'd30}, {6'd18, 6'd30}: score_temp = 5'd1;
    {6'd17, 6'd29}: score_temp = 5'd1;
    
    {6'd17, 6'd25}, {6'd18, 6'd25}, {6'd19, 6'd25}, {6'd20, 6'd25}, {6'd21, 6'd25} : score_temp = 5'd1;
    {6'd17, 6'd24}, {6'd18, 6'd24}, {6'd19, 6'd24}, {6'd20, 6'd24}, {6'd21, 6'd24} : score_temp = 5'd1;
    {6'd18, 6'd23}, {6'd19, 6'd23}, {6'd20, 6'd23}, {6'd21, 6'd23} : score_temp = 5'd1;
    {6'd19, 6'd22}, {6'd20, 6'd22}, {6'd21, 6'd22} : score_temp = 5'd1;
    
    {6'd13, 6'd21}, {6'd14, 6'd21} : score_temp = 5'd1;
    {6'd13, 6'd20}, {6'd14, 6'd20}, {6'd15, 6'd20} : score_temp = 5'd1;
    {6'd13, 6'd19}, {6'd14, 6'd19}, {6'd15, 6'd19}, {6'd16, 6'd19} : score_temp = 5'd1;
    {6'd13, 6'd18}, {6'd14, 6'd18}, {6'd15, 6'd18}, {6'd16, 6'd18} : score_temp = 5'd1;
    {6'd13, 6'd17}, {6'd14, 6'd17}, {6'd15, 6'd17}, {6'd16, 6'd17} : score_temp = 5'd1;
    
    {6'd7, 6'd23} : score_temp = 5'd1;
    {6'd6, 6'd22}, {6'd7, 6'd22}, {6'd8, 6'd22} : score_temp = 5'd1;
    {6'd4, 6'd21}, {6'd5, 6'd21}, {6'd6, 6'd21}, {6'd7, 6'd21}, {6'd8, 6'd21}, {6'd9, 6'd21} : score_temp = 5'd1;
    {6'd4, 6'd20}, {6'd5, 6'd20}, {6'd6, 6'd20}, {6'd7, 6'd20}, {6'd8, 6'd20} : score_temp = 5'd1;
    {6'd5, 6'd19}, {6'd6, 6'd19}, {6'd7, 6'd19} : score_temp = 5'd1;
    {6'd6, 6'd18}, {6'd7, 6'd18} : score_temp = 5'd1;
    
    {6'd3, 6'd30}, {6'd4, 6'd30}, {6'd5, 6'd30} : score_temp = 5'd1;
    {6'd3, 6'd29}, {6'd4, 6'd29}, {6'd5, 6'd29}, {6'd6, 6'd29} : score_temp = 5'd1;
    {6'd3, 6'd28}, {6'd4, 6'd28}, {6'd5, 6'd28}, {6'd6, 6'd28}, {6'd7, 6'd28} : score_temp = 5'd1;
    {6'd3, 6'd27}, {6'd4, 6'd27}, {6'd5, 6'd27}, {6'd6, 6'd27}, {6'd7, 6'd27} : score_temp = 5'd1;
    
    {6'd6, 6'd34}, {6'd7, 6'd34} : score_temp = 5'd2;
    {6'd5, 6'd33}, {6'd6, 6'd33}, {6'd7, 6'd33} : score_temp = 5'd2;
    {6'd4, 6'd32}, {6'd5, 6'd32}, {6'd6, 6'd32}, {6'd7, 6'd32}, {6'd8, 6'd32} : score_temp = 5'd2;
    {6'd4, 6'd31}, {6'd5, 6'd31}, {6'd6, 6'd31}, {6'd7, 6'd31}, {6'd8, 6'd31}, {6'd9, 6'd31} : score_temp = 5'd2;
    {6'd6, 6'd30}, {6'd7, 6'd30}, {6'd8, 6'd30} : score_temp = 5'd2;
    {6'd7, 6'd29} : score_temp = 5'd2;
    
    {6'd12, 6'd36}: score_temp = 5'd3;
    {6'd12, 6'd35}, {6'd13, 6'd35}, {6'd14, 6'd35}, {6'd15, 6'd35}, {6'd16, 6'd35} : score_temp = 5'd3;
    {6'd12, 6'd34}, {6'd13, 6'd34}, {6'd14, 6'd34}, {6'd15, 6'd34}, {6'd16, 6'd34} : score_temp = 5'd3;
    {6'd12, 6'd33}, {6'd13, 6'd33}, {6'd14, 6'd33}, {6'd15, 6'd33}, {6'd16, 6'd33} : score_temp = 5'd3;
    {6'd12, 6'd32}, {6'd13, 6'd32}, {6'd14, 6'd32}, {6'd15, 6'd32} : score_temp = 5'd3;
    {6'd13, 6'd31}, {6'd14, 6'd31} : score_temp = 5'd3;
    
    {6'd19, 6'd30}, {6'd20, 6'd30}, {6'd21, 6'd30} : score_temp = 5'd4;
    {6'd18, 6'd29}, {6'd19, 6'd29}, {6'd20, 6'd29}, {6'd21, 6'd29} : score_temp = 5'd4;
    {6'd17, 6'd28}, {6'd18, 6'd28}, {6'd19, 6'd28}, {6'd20, 6'd28}, {6'd21, 6'd28} : score_temp = 5'd4;
    {6'd17, 6'd27}, {6'd18, 6'd27}, {6'd19, 6'd27}, {6'd20, 6'd27}, {6'd21, 6'd27} : score_temp = 5'd4;
    {6'd18, 6'd26}, {6'd19, 6'd26}, {6'd20, 6'd26}, {6'd21, 6'd26}, {6'd22, 6'd26} : score_temp = 5'd4;
    
    {6'd17, 6'd23}: score_temp = 5'd5;
    {6'd16, 6'd22}, {6'd17, 6'd22}, {6'd18, 6'd22} : score_temp = 5'd5;
    {6'd15, 6'd21}, {6'd16, 6'd21}, {6'd17, 6'd21}, {6'd18, 6'd21}, {6'd19, 6'd21}, {6'd20, 6'd21} : score_temp = 5'd5;
    {6'd16, 6'd20}, {6'd17, 6'd20}, {6'd18, 6'd20}, {6'd19, 6'd20}, {6'd20, 6'd20} : score_temp = 5'd5;
    {6'd17, 6'd19}, {6'd18, 6'd19}, {6'd19, 6'd19}, {6'd20, 6'd19} : score_temp = 5'd5;
    {6'd17, 6'd18}, {6'd18, 6'd18} : score_temp = 5'd5;
    
    {6'd10, 6'd21}, {6'd11, 6'd21} : score_temp = 5'd6;
    {6'd9, 6'd20}, {6'd10, 6'd20}, {6'd11, 6'd20}, {6'd12, 6'd20} : score_temp = 5'd6;
    {6'd8, 6'd19}, {6'd9, 6'd19}, {6'd10, 6'd19}, {6'd11, 6'd19}, {6'd12, 6'd19} : score_temp = 5'd6;
    {6'd8, 6'd18}, {6'd9, 6'd18}, {6'd10, 6'd18}, {6'd11, 6'd18}, {6'd12, 6'd18} : score_temp = 5'd6;
    {6'd8, 6'd17}, {6'd9, 6'd17}, {6'd10, 6'd17}, {6'd11, 6'd17}, {6'd12, 6'd17} : score_temp = 5'd6;
    {6'd12, 6'd16} : score_temp = 5'd6;
    
    {6'd2, 6'd26}, {6'd3, 6'd26}, {6'd4, 6'd26}, {6'd5, 6'd26}, {6'd6, 6'd26} : score_temp = 5'd7;
    {6'd3, 6'd25}, {6'd4, 6'd25}, {6'd5, 6'd25}, {6'd6, 6'd25}, {6'd7, 6'd25} : score_temp = 5'd7;
    {6'd3, 6'd24}, {6'd4, 6'd24}, {6'd5, 6'd24}, {6'd6, 6'd24}, {6'd7, 6'd24} : score_temp = 5'd7;
    {6'd3, 6'd23}, {6'd4, 6'd23}, {6'd5, 6'd23}, {6'd6, 6'd23} : score_temp = 5'd7;
    {6'd3, 6'd22}, {6'd4, 6'd22}, {6'd5, 6'd22} : score_temp = 5'd7;
    
    {6'd8, 6'd28} : score_temp = 5'd8;
    {6'd8, 6'd27}, {6'd9, 6'd27}, {6'd10, 6'd27} : score_temp = 5'd8;
    
    {6'd10, 6'd30}, {6'd11, 6'd30} : score_temp = 5'd9;
    {6'd11, 6'd29} : score_temp = 5'd9;
    {6'd11, 6'd28} : score_temp = 5'd9;
    
    {6'd15, 6'd30} : score_temp = 5'd10;
    {6'd14, 6'd29}, {6'd15, 6'd29}, {6'd16, 6'd29} : score_temp = 5'd10;
    {6'd14, 6'd28}, {6'd15, 6'd28} : score_temp = 5'd10;
    {6'd13, 6'd27} : score_temp = 5'd10;
    
    {6'd14, 6'd25}, {6'd15, 6'd25}, {6'd16, 6'd25} : score_temp = 5'd11;
    {6'd16, 6'd24} : score_temp = 5'd11;
    
    {6'd13, 6'd24} : score_temp = 5'd12;
    {6'd13, 6'd23} : score_temp = 5'd12;
    {6'd13, 6'd22}, {6'd14, 6'd22}: score_temp = 5'd12;
    
    {6'd11, 6'd25} : score_temp = 5'd13;
    {6'd9, 6'd24}, {6'd10, 6'd24} : score_temp = 5'd13;
    {6'd8, 6'd23}, {6'd9, 6'd23}, {6'd10, 6'd23} : score_temp = 5'd13;
    {6'd9, 6'd22} : score_temp = 5'd13;
    
    {6'd9, 6'd30} : score_temp = 5'd14;
    {6'd8, 6'd29}, {6'd9, 6'd29}, {6'd10, 6'd29} : score_temp = 5'd14;
    {6'd9, 6'd28}, {6'd10, 6'd28} : score_temp = 5'd14;
    {6'd11, 6'd27} : score_temp = 5'd14;
    
    {6'd12, 6'd31} : score_temp = 5'd15;
    {6'd12, 6'd30}, {6'd13, 6'd30}, {6'd14, 6'd30} : score_temp = 5'd15;
    {6'd12, 6'd29}, {6'd13, 6'd29} : score_temp = 5'd15;
    {6'd12, 6'd28}, {6'd13, 6'd28} : score_temp = 5'd15;
    
    {6'd16, 6'd28} : score_temp = 5'd16;
    {6'd14, 6'd27}, {6'd15, 6'd27}, {6'd16, 6'd27} : score_temp = 5'd16;
    {6'd14, 6'd26}, {6'd15, 6'd26}, {6'd16, 6'd26}, {6'd17, 6'd26} : score_temp = 5'd16;
    
    {6'd13, 6'd25} : score_temp = 5'd17;
    {6'd14, 6'd24}, {6'd15, 6'd24} : score_temp = 5'd17;
    {6'd14, 6'd23}, {6'd15, 6'd23}, {6'd16, 6'd23} : score_temp = 5'd17;
    {6'd15, 6'd22} : score_temp = 5'd17;
    
    {6'd11, 6'd24}, {6'd12, 6'd24} : score_temp = 5'd18;
    {6'd11, 6'd23}, {6'd12, 6'd23} : score_temp = 5'd18;
    {6'd10, 6'd22}, {6'd11, 6'd22}, {6'd12, 6'd22} : score_temp = 5'd18;
    {6'd12, 6'd21} : score_temp = 5'd18;
    
    
    {6'd7, 6'd26}, {6'd8, 6'd26}, {6'd9, 6'd26}, {6'd10, 6'd26} : score_temp = 5'd19;
    {6'd8, 6'd25}, {6'd9, 6'd25}, {6'd10, 6'd25} : score_temp = 5'd19;
    {6'd8, 6'd24} : score_temp = 5'd19;
    
    {6'd12, 6'd27}: score_temp = 5'd20;
    {6'd11, 6'd26}, {6'd12, 6'd26}, {6'd13, 6'd26}: score_temp = 5'd20;
    {6'd12, 6'd25}: score_temp = 5'd20;
    
    default : score_temp = 5'd0;
    endcase
endmodule
