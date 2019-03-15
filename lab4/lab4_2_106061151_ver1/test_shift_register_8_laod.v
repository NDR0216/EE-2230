module test_shift_register_8_load;

    wire [7:0] q;
    reg [7:0] d;
    reg clk;
    reg rst_n;
    
    shift_register_8 U0 (q, d, clk, rst_n);
    
    always
        #10 clk = ~clk
    
    initial
    begin
        d = 00010011; clk = 0; rst = 1;
        #10 rst = 0;
        #10 rst = 1;
    end

endmodule