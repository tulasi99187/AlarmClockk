`timescale 1ns / 1ps

module keyreg_tb;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in ns

    // Signals
    reg reset = 0;
    reg clock = 0;
    reg shift = 0;
    reg [3:0] key = 4'b0000;

    // Outputs
    wire [3:0] key_buffer_ls_min;
    wire [3:0] key_buffer_ms_min;
    wire [3:0] key_buffer_ls_hr;
    wire [3:0] key_buffer_ms_hr;

    // Instantiate the unit under test (UUT)
    keyreg UUT (
        .reset(reset),
        .clock(clock),
        .shift(shift),
        .key(key),
        .key_buffer_ls_min(key_buffer_ls_min),
        .key_buffer_ms_min(key_buffer_ms_min),
        .key_buffer_ls_hr(key_buffer_ls_hr),
        .key_buffer_ms_hr(key_buffer_ms_hr)
    );

    // Clock generation
    always #((CLK_PERIOD)/2) clock = ~clock;

    // Initial stimulus
    initial begin
        // Reset inputs
        reset = 1'b1;
        #50;
        reset = 1'b0;

        // Apply some test stimuli
        // Scenario 1: Press keys and observe key buffers
        #10;
        key = 4'b1010; // Example key value
        shift = 1'b1;
        #20;
        shift = 1'b0;

        // Scenario 2: Press keys and observe key buffers
        #10;
        key = 4'b0110; // Another example key value
        shift = 1'b1;
        #20;
        shift = 1'b0;

        // Simulate 200 clock cycles
        #200;

        // End simulation
        #50;
        $finish;
    end

endmodule
