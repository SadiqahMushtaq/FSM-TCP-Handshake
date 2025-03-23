`timescale 1ns / 1ps

module TCP_tb;

// Parameters
parameter PERIOD = 10; // Clock period in ns

// Signals
reg rst = 0;
reg clock = 0;
reg Control = 0;

// Instantiate the module under test
TCP dut (
    .rst(rst),
    .clock(clock),
    .Control(Control)
);

// Clock generation
always #((PERIOD/2)) clock = ~clock;

// Stimulus
initial begin
    // Reset sequence
    #20 rst = 1;
    #20 rst = 0;

    // Control sequence
    #10 Control = 1; // Example: Setting control signal to 1

    // Simulation end
    #100 $finish;
    end

endmodule
