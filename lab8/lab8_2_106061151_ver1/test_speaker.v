module test_speaker;

    wire mclk;
    wire lrclk;
    wire sck;
    wire sdin;
    reg [15:0] audio_l;
    reg [15:0] audio_r;
    reg clk;
    reg rst_n;
    
    speaker U0 (mclk, lrclk, sck, sdin, audio_l, audio_r, clk, rst_n);
    
    always
        #1 clk = ~clk;
        
    initial
    begin
        clk = 0; rst_n = 1; audio_l = 16'hB000;  audio_r = 16'h5FFF;
        #1 rst_n = 0;
        #1 rst_n = 1;
    end

endmodule