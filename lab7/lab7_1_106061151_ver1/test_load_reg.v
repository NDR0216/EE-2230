module test_load_reg;

    wire [3:0] out;
    reg [3:0] in;
    reg load;
    reg clk;
    reg rst_n;
    
    load_reg U0 (out, in, load, clk, rst_n);
    
    always 
        #10 clk = ~clk;
    
    initial
    begin
        clk = 1'd0; rst_n = 1'd1;
        #10 rst_n = 1'd0;
        #10 rst_n = 1'd1; load = 1'd1; in = 4'd1;
        #10 rst_n = 1'd1; load = 1'd1; in = 4'd3;
        #10 rst_n = 1'd1; load = 1'd0; in = 4'd7;
        #10 rst_n = 1'd1; load = 1'd0; in = 4'd3;
        #10 rst_n = 1'd1; load = 1'd0; in = 4'd2;
        #10 rst_n = 1'd1; load = 1'd1; in = 4'd7;
        #10 rst_n = 1'd1; load = 1'd0; in = 4'd2;
        #10 rst_n = 1'd1; load = 1'd1; in = 4'd0;
        #10 rst_n = 1'd1; load = 1'd0; in = 4'd1;
        #10 rst_n = 1'd1; load = 1'd0; in = 4'd8;
        #10 rst_n = 1'd1; load = 1'd0; in = 4'd0;
        #10 rst_n = 1'd1; load = 1'd1; in = 4'd4;
        #10 rst_n = 1'd1; load = 1'd0; in = 4'd2;
        #10 rst_n = 1'd1; load = 1'd0; in = 4'd7;
    end
    
endmodule