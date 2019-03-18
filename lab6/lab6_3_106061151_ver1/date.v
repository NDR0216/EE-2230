`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/18 00:22:52
// Design Name: 
// Module Name: BCD_counter_4bit
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


module date(
    output [3:0] month1,
    output [3:0] month0,
    output [3:0] day1,
    output [3:0] day0,
    output cout,
    input leapyear,
    input clk,
    input rst_n,
    input en
    );
    
    wire carry;
    reg [3:0] limit2;
    reg [3:0] limit1;
    reg [3:0] limit0;
    reg [3:0] init1;
    reg [3:0] init0;
    
    BCD_counter_2bit U0 (day1, day0, carry, 4'd0, init0, limit1, limit0, clk, rst_n, en);
    BCD_counter_2bit U1 (month1, month0, cout, 4'd0, init1, 4'd1, limit2, clk, rst_n, carry);
    
    
    always @*
    begin
        if(month0 == 4'd9)
            init1 = 4'd0;
        else
            init1 = 4'd1;
        
        if(day0 == 4'd9 && (leapyear != 4'd1 || month1 != 4'd0 || month0 != 4'd2 || day1 != 4'd2))
            init0 = 4'd0;
        else
            init0 = 4'd1;
        
        if(month1 == 4'd1)
        begin
            limit2 = 4'd2;
        end
        else
        begin
            limit2 = 4'd9;
        end
        
        case(month1*4'd10+month0)
        4'd1, 4'd3, 4'd5, 4'd7, 4'd8, 4'd10, 4'd12:begin
            limit1 = 4'd3;
            if(day1 == 4'd3)
                limit0 = 4'd1;
            else
                limit0 = 4'd9;
        end
        4'd2:begin
            limit1 = 4'd2;
            if(day1 == 4'd2 && leapyear == 1'd0)
                limit0 = 4'd8;
            else
                limit0 = 4'd9;
        end
        default:begin
            limit1 = 4'd3;
            if(day1 == 4'd3)
                limit0 = 4'd0;
            else
                limit0 = 4'd9;
        end
        endcase
    end
    
endmodule
