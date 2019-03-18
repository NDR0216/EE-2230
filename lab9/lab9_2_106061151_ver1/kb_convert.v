`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/16 12:47:42
// Design Name: 
// Module Name: kb_convert
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


module kb_convert(
    output reg [3:0] key,
    input [8:0] last_change
    );
    
    always @*
        begin
            case(last_change)
                9'H16 : key = 4'd1;
                9'H1E : key = 4'd2;
                9'H26 : key = 4'd3;
                9'H25 : key = 4'd4;
                9'H2E : key = 4'd5;
                9'H36 : key = 4'd6;
                9'H3D : key = 4'd7;
                9'H3E : key = 4'd8;
                9'H46 : key = 4'd9;
                9'H45 : key = 4'd0;
                9'H1C : key = 4'd10;
                9'H1B : key = 4'd11;
                9'H3A : key = 4'd12;
                9'H5A : key = 4'd15;
            endcase
    end
endmodule
