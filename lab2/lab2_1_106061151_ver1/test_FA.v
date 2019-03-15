module test_FA;
reg X, Y, CIN;
wire S, COUT;

FA U0(.x(X), .y(Y), .cin(CIN), .s(S), .cout(COUT));

initial
begin
    X=0; Y=0; CIN=0;
    #10 X=0; Y=0; CIN=1;
    #10 X=0; Y=1; CIN=0;
    #10 X=0; Y=1; CIN=1;
    #10 X=1; Y=0; CIN=0;
    #10 X=1; Y=0; CIN=1;
    #10 X=1; Y=1; CIN=0;
    #10 X=1; Y=1; CIN=1;
end

endmodule