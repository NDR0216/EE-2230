module test_Dec38;
reg [2:0] IN;
reg EN;
wire [7:0] D;

Dec38 U0(.in(IN), .en(EN), .d(D));

initial
begin
    IN=4'd0; EN=0;
    #10 IN=4'd1; EN=0;
    #10 IN=4'd2; EN=0;
    #10 IN=4'd3; EN=0;
    #10 IN=4'd4; EN=0;
    #10 IN=4'd5; EN=0;
    #10 IN=4'd6; EN=0;
    #10 IN=4'd7; EN=0;
    #10 IN=4'd0; EN=1;
    #10 IN=4'd1; EN=1;
    #10 IN=4'd2; EN=1;
    #10 IN=4'd3; EN=1;
    #10 IN=4'd4; EN=1;
    #10 IN=4'd5; EN=1;
    #10 IN=4'd6; EN=1;
    #10 IN=4'd7; EN=1;
end

endmodule