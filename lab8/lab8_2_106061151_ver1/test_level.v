module test_level;

    wire [3:0] level;
    reg up;
    reg down;
    reg clk;
    reg rst_n;
    
    level U0 (level, up, down, clk, rst_n);
    
    always
        #5 clk = ~clk;
        
    initial
    begin
        clk = 0; rst_n = 1; up = 0; down = 0;
        #10 rst_n = 0;
        #10 rst_n = 1;
        #10 up = 1;
        #100 up = 0;
        #10 down = 1;
        #50 down = 0;
    end

endmodule