`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 01:34:36
// Design Name: 
// Module Name: aim
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


module aim(
    input clk,
    input rst,
    input valid,
    input switch,
    input acc,
    input [511:0] key_down,
    input [7:0] last_change,
    input key_valid,
    input [4:0] str,
    output [5:0] x_temp,
    output [5:0] y_temp
    );
    reg [4:0] x = 5'd5;
    reg [4:0] y = 5'd9;
    reg [4:0] x_n, y_n;
    reg [10:0] random_gen = 11'd1687;
    reg [2:0] randomx = 2;
    assign x_temp = (valid == 1'b1)?12 + (2*x - 10):12 + (2*x - 10) + (randomx - 2);
    assign y_temp = (valid == 1'b1)?(26 + y- 9):(26 + (y - 9) + (str - 14));
    always@*
    if(switch || rst)
    begin
        x_n <= 5'd5;
        y_n <= 5'd9;
    end
    else if(key_valid && key_down[last_change])
    begin
    case(last_change)
    8'h1D:
    begin
        y_n = (y == 5'd18)?y:y + 1'b1;
        x_n = x;
    end
    8'h1B:
    begin
        y_n = (y == 5'd0)?y:y - 1'b1;
        x_n = x;
    end
    8'h23:
    begin
        x_n = (x == 5'd10)?x:x + 1'b1;
        y_n = y;
    end
    8'h1C:
    begin
        x_n = (x == 5'd0)?x:x - 1'b1;
        y_n = y;
    end
    default:
    begin
        x_n = x;
        y_n = y;
    end
    endcase
    end
    
    always@(posedge clk or posedge rst or posedge switch)
    if(rst || switch)
    begin
        x = 5'd5;
        y = 5'd9;
    end
    else if(key_down[last_change] && key_valid)
    begin
        x <= x_n;
        y <= y_n;
    end
    always@(posedge clk)
    if(acc)
        random_gen = {random_gen[5] ^ random_gen[2] ^ random_gen[10], random_gen[10:1]};
    always@*
    case({random_gen[3], random_gen[8], random_gen[1], random_gen[4]})
    4'd0, 4'd1, 4'd2: randomx = 3'd0;
    4'd3, 4'd4, 4'd5: randomx = 3'd1;
    4'd6, 4'd7, 4'd8: randomx = 3'd2;
    4'd9, 4'd10, 4'd11: randomx = 3'd3;
    4'd12, 4'd13, 4'd14: randomx = 3'd4;
    default: randomx = 4'd2;
    endcase
endmodule
