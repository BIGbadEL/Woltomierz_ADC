`timescale 1ns / 1ps

module top #(parameter bits=16) (input clk, rst, start, miso, rx, output cs, sclk, tx, output [7:0] out);
    // TODO: add UART driver which takes care of rx and tx
    // TODO: generate start based on UART rx channel
    // TODO: transmit 12 of 16 read bits from the adc via tx channel
    // TODO: remove 'start' from input pins and 'out' from output pins
    // TODO: Works? :D
    
    wire [bits-1:0] OUT;
    
    // .div -> 5 times slower clock
    clock_divider #(.div(5)) clockDivider (.clk(clk), .rst(rst), .sclk(sclk));
 
    uart_driver #(.nd(20)) uut (.clk(clk), .rstp(rst), .rx(tx), .tx(rx), 
    .startAdcSampling(start), // output 
    .finishedAdcSampling(ready), //input
    .dataToTransfer(OUT)); //input
        
    // .bits -> number of bits that will be sampled from the miso line and saved to out
    adc_driver #(.bits(16)) adcDriver(.clk(sclk), .rst(rst), .start(start), .miso(miso), .cs(cs), .ready(ready), .out(OUT));
    
    assign out = OUT[7:0];
endmodule
