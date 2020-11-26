create_clock -name clk100Mhz -period 10 [get_ports clk]
create_generated_clock -name slowclk -source [get_ports clk] -divide_by 5 [get_nets sclk]
