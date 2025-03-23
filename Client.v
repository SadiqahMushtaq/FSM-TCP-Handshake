`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2024 02:25:07 PM
// Design Name: 
// Module Name: Client
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


module Client(
    input wire clk,
    input wire reset,
    input wire send_syn,
    input wire received_syn_ack,
    input wire control,
    output reg send_ack,
    output reg send_syn
    );
    
    reg [1:0] state_reg , state_next;
    // Define states
    localparam IDLE_HOLD = 2'b00;
    localparam SYN_SENT = 2'b01;
    localparam ESTABLISHED = 2'b10;
    
    initial begin
    end
    
    always @(posedge clk or negedge reset) begin
        if (reset) begin
            state_reg <= IDLE_HOLD;
        end
        else begin
            state_reg <= state_next;
        end
    end

   

always @ (posedge clk or state_reg) begin 
    case (state_reg) 
        IDLE_HOLD: begin
            if (reset) state_next <= IDLE_HOLD;
            else if (control) begin
                state_next <= SYN_SENT;
                seq_out <= 8'd100;           // hardcoded arbritary sequence for now
            end
            else if (received_syn_ack) begin 
                state_next <= ESTABLISHED;
//                ack_in = 8'd101;
            end
        end
        
        SYN_SENT: begin
            if (reset) state_next <= IDLE_HOLD;
//            else if (control) state_reg <= SYN_SENT;
            else if (send_syn) state_next <= IDLE_HOLD;
            
        end
        
        ESTABLISHED: begin
            seq_out <= ack_in;
            ack_out <= seq_in + 1;
            ACK <= 1;
            if (reset) state_next <= IDLE_HOLD;
//            else if (received_syn_ack) state_reg <= ESTABLISHED;
            end
    endcase
end
    
endmodule
