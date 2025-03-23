`timescale 1ns / 1ps

module client_side(
    rst,
    clock,
    Control,
    RCV_SYN_ACK,
    SEND_SYN,
    SEND_ACK
);

input rst, Control, clock, RCV_SYN_ACK;

output reg SEND_SYN, SEND_ACK;

// States
parameter IDLE_HOLD_C = 2'b00;
parameter SYN_SENT = 2'b01;
parameter ESTABLISHED_C = 2'b10;

// State registers
reg [1:0] state_reg_c, state_next_c;

always @(posedge clock) begin
    if (rst) begin 
        state_reg_c <= IDLE_HOLD_C; 
        SEND_SYN <= 0; 
        SEND_ACK <= 0; 
    end
    else 
        state_reg_c <= state_next_c;
end


always @(state_reg_c or Control or RCV_SYN_ACK or posedge clock) begin
    case(state_reg_c)
        IDLE_HOLD_C: begin
            if (rst) 
                state_next_c <= IDLE_HOLD_C;
            else if (Control & RCV_SYN_ACK) 
                state_next_c <= ESTABLISHED_C;
            else if (Control) 
                state_next_c <= SYN_SENT;
            else 
                state_next_c <= IDLE_HOLD_C;
        end

        SYN_SENT: begin
            if (rst) 
                state_next_c <= IDLE_HOLD_C;
            else if (Control) begin
                state_next_c <= IDLE_HOLD_C;
                SEND_SYN <= 1;
            end
            else 
                state_next_c <= IDLE_HOLD_C;
        end

        ESTABLISHED_C: begin
            if (rst) 
                state_next_c <= IDLE_HOLD_C;
            else if (Control & RCV_SYN_ACK) begin
                SEND_ACK <= 1;
                state_next_c <= ESTABLISHED_C;
            end
            else 
                state_next_c <= IDLE_HOLD_C;
        end

        default: 
            state_next_c <= IDLE_HOLD_C;
    endcase
end

endmodule