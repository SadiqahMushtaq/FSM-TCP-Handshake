`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2024 03:42:35 PM
// Design Name: 
// Module Name: Top
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


module Top(
    input wire clk,
    input wire reset,
    input wire control,
    input wire SYN,
    input wire SYN_ACK,
    input wire ACK
    );
    
    // Instantiate the module
    Client client_inst1 (
        .seq_in(seq_in),
        .ack_in(ack_in_tb),
        .clk(clk),
        .reset(reset),
        .send_syn(send_syn),                  // should be 0
        .received_syn_ack(received_syn_ack),  // should be 0 at this point
        .control(control_tb),                 // should be 1
        .seq_out(seq_out_tb),
        .ack_out(ack_out_tb),
        .ACK(ACK)
    );
    
    Server server_inst1 (
        .seq_in(seq_in),
        .ack_in(ack_in),
        .clk(clk_tb),
        .reset(reset),
        .received_syn(received_syn),
        .received_ack(ACK),
        .syn_ack(syn_ack),
        .seq_out(seq_out),
        .ack_out(ack_out)
    );
endmodule
