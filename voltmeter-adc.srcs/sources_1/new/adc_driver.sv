`timescale 1ns / 1ps

module adc_driver #(parameter bits=16) (input clk, rst, start, miso, output cs, reg ready, output reg [bits-1:0] out);
    integer sampling_counter;
    wire is_sampling_done;

    typedef enum { IDLE, SAMPLING, DONE } states;
    states current_state, next_state;

    always @(posedge clk, posedge rst)
        current_state <= rst ? IDLE : next_state;

    always @* begin
        next_state <= IDLE;
        case(current_state)
            IDLE: next_state <= (start) ? SAMPLING : IDLE;
            SAMPLING: next_state <= (is_sampling_done) ? DONE : SAMPLING;
            DONE: next_state <= IDLE;
        endcase
    end

    assign cs = (current_state != SAMPLING);
       
    always @(posedge clk, posedge rst)
        if(rst || current_state == IDLE)
            sampling_counter <= bits;
        else if (current_state == SAMPLING)
            sampling_counter <= sampling_counter - 1;
    
    assign is_sampling_done = (sampling_counter == 0);
    
    reg [bits-1:0] read_bits;
    
    shift_register #(.bits(bits)) shreg (.clk(clk), .rst(rst), .in(miso), .out(read_bits));
    
    always @(posedge clk, posedge rst)
        if(rst) begin
            out <= {bits{1'b0}};
            ready <= 1'b0;
        end
        else if (current_state == DONE) begin 
            out <= read_bits;
            ready <= 1'b1;            
        end
        else 
            ready <= 1'b0;
            
endmodule
