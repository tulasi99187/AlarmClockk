`timescale 1ns / 1ps

module alarm_reg_tb;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in ns

    // Signals
    reg [3:0] new_alarm_ms_hr;
    reg [3:0] new_alarm_ls_hr;
    reg [3:0] new_alarm_ms_min;
    reg [3:0] new_alarm_ls_min;
    reg load_new_alarm;
    reg clock;
    reg reset;

    // Instantiate the unit under test (UUT)
    alarm_reg UUT (
        .new_alarm_ms_hr(new_alarm_ms_hr),
        .new_alarm_ls_hr(new_alarm_ls_hr),
        .new_alarm_ms_min(new_alarm_ms_min),
        .new_alarm_ls_min(new_alarm_ls_min),
        .load_new_alarm(load_new_alarm),
        .clock(clock),
        .reset(reset),
        .alarm_time_ms_hr(alarm_time_ms_hr),
        .alarm_time_ls_hr(alarm_time_ls_hr),
        .alarm_time_ms_min(alarm_time_ms_min),
        .alarm_time_ls_min(alarm_time_ls_min)
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
        #10;
        load_new_alarm = 1'b1;
        new_alarm_ms_hr = 4'b1010;
        new_alarm_ls_hr = 4'b1100;
        new_alarm_ms_min = 4'b0011;
        new_alarm_ls_min = 4'b0101;
        #20;
        load_new_alarm = 1'b0;

        // End simulation
        #100;
        $finish;
    end

endmodule
