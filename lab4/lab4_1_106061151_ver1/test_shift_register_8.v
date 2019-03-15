module test_shift_register_8;
    
    wire [7:0] q;
    reg clk;
    reg rst_n;
    
    shift_register_8 U0 (q, clk, rst_n);
    
    always
        #10 clk = ~clk;
    
    initial
    begin
        clk = 0; rst_n = 1;
        #10 rst_n = 0;
        #10 rst_n = 1;
    end
    
endmodule