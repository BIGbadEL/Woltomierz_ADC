`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2020 02:58:36 AM
// Design Name: 
// Module Name: test_adc_driver
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


module test_adc_driver();
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
    


    reg clk, rst, miso, start;
    reg cs, ready, sclk;
    reg [15:0] out;

    clock_divider clkdiv (.clk(clk), .rst(rst), .sclk(sclk));
    adc_driver uut(.clk(sclk), .rst(rst), .start(start), .miso(miso), .cs(cs), .ready(ready), .out(out));
    
    initial begin
        clk <= 1'b0;
        rst <= 1'b0;
        miso <= 1'b0;
        start <= 1'b0;
        forever #5 clk <= ~clk;
    end
    
    initial begin
        #20 rst <= 1'b1;
        #10 rst <= 1'b0;
        #20 start <= 1'b1;
        #100 start <= 1'b0;
    end

//  wire [15:0] data_to_send = {1'b1, {3{1'b0}}, 1'b1, 1'b1, {9{1'b0}}, 1'b1};
    wire [15:0] data_to_send = {16{1'b1}};

    // If cs is down, send bits
    integer counter;
    always @(posedge sclk, posedge rst)
        if (rst) begin
            miso <= 1'b0;
            counter <= 16;
        end
        else if (counter > 0 && ~cs) begin
            miso <= data_to_send[counter - 1];
            counter <= counter - 1; 
        end

    real voltage;
    always @(posedge clk, posedge rst)
        if(rst)
            voltage <= 0.0;
        else if (ready)
            voltage <= translate_code(out[11:0]);
endmodule
