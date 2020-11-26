`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2020 02:28:16 AM
// Design Name: 
// Module Name: clock_divider
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


module clock_divider #(parameter div=5) (input clk, rst, output reg sclk);

    integer counter;
    always @(posedge clk, posedge rst)
        if(rst)
            counter <= div;
        else if (counter == 0)
            counter <= div;
        else
            counter <= counter - 1;

    always @(posedge clk, posedge rst)
        if(rst)
            sclk <= 1'b0;
        else if (counter == 0)
            sclk <= ~sclk;
        
endmodule
