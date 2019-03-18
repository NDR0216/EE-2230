module test_BCD_counter;

    wire [3:0] BCD1, BCD0;
    reg [3:0] binary;
    
    BCD_binary U0 (BCD1, BCD0, binary);
    
    initial
    begin
        binary = 4'd0;
        #10 binary = 4'd1;
        #10 binary = 4'd2;
        #10 binary = 4'd3;
        #10 binary = 4'd4;
        #10 binary = 4'd5;
        #10 binary = 4'd6;
        #10 binary = 4'd7;
        #10 binary = 4'd8;
        #10 binary = 4'd9;
        #10 binary = 4'd10;
        #10 binary = 4'd11;
        #10 binary = 4'd12;
        #10 binary = 4'd13;
        #10 binary = 4'd14;
        #10 binary = 4'd15;
    end
    
endmodule