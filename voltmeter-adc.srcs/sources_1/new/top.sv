`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2020 11:27:27 AM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top #(parameter bits=16) (input clk, rst, start, miso, output cs, sclk, reg [bits-1:0] out);

    // TODO: add UART driver which takes care of rx and tx
    // TODO: generate start based on UART rx channel
    // TODO: transmit 12 of 16 read bits from the adc via tx channel
    // TODO: remove 'start' from input pins and 'out' from output pins
    // TODO: Works? :D
    
    // .div -> 5 times slower clock
    clock_divider #(.div(5)) clockDivider (.clk(clk), .rst(rst), .sclk(sclk));
    
    // .bits -> number of bits that will be sampled from the miso line and saved to out
    adc_driver #(.bits(16)) adcDriver(.clk(sclk), .rst(rst), .start(start), .miso(miso), .cs(cs), .ready(ready), .out(out));

endmodule
