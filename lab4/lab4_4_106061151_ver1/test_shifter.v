module test_shifter;

wire [3:0] arith;
wire [3:0] bar;
wire [3:0] func;
reg [3:0] in;
reg direction;

arithmetic_shift U0 (arith, in, direction);
barrel_shift U1 (bar, in, direction);
functional_shift U2 (func, in, direction);

initial
begin
    in = 4'b1010; direction = 0;
    #10 direction = 1;
end

endmodule