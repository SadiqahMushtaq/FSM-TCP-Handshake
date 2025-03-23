`timescale 1ns / 1ps


module TCP (
    rst,
    clock,
    Control
);

input rst,
      clock,
      Control;

wire SYN, ACK, SYN_ACK;

client_side client_inst1 (
    .rst(rst),
    .clock(clock),
    .Control(Control),
    .RCV_SYN_ACK(SYN_ACK),
    .SEND_SYN(SYN),
    .SEND_ACK(ACK)
);

server_side server_inst1 (
    .rst(rst),
    .clock(clock),
    .RCV_SYN(SYN),
    .RCV_ACK(ACK),
    .SEND_SYN_ACK(SYN_ACK)
);

endmodule
