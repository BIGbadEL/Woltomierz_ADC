`timescale 1ns / 1ps

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
