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
                9'H16, 9'H69 : key = 4'd1;
                9'H1E, 9'H72 : key = 4'd2;
                9'H26, 9'H7A : key = 4'd3;
                9'H25, 9'H6B : key = 4'd4;
                9'H2E, 9'H73 : key = 4'd5;
                9'H36, 9'H74 : key = 4'd6;
                9'H3D, 9'H6C : key = 4'd7;
                9'H3E, 9'H75 : key = 4'd8;
                9'H46, 9'H7D : key = 4'd9;
                9'H45, 9'H70 : key = 4'd0;
                9'H1C, 9'H79 : key = 4'd10;//A
                9'H1B, 9'H7B : key = 4'd11;//S
                9'H3A, 9'H7C : key = 4'd12;//M
                9'H5A : key = 4'd15;//enter
            endcase
    end
endmodule
