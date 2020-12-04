`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.09.2020 11:33:56
// Design Name: 
// Module Name: simple_receiver
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


module simple_receiver #(parameter fclk = 100_000_000, baudrate = 9600) (input clk, rst, str, rec, output [7:0] val, output reg finr);
//230400
localparam ratio = calc_ratio(fclk, baudrate);
integer cnt;
reg en16x, div;
reg [3:0] cnt16;
reg [4:0] cnt8;
reg [7:0] receiver_reg;

always @(posedge clk) 
    if(~rst) begin
        cnt <= 0;
        en16x <= 1'b0;
    end else 
        if(cnt == 0) begin
            cnt <= ratio - 1;
            en16x <= 1'b1;
        end else begin
            cnt <= cnt - 1;
            en16x <= 1'b0;    
        end
        
 always @(posedge clk) 
    if(~rst) 
        cnt16 <= 4'h0;
    else
    if (en16x)
        if (cnt16 == 4'hf)
            cnt16 <= 4'h0;
        else
            cnt16 <= cnt16 + 1'b1;

always @(cnt16)
    if (cnt16 == 4'hf)
        div <= 1'b1;
    else
        div <= 1'b0;

always @(posedge div, negedge rst) 
    if (~rst) begin
        cnt8 <= 5'b0; 
        receiver_reg <=8'b0 ;
    end else begin
        receiver_reg <= {rec, receiver_reg[7:1]}; 
        if (cnt8 == 5'h9) begin
            cnt8 <= 5'b0; 
            //receiver_reg <= 8'b0;
        end else 
            cnt8 <= cnt8 + 1;
    end

assign val = (cnt8 == 5'h9)?receiver_reg:8'h0;

always @(posedge clk, negedge rst) 
    if (~rst)    
        finr <= 1'b0;
    else if (cnt8 == 5'h9 & str)
        finr <= 1'b1;
    else
        finr <= 1'b0;
        
function integer calc_ratio(input integer fclk, baudrate);
integer brate_mult16_div2, reminder, ratio;
begin
    brate_mult16_div2 = 8*baudrate;
    reminder = fclk % (16 * baudrate);
    ratio = fclk / (16 * baudrate);
    if (brate_mult16_div2 < reminder)
        calc_ratio = ratio+1;
    else
        calc_ratio = ratio;
end
endfunction

endmodule
