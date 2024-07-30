module lcd_driver_4 (
    alarm_time_ms_hr,
    alarm_time_ls_hr,
    alarm_time_ms_min,
    alarm_time_ls_min,
    current_time_ms_hr,
    current_time_ls_hr,
    current_time_ms_min,
    current_time_ls_min,
    key_ms_hr,
    key_ls_hr,
    key_ms_min,
    key_ls_min,
    show_a,
    show_current_time,
    display_ms_hr,
    display_ls_hr,
    display_ms_min,
    display_ls_min,
    sound_a
);

// Define input ports
input [3:0] alarm_time_ms_hr;
input [3:0] alarm_time_ls_hr;
input [3:0] alarm_time_ms_min;
input [3:0] alarm_time_ls_min;
input [3:0] current_time_ms_hr;
input [3:0] current_time_ls_hr;
input [3:0] current_time_ms_min;
input [3:0] current_time_ls_min;
input [3:0] key_ms_hr;
input [3:0] key_ls_hr;
input [3:0] key_ms_min;
input [3:0] key_ls_min;
input show_a;
input show_current_time;

// Define output ports
output [7:0] display_ms_hr;
output [7:0] display_ls_hr;
output [7:0] display_ms_min;
output [7:0] display_ls_min;
output sound_a;

// Define internal signals
wire sound_alarmi, sound_alarm2, sound_alarm3, sound_alarm4;

// Assert sound_a when all 4 digits match
assign sound_a = sound_alarmi & sound_alarm2 & sound_alarm3 & sound_alarm4;

// Instantiate lcd_driver for MS_HR_display
lcd_driver MS_HR (
    .alarm_time(alarm_time_ms_hr),
    .current_time(current_time_ms_hr),
    .key(key_ms_hr),
    .show_alarm(show_a),
    .show_new_time(show_current_time),
    .display_time(display_ms_hr),
    .sound_alarm(sound_alarmi)
);

// Instantiate lcd_driver for LS_HR_display
lcd_driver LS_HR (
    .alarm_time(alarm_time_ls_hr),
    .current_time(current_time_ls_hr),
    .key(key_ls_hr),
    .show_alarm(show_a),
    .show_new_time(show_current_time),
    .display_time(display_ls_hr),
    .sound_alarm(sound_alarm2)
);

// Instantiate lcd_driver for MS_MIN_display
lcd_driver MS_MIN (
    .alarm_time(alarm_time_ms_min),
    .current_time(current_time_ms_min),
    .key(key_ms_min),
    .show_alarm(show_a),
    .show_new_time(show_current_time),
    .display_time(display_ms_min),
    .sound_alarm(sound_alarm3)
);

// Instantiate lcd_driver for LS_MIN_display
lcd_driver LS_MIN (
    .alarm_time(alarm_time_ls_min),
    .current_time(current_time_ls_min),
    .key(key_ls_min),
    .show_alarm(show_a),
    .show_new_time(show_current_time),
    .display_time(display_ls_min),
    .sound_alarm(sound_alarm4)
);

endmodule
