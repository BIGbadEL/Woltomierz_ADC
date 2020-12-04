`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH
// Engineer: AS
// Create Date: 31.10.2020 20:28:28
// Design Name: 
// Module Name: memory
//////////////////////////////////////////////////////////////////////////////////

module memory #(parameter deep=20, size=8) (input clk, wr, rd, input [$clog2(deep)-1:0] adr, input [size-1:0] datin, 
    output reg [size-1:0] datout);

(*ram_style = "block"*) reg [size-1:0] mem [1:deep];
initial $readmemh("init_val.mem", mem);

always @(posedge clk)
    if (wr)
        mem[adr] <= datin;
    else if (rd)
        datout <= mem[adr];
        
endmodule
