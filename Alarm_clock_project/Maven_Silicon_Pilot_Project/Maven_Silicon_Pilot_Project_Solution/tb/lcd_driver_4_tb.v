module lcd_driver_4_tb;

// Testbench signals
reg [3:0] alarm_time_ms_hr;
reg [3:0] alarm_time_ls_hr;
reg [3:0] alarm_time_ms_min;
reg [3:0] alarm_time_ls_min;
reg [3:0] current_time_ms_hr;
reg [3:0] current_time_ls_hr;
reg [3:0] current_time_ms_min;
reg [3:0] current_time_ls_min;
reg [3:0] key_ms_hr;
reg [3:0] key_ls_hr;
reg [3:0] key_ms_min;
reg [3:0] key_ls_min;
reg show_a;
reg show_current_time;

wire [7:0] display_ms_hr;
wire [7:0] display_ls_hr;
wire [7:0] display_ms_min;
wire [7:0] display_ls_min;
wire sound_a;

// Instantiate the lcd_driver_4 module
lcd_driver_4 uut (
    .alarm_time_ms_hr(alarm_time_ms_hr),
    .alarm_time_ls_hr(alarm_time_ls_hr),
    .alarm_time_ms_min(alarm_time_ms_min),
    .alarm_time_ls_min(alarm_time_ls_min),
    .current_time_ms_hr(current_time_ms_hr),
    .current_time_ls_hr(current_time_ls_hr),
    .current_time_ms_min(current_time_ms_min),
    .current_time_ls_min(current_time_ls_min),
    .key_ms_hr(key_ms_hr),
    .key_ls_hr(key_ls_hr),
    .key_ms_min(key_ms_min),
    .key_ls_min(key_ls_min),
    .show_a(show_a),
    .show_current_time(show_current_time),
    .display_ms_hr(display_ms_hr),
    .display_ls_hr(display_ls_hr),
    .display_ms_min(display_ms_min),
    .display_ls_min(display_ls_min),
    .sound_a(sound_a)
);

// Clock generation
reg clock = 0;
always #5 clock = ~clock; // 10ns period

// Test sequence
initial begin
    // Initialize inputs
    alarm_time_ms_hr = 4'h0;
    alarm_time_ls_hr = 4'h0;
    alarm_time_ms_min = 4'h0;
    alarm_time_ls_min = 4'h0;
    current_time_ms_hr = 4'h0;
    current_time_ls_hr = 4'h0;
    current_time_ms_min = 4'h0;
    current_time_ls_min = 4'h0;
    key_ms_hr = 4'h0;
    key_ls_hr = 4'h0;
    key_ms_min = 4'h0;
    key_ls_min = 4'h0;
    show_a = 1'b0;
    show_current_time = 1'b0;
    
    // Set alarm time
    #10;
    alarm_time_ms_hr = 4'h1;
    alarm_time_ls_hr = 4'h2;
    alarm_time_ms_min = 4'h3;
    alarm_time_ls_min = 4'h4;
    
    // Set current time to match alarm time to trigger sound_a
    #10;
    current_time_ms_hr = 4'h1;
    current_time_ls_hr = 4'h2;
    current_time_ms_min = 4'h3;
    current_time_ls_min = 4'h4;
    
    // Enable alarm display
    #10;
    show_a = 1'b1;
    show_current_time = 1'b0;

    // Check sound_a
    #10;
    show_a = 1'b0;
    show_current_time = 1'b1;

    // Change current time
    #10;
    current_time_ms_hr = 4'h5;
    current_time_ls_hr = 4'h6;
    current_time_ms_min = 4'h7;
    current_time_ls_min = 4'h8;
    
    // End simulation
    #10;
    $finish;
end

endmodule
