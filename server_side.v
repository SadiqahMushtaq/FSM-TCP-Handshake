`timescale 1ns / 1ps

module server_side (
    rst,
    clock,
    RCV_SYN,
    RCV_ACK,
    SEND_SYN_ACK
);

input rst, clock, RCV_SYN, RCV_ACK;

output SEND_SYN_ACK;

reg SEND_SYN_ACK;

// FSM States
parameter IDLE_HOLD_S = 2'b00;
parameter SYN_RECEIVED = 2'b01;
parameter ESTABLISHED_S = 2'b10;

// State registers
reg [1:0] state_reg_s, state_next_s;

always @(posedge clock) begin
    if (rst) 
        state_reg_s <= IDLE_HOLD_S;
    else 
        state_reg_s <= state_next_s;
end

always @(state_reg_s or RCV_SYN or RCV_ACK or posedge clock) begin
    case(state_reg_s)
        IDLE_HOLD_S: begin
            if (rst) 
                state_next_s <= IDLE_HOLD_S;
            else if (RCV_SYN & ~RCV_ACK) 
                state_next_s <= SYN_RECEIVED;
            else if (RCV_SYN & RCV_ACK) 
                state_next_s <= ESTABLISHED_S;
            else 
                state_next_s <= IDLE_HOLD_S;
        end

        SYN_RECEIVED: begin
            if (rst) 
                state_next_s <= IDLE_HOLD_S;
            else if (RCV_SYN & ~RCV_ACK) begin 
                state_next_s <= IDLE_HOLD_S;
                SEND_SYN_ACK = 1;
            end
            else 
                state_next_s <= IDLE_HOLD_S;
        end

        ESTABLISHED_S: begin
            if (rst) 
                state_next_s <= IDLE_HOLD_S;
            else if (RCV_SYN & RCV_ACK) 
                state_next_s <= ESTABLISHED_S;
            else 
                state_next_s <= ESTABLISHED_S;
        end

        default: 
            state_next_s <= IDLE_HOLD_S;
    endcase
end

endmodule