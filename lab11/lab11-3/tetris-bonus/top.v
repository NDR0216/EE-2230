module top(
  input clk,
  input rst,
  output [3:0] vgaRed,
  output [3:0] vgaGreen,
  output [3:0] vgaBlue,
  output hsync,
  output vsync
);


wire clk_25MHz;
wire valid;
wire [9:0] h_cnt; //640
wire [9:0] v_cnt; //480

wire clk_1hz;
wire [3:0] tetric;
wire [2:0] color;
wire [3:0] grid_vgaRed, grid_vgaGreen, grid_vgaBlue;

reg [599:0] grid; 
wire [599:0] next_grid;
reg [29:0] row0, row1, next_row0;

reg [7:0] pos3, pos2, pos1, pos0;
wire [7:0] next_pos3, next_pos2, next_pos1, next_pos0;

freq_div U0 (clk_1hz, , , , , clk, ~rst);
LFSR_16bits U1 (tetric, clk, ~rst);

assign vgaRed = (h_cnt < 200 || h_cnt > 400) ? 4'hF : grid_vgaRed;
assign vgaGreen = (h_cnt < 200 || h_cnt > 400) ? 4'hF : grid_vgaGreen;
assign vgaBlue = (h_cnt < 200 || h_cnt > 440) ? 4'hF : grid_vgaBlue;

assign color = {grid[ ((h_cnt-200)/24+(v_cnt/24)*10)*3+2], 
                grid[ ((h_cnt-200)/24+(v_cnt/24)*10)*3+1], 
                grid[ ((h_cnt-200)/24+(v_cnt/24)*10)*3]};

assign next_grid = {grid[569:0], row0};

assign next_pos3 = (pos3+10 >= 200) ? 8'd0 : pos3+8'd10;
assign next_pos2 = (pos2+10 >= 200) ? 8'd0 : pos2+8'd10;
assign next_pos1 = (pos1+10 >= 200) ? 8'd0 : pos1+8'd10;
assign next_pos0 = (pos0+10 >= 200) ? 8'd0 : pos0+8'd10;

always @(posedge clk_1hz or posedge rst)
begin
    if(rst == 1'b0)
    begin
        grid <= 600'd0;
        next_row0 <= 30'd0;
        pos3 <= 4'd0;
        pos2 <= 4'd0;
        pos1 <= 4'd0;
        pos0 <= 4'd0;            
    end
    else
    begin
        grid <= next_grid;
        next_row0 <= row1;
        pos3 <= next_pos3;
        pos2 <= next_pos2;                    
        pos1 <= next_pos1;
        pos0 <= next_pos0;
    end
end

always @*
begin
    row0 = next_row0;
    row1 = 30'd0;
    
    if(pos3 == 0 && pos2 == 0 && pos1 == 0 && pos0 == 0)
    begin
        case(tetric%4'd7)
            4'd0 : begin
                {row0[9], row0[10], row0[11]} = 3'd1; 
                {row0[12], row0[13], row0[14]} = 3'd1; 
                {row0[15], row0[16], row0[17]} = 3'd1; 
                {row0[18], row0[19], row0[20]} = 3'd1; 
            end
            4'd1 : begin
                {row0[9], row0[10], row0[11]} = 3'd2;
                {row0[12], row0[13], row0[14]} = 3'd2;
                {row0[15], row0[16], row0[17]} = 3'd2;
                {row1[9], row1[10], row1[11]} = 3'd2;
            end
            4'd2 : begin
                {row0[9], row0[10], row0[11]} = 3'd3; 
                {row0[12], row0[13], row0[14]} = 3'd3; 
                {row0[15], row0[16], row0[17]} = 3'd3; 
                {row1[15], row1[16], row1[17]} = 3'd3; 
            end
            4'd3 : begin
                {row0[12], row0[13], row0[14]} = 3'd4; 
                {row0[15], row0[16], row0[17]} = 3'd4; 
                {row1[12], row1[13], row1[14]} = 3'd4; 
                {row1[15], row1[16], row1[17]} = 3'd4; 
            end
            4'd4 : begin
                {row0[9], row0[10], row0[11]} = 3'd5; 
                {row0[12], row0[13], row0[14]} = 3'd5; 
                {row1[12], row1[13], row1[14]} = 3'd5; 
                {row1[15], row1[16], row1[17]} = 3'd5; 
            end
            4'd5 : begin
                {row0[9], row0[10], row0[11]} = 3'd6; 
                {row0[12], row0[13], row0[14]} = 3'd6; 
                {row0[15], row0[16], row0[17]} = 3'd6; 
                {row1[12], row1[13], row1[14]} = 3'd6; 
            end
            4'd6 : begin
                {row0[12], row0[13], row0[14]} = 3'd7; 
                {row0[15], row0[16], row0[17]} = 3'd7; 
                {row1[9], row1[10], row1[11]} = 3'd7; 
                {row1[12], row1[13], row1[14]} = 3'd7; 
            end
        endcase
    end
end


clock_divisor clk_wiz_0_inst(
  .clk(clk),
  .clk1(clk_25MHz)
);

pixel_gen pixel_gen_inst(
  .color(color),
  .valid(valid),
  .vgaRed(grid_vgaRed),
  .vgaGreen(grid_vgaGreen),
  .vgaBlue(grid_vgaBlue)
);

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
