`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/25 19:09:03
// Design Name: 
// Module Name: one_pulse
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


module one_pulse(
    output reg one_pulse,
    input button,
    input clk,
    input rst_n
    );
    
    reg button_delay;
    wire one_pulse_next;
    
    always @(posedge clk or negedge rst_n)
    begin
        if(rst_n == 1'b0)
        begin
            one_pulse <= 1'b0;
            button_delay <= 1'b0;
        end
        else
        begin
            one_pulse <= one_pulse_next;
            button_delay <= button;
        end
    end
    
    assign one_pulse_next = button & ~button_delay;
    
endmodule
