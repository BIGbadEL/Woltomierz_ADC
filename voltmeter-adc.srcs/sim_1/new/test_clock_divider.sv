`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2020 02:31:36 AM
// Design Name: 
// Module Name: test_clock_divider
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


module test_clock_divider();

    reg clk, rst, sclk; 

    clock_divider #(.div(5)) uut (.clk(clk), .rst(rst), .sclk(sclk));

    initial begin
        clk <= 1'b0;
        rst <= 1'b0;
        sclk <= 1'b0;
        forever #5 clk <= ~clk;
    end
    
    initial begin
        #10 rst <= 1'b1;
        #10 rst <= 1'b0;
    end
  
endmodule
