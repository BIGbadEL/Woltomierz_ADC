`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2020 03:20:57 AM
// Design Name: 
// Module Name: transcoder
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

function real translate_code(input [11:0] code);
    integer v;
    automatic reg [11:0] bit_mask = 12'b100000000000;
    begin
        translate_code = 0.0;
        for(v = 0; v < 12; v = v + 1)
            if(code & (bit_mask >> v))
                translate_code += (3.3 / (2 ** (v + 1)));
    end
endfunction
