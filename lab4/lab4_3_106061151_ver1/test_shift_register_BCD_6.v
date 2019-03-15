module shift_register_BCD_6;

wire [3:0] BCD_5;
wire [3:0] BCD_4;
wire [3:0] BCD_3;
                  
wire [3:0] BCD_2;
wire [3:0] BCD_1;
wire [3:0] BCD_0;
reg [3:0] d_5;
reg [3:0] d_4;
reg [3:0] d_3;
reg [3:0] d_2;
reg [3:0] d_1;
reg [3:0] d_0;
reg clk;
reg rst_n;

shift_register_BCD_6 U0 (BCD_5, BCD_4, BCD_3, BCD_2, BCD_1, BCD_0, d_5, d_4, d_3, d_2, d_1, d_0, clk, rst_n);

always
    #10 clk = ~clk;

initial
begin
    d_5 = 4'd0; d_4 = 4'd1; d_3 = 4'd2; d_2 = 4'd3; d_1 = 4'd4; d_0 = 4'd4;
    clk = 0; rst_n = 1;
    #10 rst_n = 0;
    #10 rst_n = 1;
end

endmodule