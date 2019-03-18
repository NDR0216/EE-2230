`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/12 23:15:55
// Design Name: 
// Module Name: dart_shoot
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


module dart_shoot(
    input clk_32,
    input rst,
    input switch,
    input acc_pulse,
    input acc,
    output valid,
    output [15:0] led,
    output reg [4:0] str
    );
    reg valid = 1'b1;
    reg [15:0] led = 15'd0;
    reg m;
    always@(led)
    begin
    if(led == 16'b1111_1111_1111_1111)
        m <= 1'b1;
    else if(led == 16'b0000_0000_0000_0000)
        m <= 1'b0;
    end

    always@(posedge clk_32 or posedge rst or posedge switch)
    if(switch || rst)
        led = 15'd0;
    else if(acc && valid)
    begin
        if(m == 1'b0)
            led <= {1'b1, led[15:1]};
        else if(m == 1'b1)
            led <= {led[14:0], 1'b0};
    end
    
    always@(posedge acc_pulse or posedge rst or posedge switch)
    if(switch || rst)
        valid <= 1'b1;
    else if(acc_pulse)
        valid <= 1'b0;
        
    always@*
    case(led)
    16'b0000_0000_0000_0000: str = 5'd0;
    16'b1000_0000_0000_0000: str = 5'd1;
    16'b1100_0000_0000_0000: str = 5'd2;
    16'b1110_0000_0000_0000: str = 5'd3;
    16'b1111_0000_0000_0000: str = 5'd4;
    16'b1111_1000_0000_0000: str = 5'd5;
    16'b1111_1100_0000_0000: str = 5'd6;
    16'b1111_1110_0000_0000: str = 5'd7;
    16'b1111_1111_0000_0000: str = 5'd8;
    16'b1111_1111_1000_0000: str = 5'd9;
    16'b1111_1111_1100_0000: str = 5'd10;
    16'b1111_1111_1110_0000: str = 5'd11;
    16'b1111_1111_1111_0000: str = 5'd12;
    16'b1111_1111_1111_1000: str = 5'd13;
    16'b1111_1111_1111_1100: str = 5'd14;
    16'b1111_1111_1111_1110: str = 5'd15;
    16'b1111_1111_1111_1111: str = 5'd16;
    default: str = 4'd0;
    endcase
endmodule
