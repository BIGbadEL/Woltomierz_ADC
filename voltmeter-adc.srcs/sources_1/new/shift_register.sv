`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2020 02:16:53 AM
// Design Name: 
// Module Name: shift_register
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


module shift_register #(parameter bits=16) (input clk, rst, in, output reg [bits-1:0] out);
    always @(posedge clk, posedge rst)
        if(rst)
            out <= {bits{1'b0}};
        else
            out <= {out[bits-2:0], in};
endmodule
