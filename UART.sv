module UART(t_byte_i,byte_ready_i,Tx,data_in,clk_i,reset_i);
    input logic t_byte_i,byte_ready_i,clk_i,reset_i;
    input logic[7:0] data_in;
    output logic Tx;
    logic clear_baud_o,clear_o,counter_of_i,counter_baud_of_i,start_o,shift_o,load_xmt_shftreg_o,
    serial_out_o;
    always_comb begin
        if(reset_i)begin
            Tx <= 0;
        end
    end
    controller Controller(byte_ready_i,clear_baud_o,clear_o,t_byte_i,counter_of_i,counter_baud_of_i,start_o,shift_o,clk_i,reset_i,load_xmt_shftreg_o);
    mux M2x1(serial_out_o,start_o,Tx,clk_i);
    shift_reg Sh(shift_o,load_xmt_shftreg_o,data_in,serial_out_o,clk_i,reset_i);
    Baud_Counter Bd_C(clear_baud_o,counter_baud_of_i,clk_i);
    Bit_Counter Bi_C(clear_o,clk_i,counter_of_i);
endmodule