module test_decimal_adder;
reg [3:0] A;
reg [3:0] B;
reg CI;
wire [3:0] S;
wire CO;

decimal_adder U0(.a(A), .b(B), .ci(CI), .s(S), .co(CO));

initial
begin
    A=4'd1; B=4'd3; CI=0;
    #10 A=4'd7; B=4'd3; CI=0;
    #10 A=4'd2; B=4'd7; CI=0;
    #10 A=4'd8; B=4'd8; CI=0;
    #10 A=4'd2; B=4'd1; CI=0;
    #10 A=4'd6; B=4'd2; CI=0;
    #10 A=4'd1; B=4'd8; CI=0;
    #10 A=4'd3; B=4'd8; CI=1;
    #10 A=4'd9; B=4'd9; CI=1;
end

endmodule