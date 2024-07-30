`timescale 1ns / 1ps

module counter_tb;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in ns

    // Signals
    reg clk = 0;
    reg reset = 0;
    reg one_minute = 0;
    reg load_new_c = 0;
    
    reg [3:0] new_current_time_ms_hr = 4'b0000;
    reg [3:0] new_current_time_ms_min = 4'b0000;
    reg [3:0] new_current_time_ls_hr = 4'b0000;
    reg [3:0] new_current_time_ls_min = 4'b0000;

    wire [3:0] current_time_ms_hr;
    wire [3:0] current_time_ms_min;
    wire [3:0] current_time_ls_hr;
    wire [3:0] current_time_ls_min;

    // Instantiate the unit under test (UUT)
    counter UUT (
        .clk(clk),
        .reset(reset),
        .one_minute(one_minute),
        .load_new_c(load_new_c),
        .new_current_time_ms_hr(new_current_time_ms_hr),
        .new_current_time_ms_min(new_current_time_ms_min),
        .new_current_time_ls_hr(new_current_time_ls_hr),
        .new_current_time_ls_min(new_current_time_ls_min),
        .current_time_ms_hr(current_time_ms_hr),
        .current_time_ms_min(current_time_ms_min),
        .current_time_ls_hr(current_time_ls_hr),
        .current_time_ls_min(current_time_ls_min)
    );

    // Clock generation
    always #((CLK_PERIOD)/2) clk = ~clk;

    // Initial stimulus
    initial begin
        // Reset inputs
        reset = 1'b1;
        #50;
        reset = 1'b0;

        // Apply some test stimuli
        // Load new current time values
        #10;
        load_new_c = 1'b1;
        new_current_time_ms_hr = 4'b0010;
        new_current_time_ms_min = 4'b0101;
        new_current_time_ls_hr = 4'b0001;
        new_current_time_ls_min = 4'b1111;
        #20;
        load_new_c = 1'b0;

        // Simulate 200 clock cycles
        #200;

        // Trigger one_minute signal to simulate counting
        #10;
        one_minute = 1'b1;
        #20;
        one_minute = 1'b0;

        // End simulation
        #50;
        $finish;
    end

endmodule
