module test_BCD_counter;
    
    wire [3:0] BCD;
    reg clk;
    reg rst_n;
    
    BCD_counter U0 (BCD, clk, rst_n);
    
    always
    #10 clk = ~clk;
        
    initial
    begin
        clk = 0; rst_n = 1;
        #10 rst_n = 0;
        #10 rst_n = 1;
    end
    
endmodule