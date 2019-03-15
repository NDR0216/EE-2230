module test_D_ssd_NTHUEE;

wire [7:0] ssd;
reg [3:0] i;

D_ssd_NTHUEE U0 (ssd, i);

initial
begin
    i = 4'd0;
    #10 i = 4'd1;
    #10 i = 4'd2;
    #10 i = 4'd3;
    #10 i = 4'd4;
end

endmodule