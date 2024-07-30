`timescale 1ns / 1ps

module timegen_tb;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in ns

    // Signals
    reg clock = 0;
    reg reset = 0;
    reg reset_count = 0;
    reg fastwatch = 0;
    reg [15:0] fastwatch_counter = 0; // Counter for simulating fastwatch mode

    // Outputs
    wire one_second;
    wire one_minute;

    // Instantiate the unit under test (UUT)
    timegen UUT (
        .clock(clock),
        .reset(reset),
        .reset_count(reset_count),
        .fastwatch(fastwatch),
        .one_second(one_second),
        .one_minute(one_minute)
    );

    // Clock generation
    always #((CLK_PERIOD)/2) clock = ~clock;

    // Initial stimulus
    initial begin
        // Reset inputs
        reset = 1'b1;
        #50;
        reset = 1'b0;

        // Scenario 1: Simulate normal operation
        #100;
        // Let the simulation run for some time

        // Scenario 2: Test reset_count functionality
        #50;
        reset_count = 1'b1;
        #10;
        reset_count = 1'b0;
        // Let the simulation run for some time

        // Scenario 3: Test fastwatch mode
        #50;
        fastwatch = 1'b1;
        // Simulate fastwatch mode by toggling one_second frequently
        repeat (100) begin
            #10;
            fastwatch_counter = fastwatch_counter + 1;
        end
        fastwatch = 1'b0;

        // End simulation
        #50;
        $finish;
    end

endmodule
