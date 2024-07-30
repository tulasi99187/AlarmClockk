module alarm_clock_top_tb;

// Testbench signals
reg clock;
reg reset;
reg time_button;
reg alarm_button;
reg fastwatch;
reg [3:0] key;

wire [7:0] ms_hour;
wire [7:0] ls_hour;
wire [7:0] ms_minute;
wire [7:0] ls_minute;
wire alarm_sound;

// Instantiate the alarm_clock_top module
alarm_clock_top uut (
    .clock(clock),
    .reset(reset),
    .time_button(time_button),
    .alarm_button(alarm_button),
    .fastwatch(fastwatch),
    .key(key),
    .ms_hour(ms_hour),
    .ls_hour(ls_hour),
    .ms_minute(ms_minute),
    .ls_minute(ls_minute),
    .alarm_sound(alarm_sound)
);

// Clock generation
initial begin
    clock = 0;
    forever #5 clock = ~clock; // 10ns period
end

// Test sequence
initial begin
    // Initialize inputs
    reset = 1;
    time_button = 0;
    alarm_button = 0;
    fastwatch = 0;
    key = 4'b0000;
    
    // Wait for global reset to finish
    #20;
    
    // Release reset
    reset = 0;
    
    // Test setting time
    #10;
    time_button = 1;
    key = 4'b0010; // Set hours tens to 2
    #10;
    key = 4'b0011; // Set hours units to 3
    #10;
    key = 4'b0100; // Set minutes tens to 4
    #10;
    key = 4'b0101; // Set minutes units to 5
    #10;
    time_button = 0;
    
    // Test setting alarm
    #20;
    alarm_button = 1;
    key = 4'b0110; // Set alarm hours tens to 6
    #10;
    key = 4'b0111; // Set alarm hours units to 7
    #10;
    key = 4'b1000; // Set alarm minutes tens to 8
    #10;
    key = 4'b1001; // Set alarm minutes units to 9
    #10;
    alarm_button = 0;
    
    // Test fastwatch mode
    #20;
    fastwatch = 1;
    #100;
    fastwatch = 0;
    
    // Test alarm sound trigger
    #500;
    $stop;
end

endmodule
