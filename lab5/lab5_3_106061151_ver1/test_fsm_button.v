module test_fsm_button;
    
    wire state;
    reg button;
    reg clk;
    reg rst_n;
    
    fsm_button U0 (state, button, clk, rst_n);
    
    always 
        #10 clk  = ~clk;
    
    initial
    begin
        clk = 0; rst_n = 1;
        #10 rst_n = 0;
        #10 rst_n = 1; button = 0;
        #20 button = 1;
        #20 button = 0;
        #20 button = 1;
    end
    
endmodule
