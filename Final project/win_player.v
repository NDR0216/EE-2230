`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/14 23:14:43
// Design Name: 
// Module Name: win_player
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


module win_player(
  input [9:0] h_cnt,
  input [9:0] v_cnt,
  input [2:0] player,
  output reg [16:0] pixel_addr
);

always @*
begin
    case(player)
        3'b001: pixel_addr = (h_cnt>>2)+160*(v_cnt>>2);
        3'b010: pixel_addr = (h_cnt>>2)+160*(v_cnt>>2)+19200;
        3'b100: pixel_addr = (h_cnt>>2)+160*(v_cnt>>2)+38400;
    endcase
end
    
endmodule
