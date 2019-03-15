module test_scan_ctl;

wire [3:0] ssd;
wire [3:0] ssd_ctl;
reg [3:0] in0;
reg [3:0] in1;
reg [3:0] in2;
reg [3:0] in3;
reg [1:0] clk_ctl;

scan_ctl U0 (ssd, ssd_ctl, in0, in1, in2, in3, clk_ctl);

initial
begin
    in0 = 4'b0001; in1 = 4'b0011; in2 = 4'b0111; in3 = 4'b0011; clk_ctl = 2'b00;
    #10 clk_ctl = 2'b01;
    #10 clk_ctl = 2'b10;
    #10 clk_ctl = 2'b11;
    #10 clk_ctl = 2'b00;
end

endmodule