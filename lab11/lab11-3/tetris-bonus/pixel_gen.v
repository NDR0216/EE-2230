module pixel_gen(
  input [2:0] color,
  input valid,
  output reg [3:0] vgaRed,
  output reg [3:0] vgaGreen,
  output reg [3:0] vgaBlue
);
   
  always @(*) begin
    case(color)
        3'd1 : {vgaRed, vgaGreen, vgaBlue} = 12'h0AE;
        3'd2 : {vgaRed, vgaGreen, vgaBlue} = 12'h00F;
        3'd3 : {vgaRed, vgaGreen, vgaBlue} = 12'hFB0;
        3'd4 : {vgaRed, vgaGreen, vgaBlue} = 12'hFF0;
        3'd5 : {vgaRed, vgaGreen, vgaBlue} = 12'h0F0;
        3'd6 : {vgaRed, vgaGreen, vgaBlue} = 12'h0FF;
        3'd7 : {vgaRed, vgaGreen, vgaBlue} = 12'hF00;
        3'd0 : {vgaRed, vgaGreen, vgaBlue} = 12'hFFF;
    endcase
  end

endmodule
