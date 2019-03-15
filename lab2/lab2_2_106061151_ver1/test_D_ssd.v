module test_D_ssd;

    reg [3:0] i;
    wire [7:0] D_ssd;
    wire [3:0] d;
    
    D_ssd U0(i, D_ssd, d);
    
    initial
    begin
        i=0;
        repeat(15)
        begin
            #10
            i = i+1;
        end
    end

endmodule