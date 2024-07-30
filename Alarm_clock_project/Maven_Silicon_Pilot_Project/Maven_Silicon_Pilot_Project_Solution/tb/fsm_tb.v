`timescale 1ns / 1ps

module fsm_tb;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in ns

    // Signals
    reg clock = 0;
    reg reset = 0;
    reg one_second = 0;
    reg time_button = 0;
    reg alarm_button = 0;
    reg [3:0] key = 4'b0000;

    wire load_new_a;
    wire show_a;
    wire show_new_time;
    wire load_new_c;
    wire shift;
    wire reset_count;

    // Instantiate the unit under test (UUT)
    fsm UUT (
        .clock(clock),
        .reset(reset),
        .one_second(one_second),
        .time_button(time_button),
        .alarm_button(alarm_button),
        .key(key),
        .reset_count(reset_count),
        .load_new_a(load_new_a),
        .show_a(show_a),
        .show_new_time(show_new_time),
        .load_new_c(load_new_c),
        .shift(shift)
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
        // Scenario 1: Key press and release
        #10;
        key = 4'b1010;
        #20;
        key = 4'b0000;

        // Scenario 2: Alarm button press
        #10;
        alarm_button = 1'b1;
        #20;
        alarm_button = 1'b0;

        // Scenario 3: Time button press
        #10;
        time_button = 1'b1;
        #20;
        time_button = 1'b0;

        // Scenario 4: One second pulse
        #10;
        one_second = 1'b1;
        #20;
        one_second = 1'b0;

        // Simulate 200 clock cycles
        #200;

        // End simulation
        #50;
        $finish;
    end

endmodule
