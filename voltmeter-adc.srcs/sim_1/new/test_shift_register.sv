`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2020 02:20:58 AM
// Design Name: 
// Module Name: test_shift_register
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


module test_shift_register();
    reg clk, rst, in;
    reg [15:0] out; 

    shift_register #(.bits(16)) uut (.clk(clk), .rst(rst), .in(in), .out(out));

    initial begin
        clk <= 1'b0;
        rst <= 1'b0;
        in <= 1'b0;
        forever #5 clk <= ~clk;
    end
    
    wire [15:0] data_to_send = {1'b1, 1'b1, {8{1'b0}}, 1'b1, 1'b1};
    
    always @(posedge clk, posedge rst)
        if(rst)
            in <= 1'b0;
        else
            in <= $urandom%2;

endmodule
