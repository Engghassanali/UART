module tb_UART;
    logic t_byte_i,byte_ready_i,clk_i,reset_i;
    logic[7:0] data_in;
    logic Tx;
    UART dut( .t_byte_i(t_byte_i), .byte_ready_i(byte_ready_i), .Tx(Tx), .data_in(data_in),
    .clk_i(clk_i), .reset_i(reset_i));
    initial begin
        clk_i = 0;
        forever begin
        #5 clk_i=~clk_i;
    end
    end
    initial begin
        reset_i=1;
        data_in = 8'b10101010;
        byte_ready_i = 1'b0;
        #10
        reset_i=0;
        byte_ready_i = 1'b1;
        #10
        t_byte_i = 1;
        byte_ready_i = 0;
        #500
        $stop;
    end
endmodule