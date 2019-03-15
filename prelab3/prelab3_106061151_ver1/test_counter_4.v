module test_counter_4;
    
    reg clk;
    reg rst_n;
    wire [3:0] q;
    
    counter_4 U0 (q, clk, rst_n);
    
    always 
    #10 clk = ~clk;
    
    initial
    begin
        clk = 0; rst_n = 1;
        #10 rst_n = 0;
        #10 rst_n = 1;
    end
    
endmodule