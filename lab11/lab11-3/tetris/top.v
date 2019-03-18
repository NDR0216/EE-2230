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

reg [599:0] grid, next_grid;
reg [29:0] row0, next_row0;

freq_div U0 (clk_1hz, , , , , clk, ~rst);
LFSR_16bits U1 (tetric, clk, ~rst);

assign vgaRed = (h_cnt < 200 || h_cnt > 440) ? 4'h0 : grid_vgaRed;
assign vgaGreen = (h_cnt < 200 || h_cnt > 440) ? 4'h0 : grid_vgaGreen;
assign vgaBlue = (h_cnt < 200 || h_cnt > 440) ? 4'h0 : grid_vgaBlue;

assign color = {grid[ ((h_cnt-200)/24+(v_cnt/10'd24)*10)*3+2], 
                grid[ ((h_cnt-200)/24+(v_cnt/10'd24)*10)*3+1], 
                grid[ ((h_cnt-200)/24+(v_cnt/10'd24)*10)*3]};
                
always @(posedge clk_1hz or posedge rst)
begin
    if(rst == 1'b1)
    begin
        grid <= 600'd0;
        row0 <= 30'd0;
    end
    else
    begin
        grid <= next_grid;
        row0 <= next_row0;
    end
end

always @*
begin
    next_grid = {grid[569:0], row0};
    next_row0 = 30'd0;
    
    if(next_grid == 600'd0)
    begin
        case(tetric%4'd7)
            4'd0 : begin
                {next_grid[9], next_grid[10], next_grid[11]} = 3'd1; 
                {next_grid[12], next_grid[13], next_grid[14]} = 3'd1; 
                {next_grid[15], next_grid[16], next_grid[17]} = 3'd1; 
                {next_grid[18], next_grid[19], next_grid[20]} = 3'd1; 
            end
            4'd1 : begin
                {next_grid[9], next_grid[10], next_grid[11]} = 3'd2;
                {next_grid[12], next_grid[13], next_grid[14]} = 3'd2;
                {next_grid[15], next_grid[16], next_grid[17]} = 3'd2;
                {next_row0[9], next_row0[10], next_row0[11]} = 3'd2;
            end
            4'd2 : begin
                {next_grid[9], next_grid[10], next_grid[11]} = 3'd3; 
                {next_grid[12], next_grid[13], next_grid[14]} = 3'd3; 
                {next_grid[15], next_grid[16], next_grid[17]} = 3'd3; 
                {next_row0[15], next_row0[16], next_row0[17]} = 3'd3; 
            end
            4'd3 : begin
                {next_grid[12], next_grid[13], next_grid[14]} = 3'd4; 
                {next_grid[15], next_grid[16], next_grid[17]} = 3'd4; 
                {next_row0[12], next_row0[13], next_row0[14]} = 3'd4; 
                {next_row0[15], next_row0[16], next_row0[17]} = 3'd4; 
            end
            4'd4 : begin
                {next_grid[9], next_grid[10], next_grid[11]} = 3'd5; 
                {next_grid[12], next_grid[13], next_grid[14]} = 3'd5; 
                {next_row0[12], next_row0[13], next_row0[14]} = 3'd5; 
                {next_row0[15], next_row0[16], next_row0[17]} = 3'd5; 
            end
            4'd5 : begin
                {next_grid[9], next_grid[10], next_grid[11]} = 3'd6; 
                {next_grid[12], next_grid[13], next_grid[14]} = 3'd6; 
                {next_grid[15], next_grid[16], next_grid[17]} = 3'd6; 
                {next_row0[12], next_row0[13], next_row0[14]} = 3'd6; 
            end
            4'd6 : begin
                {next_grid[12], next_grid[13], next_grid[14]} = 3'd7; 
                {next_grid[15], next_grid[16], next_grid[17]} = 3'd7; 
                {next_row0[9], next_row0[10], next_row0[11]} = 3'd7; 
                {next_row0[12], next_row0[13], next_row0[14]} = 3'd7; 
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
