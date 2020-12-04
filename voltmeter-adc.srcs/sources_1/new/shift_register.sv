`timescale 1ns / 1ps

module shift_register #(parameter bits=16) (input clk, rst, in, output reg [bits-1:0] out);
    always @(posedge clk, posedge rst)
        if(rst)
            out <= {bits{1'b0}};
        else
            out <= {out[bits-2:0], in};
endmodule
