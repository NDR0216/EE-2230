# Clock
set_property PACKAGE_PIN W5 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]

# active low reset
set_property PACKAGE_PIN V17 [get_ports {rst_n}]
set_property IOSTANDARD LVCMOS33 [get_ports {rst_n}]

# push button input
set_property PACKAGE_PIN U18 [get_ports {pb_in}]
set_property IOSTANDARD LVCMOS33 [get_ports {pb_in}]

# led 1-Hz output
set_property PACKAGE_PIN U16 [get_ports {led_1}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_1}]

# led push button
set_property PACKAGE_PIN E19 [get_ports {led_pb}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_pb}]

# 1ed 1 pulse
set_property PACKAGE_PIN U19 [get_ports {led_1pulse}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_1pulse}]
