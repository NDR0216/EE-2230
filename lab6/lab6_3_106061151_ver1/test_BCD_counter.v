module test_BCD_counter;
    
    wire [3:0] BCD;
    wire carry;
    reg clk;
    reg rst_n;
    
    BCD_counter U0 (BCD, carry, 4'd0, 4'd9, clk, rst_n, 1'd1);
    
    always
    #10 clk = ~clk;
        
    initial
    begin
        clk = 0; rst_n = 1;
        #10 rst_n = 0;
        #10 rst_n = 1;
    end
    
endmodule