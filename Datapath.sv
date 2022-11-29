module mux(serial_out_o,start_o,Tx,clk_i);
    input logic serial_out_o,start_o,clk_i;
    output logic Tx;
    always_ff @( clk_i ) begin
        if(start_o)begin
            Tx <= serial_out_o;
        end
        else begin
            Tx <= 1'b1;
        end
    end
endmodule
module shift_reg(shift_o,load_xmt_shftreg_o,data_in,serial_out_o,clk_i,reset_i);
    input logic shift_o,load_xmt_shftreg_o,clk_i,reset_i;
    input logic [7:0] data_in;
    output logic serial_out_o;
    logic [7:0] shift;
    always_ff @(posedge clk_i ) begin
        if(reset_i)begin
            serial_out_o <= 0;
            end
        else begin
            if(load_xmt_shftreg_o)begin
                shift <= data_in;
            end
        if (shift_o)begin
            serial_out_o <= shift[0];
            shift <= {1'b0,shift[7:1]};
            end
        end
    end
endmodule
module Baud_Counter(clear_baud_o,counter_baud_of_i,clk_i);
    input logic clear_baud_o,clk_i;
    output logic counter_baud_of_i;
    logic [2:0] baud_counter = 3'b0;
    always_ff @(posedge clk_i ) begin
        if(clear_baud_o)begin
            baud_counter <= baud_counter + 1'b1;
        if (baud_counter == 3'b100)begin
            counter_baud_of_i <= 1'b1;
            baud_counter <= 1'b0;
            end
        else begin
            counter_baud_of_i <= 1'b0;
            end
        end
    end
endmodule
module Bit_Counter(clear_o,clk_i,counter_of_i);
    input logic clear_o,clk_i;
    output logic counter_of_i;
    logic [3:0] bit_counter = 4'b0;
    always_ff @(posedge clk_i ) begin
        if(clear_o)begin
            bit_counter <= bit_counter + 1'b1;
            if(bit_counter == 4'b1000)begin
                counter_of_i <= 1'b1;
                bit_counter <= 1'b0;
            end
            else begin
                counter_of_i <= 1'b0;
            end
        end
    end
endmodule