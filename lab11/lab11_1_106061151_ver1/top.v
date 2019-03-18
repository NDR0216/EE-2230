module top(
  input clk,
  input rst,
  input en,
  output [3:0] vgaRed,
  output [3:0] vgaGreen,
  output [3:0] vgaBlue,
  output hsync,
  output vsync
);

wire [11:0] data;
wire clk_25MHz;
wire clk_22;
wire [16:0] pixel_addr;
wire [11:0] pixel;
wire valid;
wire [9:0] h_cnt; //640
wire [9:0] v_cnt;  //480

wire clk_100hz;
wire en_deb;
wire en_op;
wire state;

assign {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel:12'h0;

freq_div U0 ( , clk_100hz, , , , clk, ~rst);
debounce U1 (en_deb, en, clk_100hz, ~rst);
one_pulse U2 (en_op, en_deb, clk_100hz, ~rst);
fsm_button U3 (state, en_op, clk_100hz, ~rst);

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
  .en(state),
  .h_cnt(h_cnt),
  .v_cnt(v_cnt),
  .pixel_addr(pixel_addr)
);
     
// Use reduced 320x240 address to output the saved picture from RAM 
blk_mem_gen_0 blk_mem_gen_0_inst(
  .clka(clk_25MHz),
  .wea(0),
  .addra(pixel_addr),
  .dina(data[11:0]),
  .douta(pixel)
); 

// Render the picture by VGA controller
vga_controller   vga_inst(
  .pclk(clk_25MHz),
  .reset(rst),
  .hsync(hsync),
  .vsync(vsync),
  .valid(valid),
  .h_cnt(h_cnt),
  .v_cnt(v_cnt)
);
      
endmodule
