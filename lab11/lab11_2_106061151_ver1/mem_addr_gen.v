module mem_addr_gen(
  input clk,
  input rst,
  input [9:0] h_cnt,
  input [9:0] v_cnt,
  input [3:0] BCD4,
  input [3:0] BCD3,
  input [3:0] BCD2,
  input [3:0] BCD1,
  input [3:0] BCD0,
  output reg [16:0] pixel_addr
);

wire [16:0] addr4, addr3, addr2, addr1, addr0;
    
addr_BCD_converter U0 (addr0, BCD0, h_cnt, v_cnt);
addr_BCD_converter U1 (addr1, BCD1, h_cnt, v_cnt);
addr_BCD_converter U2 (addr2, BCD2, h_cnt, v_cnt);
addr_BCD_converter U3 (addr3, BCD3, h_cnt, v_cnt);
addr_BCD_converter U4 (addr4, BCD4, h_cnt, v_cnt);

always @*
begin
    if(h_cnt < 140 || h_cnt > 490 || v_cnt < 210 || v_cnt > 280)
        pixel_addr = 76800;
    else if(h_cnt < 210)
        pixel_addr = addr4;
    else if(h_cnt < 280)
        pixel_addr = addr3;
    else if(h_cnt < 350)
        pixel_addr = addr2;
    else if(h_cnt < 420)
        pixel_addr = addr1;
    else
        pixel_addr = addr0;
end
    
endmodule
