module test_downcounter;

    wire [3:0] value;
    wire borrow;
    reg clk;
    reg rst_n;
    reg en;
    
    downcounter U0 (value, borrow, 4'd9, 4'd9, clk, rst_n, en);
    
    always
        #10 clk = ~clk;
        
    initial
    begin
        clk = 0; rst_n = 1; en = 0;
        #10 rst_n = 0;
        #10 rst_n = 1; en = 1;
        #30 en = 0;
        #10 en = 1;
    end

endmodule