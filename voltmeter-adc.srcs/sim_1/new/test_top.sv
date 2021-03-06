`timescale 1ns / 1ps

module test_top();

    reg clk, rst, miso;
    reg cs, sclk;
    reg [7:0] out;

    top uut(.clk(clk), .rst(rst), .miso(miso), .cs(cs), .sclk(sclk), .out(out));

    initial begin
        clk <= 1'b0;
        rst <= 1'b0;
        miso <= 1'b0;
        forever #5 clk <= ~clk;
    end
    
    initial begin
        #20 rst <= 1'b1;
        #10 rst <= 1'b0;
    end

    wire [15:0] data_to_send = {1'b1, {3{1'b0}}, 1'b1, 1'b1, {9{1'b0}}, 1'b1};
    // wire [15:0] data_to_send = {16{1'b1}};

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

endmodule
