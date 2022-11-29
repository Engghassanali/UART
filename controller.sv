module controller(byte_ready_i,clear_baud_o,clear_o,t_byte_i,counter_of_i,counter_baud_of_i,start_o,shift_o,clk_i,reset_i,load_xmt_shftreg_o);
    input logic clk_i,reset_i,byte_ready_i,counter_baud_of_i,counter_of_i,t_byte_i;
    output logic load_xmt_shftreg_o,start_o,clear_o,clear_baud_o,shift_o;
    logic [1:0] state,next_State;
    localparam S0=2'b00;
    localparam S1=2'b01;
    localparam S2=2'b10;
    always_ff @( negedge clk_i ) begin
        if (reset_i)begin
            state <= S0;
        end
        else begin
            state <= next_State;
        end
    end
    always_ff @( posedge clk_i ) begin
        case (state)
            S0:if(!byte_ready_i)begin
                clear_baud_o <= 1'b1;
                clear_o <= 1'b1;
                load_xmt_shftreg_o <= 1'b1;
                next_State <= S0;
            end
            else if(byte_ready_i) begin
                clear_baud_o <= 1'b1;
                clear_o <= 1'b1;
                load_xmt_shftreg_o <= 1'b0;
                next_State <= S1;
            end
            S1:if(!t_byte_i)begin
                clear_o <= 1'b1;
                clear_baud_o <= 1'b1;
                load_xmt_shftreg_o <= 1'b1;
                next_State <= S1;
            end
            else if(t_byte_i)begin
                clear_o <= 1'b1;
                clear_baud_o <= 1'b1;
                load_xmt_shftreg_o <= 0;
                next_State <= S2;
            end
            S2: if(!counter_of_i && !counter_baud_of_i)begin
                start_o <= 1'b1;
                shift_o <= 1'b0;
                next_State <= S2;
            end
            else if(!counter_of_i && counter_baud_of_i)begin
                shift_o <= 1'b1;
                start_o <= 1'b1;
                next_State <= S2;
            end
            else if(counter_of_i && !counter_baud_of_i)begin
                start_o <= 1'b1;
                shift_o <= 1'b0;
                next_State <= S2;
            end
            else if(counter_of_i && counter_baud_of_i)begin
                start_o <= 1'b0;
                shift_o <= 1'b0;
                next_State <= S0;
            end
        endcase
    end
endmodule