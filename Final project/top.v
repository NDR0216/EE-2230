module top(
  input clk,
  input rst,
  input [4:0] x,
  input [5:0] y,
  input en,
  input [2:0] player,
  input finish,
  output reg [3:0] vgaRed,
  output reg [3:0] vgaGreen,
  output reg [3:0] vgaBlue,
  output hsync,
  output vsync
);

wire [11:0] data;
wire clk_25MHz;
wire clk_22;
wire [16:0] pixel_addr, pixel_addr_1;
wire [11:0] pixel, pixel_1;
wire valid;
wire [9:0] h_cnt; //640
wire [9:0] v_cnt; //480

always @*
begin
    if(valid==1'b1)
    begin    
        if(finish == 1'b0)
        begin
            if((h_cnt+10)/20 == x+4 &&  v_cnt <= (38-y)*20+1 && v_cnt >= (38-y)*20-1)
                {vgaRed, vgaGreen, vgaBlue} = 12'h0F0;
            else if(h_cnt <= (x+4)*20+1 && h_cnt >= (x+4)*20-1 &&  (v_cnt+10)/20 == 38-y)
                {vgaRed, vgaGreen, vgaBlue} = 12'h0F0;
            else if((h_cnt+10)/20 == x+4 &&  v_cnt >= 479 && y < 14)
                {vgaRed, vgaGreen, vgaBlue} = 12'h0F0;
            else
                {vgaRed, vgaGreen, vgaBlue} = pixel;
        end
        else
            {vgaRed, vgaGreen, vgaBlue} = pixel_1;
    end
    else
        {vgaRed, vgaGreen, vgaBlue} = 12'h0;
end

// Frequency Divider
clock_divisor clk_wiz_0_inst(
  .clk(clk),
  .clk1(clk_25MHz),
  .clk22(clk_22)
);

// Reduce frame address from 640x480 to 320x240
mem_addr_gen mem_addr_gen_inst(
  .clk(clk_22),
  .rst(rst),
  .h_cnt(h_cnt),
  .v_cnt(v_cnt),
  .pixel_addr(pixel_addr)
);

win_player mem_addr_gen_inst_1(
  .clk(clk_22),
  .rst(rst),
  .h_cnt(h_cnt),
  .v_cnt(v_cnt),
  .player(player),
  .pixel_addr(pixel_addr_1)
);
     
// Use reduced 320x240 address to output the saved picture from RAM 
blk_mem_gen_0 blk_mem_gen_0_inst(
  .clka(clk_25MHz),
  .wea(0),
  .addra(pixel_addr),
  .dina(data[11:0]),
  .douta(pixel)
); 

blk_mem_gen_1 blk_mem_gen_1_inst(
  .clka(clk_25MHz),
  .wea(0),
  .addra(pixel_addr_1),
  .dina(data[11:0]),
  .douta(pixel_1)
); 

// Render the picture by VGA controller
vga_controller vga_inst(
  .pclk(clk_25MHz),
  .reset(rst),
  .hsync(hsync),
  .vsync(vsync),
  .valid(valid),
  .h_cnt(h_cnt),
  .v_cnt(v_cnt)
);
      
endmodule
