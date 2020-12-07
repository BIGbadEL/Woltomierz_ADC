`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.10.2020 21:28:28
// Design Name: 
// Module Name: tb
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


module test_uart_driver();

    localparam d = 20, s = 8, brate = 115200;
    reg clk, rst, str, str2, str_rec;
    reg [s-1:0] dat;
    wire [s-1:0] dat_rec;
    integer i, n;
    reg [s-1:0] mem [1:d];
    initial $readmemh("tr_val.mem", mem);
    reg miso;
    reg cs, sclk;
    wire [15:0] data_to_send = {1'b1, {3{1'b0}}, 1'b1, 1'b1, {9{1'b0}}, 1'b1};
    
//    uart_driver #(.nd(d)) uut (.clk(clk), .rstp(rst), .rx(tx), .tx(rx), 
//    .startAdcSampling(startAdcSampling), // output 
//    .finishedAdcSampling(finishedAdcSampling), //input
//    .dataToTransfer(dataToTransfer)); //input

    
    top tp(.clk(clk), .rst(rst), .miso(miso), .rx(tx), .cs(cs), .sclk(sclk), .tx(rx), .out(out));
    
    simple_transmitter #(.fclk(100_000_000), .baudrate(brate), .nb(8)) transmiter
        (.clk(clk), .rst(~rst), .str(str | str2), .val(dat), .trn(tx), .fin(fin));
    simple_receiver #(.fclk(100_000_000), .baudrate(brate)) receiver 
        (.clk(clk), .rst(~rst), .str(str_rec), .rec(rx), .val(dat_rec), .finr(finr));
    
    initial begin
        clk = 1'b0;
        miso <= 1'b0;
        forever #5 clk = ~clk;
    end
    
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
    
    initial begin
        rst = 1'b0;
        #2 rst = 1'b1;
        repeat(5) @(posedge clk);
        #2 rst = 1'b0;
    end
    
    initial begin
        i = 1;
        dat = mem[i];
        str = 1'b0;
        str2 = 1'b0; 
        @(negedge rst);
        repeat(5) @(posedge clk);
        #2 str = 1'b1;
        repeat(5) @(posedge clk);
        #2 str = 1'b0;   
    end
    
    always @(negedge fin)
            begin
                dat = mem[i];
                i = i + 1;
                repeat(5) @(negedge clk);
                str2 = 1'b1;
                repeat(5) @(posedge clk);
                #2 str2 = 1'b0;           
            end
    
    always @(posedge finr) begin
        $display("Received back: %h", dat_rec);
        n = n + 1;
    end
    initial begin
        n = 0;
        str_rec = 1'b0;
        wait (fin & i == d+1); 
        str_rec = 1'b1;
        repeat(50) @(posedge clk);
        wait (n == d);
        repeat(50) @(posedge clk);
        # 10000 $finish;
    end
        

endmodule
