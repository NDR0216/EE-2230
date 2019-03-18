`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/06 21:44:23
// Design Name: 
// Module Name: addr_BCD_converter
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


module addr_BCD_converter(
    output reg [16:0] addr,
    input [3:0] BCD, 
    input [9:0] h_cnt,
    input [9:0] v_cnt
    );
    
    always @*
    begin
        case(BCD)
            4'd0 : addr = (h_cnt>>1)%35 + (v_cnt>>1)%35*320;
            4'd1 : addr = (h_cnt>>1)%35 + (v_cnt>>1)%35*320 +35*320;
            4'd2 : addr = (h_cnt>>1)%35 + (v_cnt>>1)%35*320 +35*320*2;
            4'd3 : addr = (h_cnt>>1)%35 + (v_cnt>>1)%35*320 +35*320*3;
            4'd4 : addr = (h_cnt>>1)%35 + (v_cnt>>1)%35*320 +35*320*4;
            4'd5 : addr = (h_cnt>>1)%35 + (v_cnt>>1)%35*320 +35*320*5;
            4'd6 : addr = (h_cnt>>1)%35 + (v_cnt>>1)%35*320 +35;
            4'd7 : addr = (h_cnt>>1)%35 + (v_cnt>>1)%35*320 +35+35*320;
            4'd8 : addr = (h_cnt>>1)%35 + (v_cnt>>1)%35*320 +35+35*320*2;
            4'd9 : addr = (h_cnt>>1)%35 + (v_cnt>>1)%35*320 +35+35*320*3;
            4'd10 : addr = (h_cnt>>1)%35 + (v_cnt>>1)%35*320 +35+35*320*4;
            4'd11 : addr = (h_cnt>>1)%35 + (v_cnt>>1)%35*320 +35+35*320*5;
            4'd12 : addr = (h_cnt>>1)%35 + (v_cnt>>1)%35*320 +35*2;
            4'd15 : addr = 76800;
        endcase
    end
    
endmodule
