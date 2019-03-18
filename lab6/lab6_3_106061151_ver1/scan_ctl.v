`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/23 21:12:25
// Design Name: 
// Module Name: scan_ctl
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


module scan_ctl(
    output reg [3:0] ssd,
    output reg [3:0] ssd_ctl,
    input [3:0] in0,
    input [3:0] in1,
    input [3:0] in2,
    input [3:0] in3,
    input [1:0] clk_ctl
    );
    
    always @*
    case(clk_ctl)
    2'b00:
    begin
        ssd_ctl = 4'b0111;
        ssd = in0;
    end
    2'b01:
    begin
        ssd_ctl = 4'b1011;
        ssd = in1;
    end
    2'b10:
    begin
        ssd_ctl = 4'b1101;
        ssd = in2;
    end
    2'b11:
    begin
        ssd_ctl = 4'b1110;
        ssd = in3;
    end
    default:
    begin
        ssd_ctl = 4'b0000;
        ssd = in0;
    end
    
    endcase
    
endmodule
