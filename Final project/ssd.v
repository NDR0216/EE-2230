`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/21 01:04:23
// Design Name: 
// Module Name: ssd
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


module ssd(
    input clk,
    input player,
    input [3:0] d1,
    input [3:0] d2,
    input [3:0] d3,
    input [3:0] d4,
    output reg [7:0] ssd,
    output reg [3:0] ssd_ctl
    );
    reg [18:0]f = 19'b0;
    reg [1:0]sel = 2'b0;
    reg [3:0]d_in;
    always@(posedge clk)
            {sel, f} = {sel, f} + 1'b1;
    always@*
    begin
        case(sel)
        2'b00: ssd_ctl = 4'b0111;
        2'b01: ssd_ctl = 4'b1011;
        2'b10: ssd_ctl = 4'b1101;
        2'b11: ssd_ctl = 4'b1110;
        default: ssd_ctl = 4'b1111;
        endcase
        
        case(sel)
        2'b00: d_in = d1;
        2'b01: d_in = d2;
        2'b10: d_in = d3;
        2'b11: d_in = d4;
        default: d_in = d1;
        endcase
    end
    always@*
    case(d_in)
    4'd0: ssd = {((player == 1'b0 && sel == 2'b01) || (player == 1'b1 && sel == 2'b11))?1'b0:1'b1, 7'b1000000};
    4'd1: ssd = {((player == 1'b0 && sel == 2'b01) || (player == 1'b1 && sel == 2'b11))?1'b0:1'b1, 7'b1111001};
    4'd2: ssd = {((player == 1'b0 && sel == 2'b01) || (player == 1'b1 && sel == 2'b11))?1'b0:1'b1, 7'b0100100};
    4'd3: ssd = {((player == 1'b0 && sel == 2'b01) || (player == 1'b1 && sel == 2'b11))?1'b0:1'b1, 7'b0110000};
    4'd4: ssd = {((player == 1'b0 && sel == 2'b01) || (player == 1'b1 && sel == 2'b11))?1'b0:1'b1, 7'b0011001};
    4'd5: ssd = {((player == 1'b0 && sel == 2'b01) || (player == 1'b1 && sel == 2'b11))?1'b0:1'b1, 7'b0010010};
    4'd6: ssd = {((player == 1'b0 && sel == 2'b01) || (player == 1'b1 && sel == 2'b11))?1'b0:1'b1, 7'b0000010};
    4'd7: ssd = {((player == 1'b0 && sel == 2'b01) || (player == 1'b1 && sel == 2'b11))?1'b0:1'b1, 7'b1011000};
    4'd8: ssd = {((player == 1'b0 && sel == 2'b01) || (player == 1'b1 && sel == 2'b11))?1'b0:1'b1, 7'b0000000};
    4'd9: ssd = {((player == 1'b0 && sel == 2'b01) || (player == 1'b1 && sel == 2'b11))?1'b0:1'b1, 7'b0010000};
    default :ssd = 8'b11111111;
    endcase
endmodule
