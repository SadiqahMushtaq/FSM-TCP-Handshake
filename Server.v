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


module Server(
    input wire clk,
    input wire reset,
    input wire received_syn,
    input wire received_ack,
    input wire syn_ack,
    output wire send_syn,
    output wire send_ack
    );
    
    reg [1:0] state_reg , state_next;
    // Define states
    localparam IDLE_HOLD = 2'b00;
    localparam SYN_RECEIVED = 2'b01;
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
            else if (received_syn) state_next <= SYN_RECEIVED;
            else if (received_ack) state_next <= ESTABLISHED;
        end
        
        SYN_RECEIVED: begin
            if (reset) state_next <= IDLE_HOLD;
//            else if (control) state_next <= SYN_SENT;
            else if (syn_ack) begin
                state_next <= IDLE_HOLD;
                seq_out <= 8'd200;
                ack_out <= seq_in + 1;
            end
        end
        
        ESTABLISHED: begin
            if (reset) state_next <= IDLE_HOLD;
//            else if (received_syn_ack) state_next <= ESTABLISHED;
            end
    endcase
end
    
endmodule
