module test_counter_4_1hz;

    wire [3:0] b;
    reg clk, rst_n;
    
    counter_4_1hz U0 (b, clk, rst_n);
    
    always
    #10 clk = ~clk; 
    
    initial
    begin
        clk = 0; rst_n = 1;
        #10 rst_n = 0;
        #10 rst_n = 1; 
    end 

endmodule