module test_Com_4;
    reg [3:0] ai;
    reg [3:0] bi;
    wire [3:0] ao;
    wire [3:0] bo;
    wire X;
    
    Com_4 U0 (ai, bi, ao, bo, X);
    
    initial
    begin
        ai = 1; bi = 3;
        #10 ai = 7; bi = 3;
        #10 ai = 2; bi = 7;
        #10 ai = 2; bi = 0;
        #10 ai = 1; bi = 8;
        #10 ai = 3; bi = 1;
    end

endmodule