`define S0 3'b000
`define S1 3'b001
`define S2 3'b010
`define S3 3'b011
`define S4 3'b100
`define S5 3'b101

module top(
  input clk,
  input rst,
  inout PS2_DATA,
  inout PS2_CLK,
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

wire [511:0] key_down;
wire [8:0] last_change;
wire key_valid;
wire [3:0] key;

reg [3:0] BCD4, next_BCD4;
reg [3:0] BCD3, next_BCD3;
reg [3:0] BCD2, next_BCD2;
reg [3:0] BCD1, next_BCD1;
reg [3:0] BCD0, next_BCD0;
reg [3:0] num_ten, next_num_ten;
reg [3:0] num_one, next_num_one;
reg [2:0] state, next_state;
wire [6:0] num1;
wire [3:0] operand;
wire [6:0] num2;
reg [13:0] ans;

assign {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel:12'h0;

KeyboardDecoder U0 (key_down, last_change, key_valid, PS2_DATA, PS2_CLK, rst, clk);
kb_convert U1 (key, last_change);
    
always @(posedge clk or posedge rst)
begin
    if(rst == 1'b1)
    begin
        BCD4 <= 4'd15;
        BCD3 <= 4'd15;
        BCD2 <= 4'd15;
        BCD1 <= 4'd15;
        BCD0 <= 4'd15;
        num_ten <= 4'd0;
        num_one <= 4'd0;
        state <= `S0;
    end
    else
    begin
        BCD4 <= next_BCD4;
        BCD3 <= next_BCD3;
        BCD2 <= next_BCD2;
        BCD1 <= next_BCD1;
        BCD0 <= next_BCD0;
        num_ten <= next_num_ten;
        num_one <= next_num_one;            
        state <= next_state;
    end
end
    
assign num1 = (state == `S0) ? 7'd10*num_ten + num_one : num1;
assign operand = (state == `S2) ? key : operand;
assign num2 = (state == `S3) ? 7'd10*num_ten + num_one : num2;
    
always @*
begin
    next_BCD4 = BCD4;
    next_BCD3 = BCD3;
    next_BCD2 = BCD2;
    next_BCD1 = BCD1;
    next_BCD0 = BCD0;
    next_num_ten = num_ten;
    next_num_one = num_one;
  
    case(state)
    `S0 : begin
        if(key_valid == 1'b0)
            next_state = `S0;
        else if(key == 4'd10 || key == 4'd11 || key == 4'd12)
            next_state = `S2;
        else
            next_state = `S1;
        
        if(key_valid == 1'b1)
        begin
            next_BCD4 = 4'd15;
            next_BCD3 = 4'd15;
            next_BCD2 = 4'd15;
        end
    end
    `S1 : begin //press
        next_state = (key_valid == 1'b1) ? `S0 : `S1;
         
        if(key_valid == 1'b1)
        begin
            next_num_ten = num_one;
            next_num_one = key;
            next_BCD1 = (num_one == 4'd0) ? 4'd15 : num_one;
            next_BCD0 = key;
        end    
    end
    `S2 : begin //operand
        next_state = (key_valid == 1'b1) ? `S3 : `S2;
        
        if(key_valid == 1'b1)
        begin  
            next_BCD2 = BCD1;
            next_BCD1 = BCD0;
            next_BCD0 = key;
            next_num_ten = 4'd0;
            next_num_one = 4'd0;
        end
    end
    `S3 : begin
        if(key_valid == 1'b0)
            next_state = `S3;
        else if(key == 4'd15)
            next_state = `S5;
        else
            next_state = `S4;
    end
    `S4 : begin //press
        next_state = (key_valid == 1'b1) ? `S3 : `S4;
         
        if(key_valid == 1'b1)
        begin
            if(BCD2 == 4'd10 || BCD2 == 4'd11 || BCD2 == 4'd12)
            begin
                next_BCD1 = BCD0;
                next_BCD0 = key;
            end
            else
            begin
                next_BCD4 = BCD3;
                next_BCD3 = BCD2;
                next_BCD2 = BCD1;
                next_BCD1 = BCD0;
                next_BCD0 = key;
            end
                  
            next_num_ten = num_one;
            next_num_one = key;  
        end
    end
    `S5 : begin //enter
        next_state = (key_valid == 1'b1) ? `S0 : `S5;
        
        next_BCD4 = 4'd15; 
        next_BCD3 = (operand == 4'd11 && num1 < num2)? 4'd11 : ans/14'd1000;
        next_BCD2 = (ans%14'd1000) / 14'd100;
        next_BCD1 = (ans%14'd100) / 14'd10;
        next_BCD0 = ans%14'd10;
        
        if(key_valid == 1'b1)
        begin
            next_num_ten = 4'd0;
            next_num_one = 4'd0;
        end     
    end
endcase
        
case(operand)
    4'd10 : ans = num1 + num2;
    4'd11 : ans = (num1 >= num2) ? num1 - num2 : num2 - num1;
    4'd12 : ans = num1 * num2;
endcase

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
  .BCD4(BCD4),
  .BCD3(BCD3),
  .BCD2(BCD2),
  .BCD1(BCD1),
  .BCD0(BCD0),
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
