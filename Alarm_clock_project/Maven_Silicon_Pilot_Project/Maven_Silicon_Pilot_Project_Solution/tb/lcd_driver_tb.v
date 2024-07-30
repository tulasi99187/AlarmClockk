`timescale 1ns / 1ps

module lcd_driver_tb;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in ns

    // Signals
    reg [3:0] key;
    reg [3:0] alarm_time;
    reg [3:0] current_time;
    reg show_alarm;
    reg show_new_time;
    
    wire [7:0] display_time;
    wire sound_alarm;

    // Instantiate the unit under test (UUT)
    lcd_driver UUT (
        .key(key),
        .alarm_time(alarm_time),
        .current_time(current_time),
        .show_alarm(show_alarm),
        .show_new_time(show_new_time),
        .display_time(display_time),
        .sound_alarm(sound_alarm)
    );

    // Clock generation
    reg clock = 0;
    always #((CLK_PERIOD)/2) clock = ~clock;

    // Initial stimulus
    initial begin
        // Reset inputs
        key = 4'b0000;
        alarm_time = 4'b0000;
        current_time = 4'b0000;
        show_alarm = 1'b0;
        show_new_time = 1'b0;

        // Apply some test stimuli
        #10;
        key = 4'b1010; // Example value
        show_new_time = 1'b1;
        #20;
        show_new_time = 1'b0;
        current_time = 4'b1100; // Example value
        show_alarm = 1'b1;
        #30;
        show_alarm = 1'b0;
        // Add more test cases as needed

        // End simulation
        #100;
        $finish;
    end

endmodule
