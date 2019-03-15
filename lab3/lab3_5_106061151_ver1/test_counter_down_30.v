module test_counter_down_30;

wire [7:0] cnt;
reg clk;
reg rst_n;

counter_down_30 U0 (cnt, clk, rst_n);

always
    #10 clk = ~clk;

initial
begin
    clk = 0; rst_n = 1;
    #10 rst_n = 0;
    #10 rst_n = 1;
end

endmodule