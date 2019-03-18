`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/10 21:31:56
// Design Name: 
// Module Name: debounce
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


module debounce(
    output reg button_debounce,
    input button_in,
    input clk,
    input rst_n
    );
    
    reg debounce_next;
    reg [3:0] debounce_window;
    wire [3:0] window_next;
    
    assign window_next = {debounce_window[2:0], button_in};
    
    always @(posedge clk or negedge rst_n)
    begin
        if(rst_n == 0)
        begin
            button_debounce <= 1'b0;
            debounce_window <= 4'b0;
        end
        else
        begin
            button_debounce <= debounce_next;
            debounce_window <= window_next;
        end
    end
    
    always @*
    begin
        if(debounce_window == 4'b1111)
            debounce_next = 1'b1;
        else
            debounce_next = 1'b0;
    end
    
endmodule
