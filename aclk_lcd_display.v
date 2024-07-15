module aclk_lcd_display( current_time_ms_hr, current_time_ms_min, current_time_ls_hr, current_time_ls_min, alarm_time_ms_hr, alarm_time_ms_min, alarm_time_ls_hr, alarm_time_ls_min, key_ms_hr, key_ms_min, key_ls_hr, key_ls_min, show_new_time, show_a, sound_alarm, display_ms_hr, display_ms_min, display_ls_hr, display_ls_min);
input [3:0] current_time_ms_hr, current_time_ms_min, current_time_ls_hr, current_time_ls_min, alarm_time_ms_hr, alarm_time_ms_min, alarm_time_ls_hr, alarm_time_ls_min, key_ms_hr, key_ms_min, key_ls_hr, key_ls_min;
input show_new_time, show_a;
output sound_alarm;
output [7:0] display_ms_hr, display_ms_min, display_ls_hr, display_ls_min;
wire sound_alarm1, sound_alarm2, sound_alarm3, sound_alarm4;

assign sound_a= sound_alarm1 & sound_alarm2 & sound_alarm3 & sound_alarm4;
aclk_lcd_driver MS_HR (.alarm_time(alarm_time_ms_hr), .current_time(current_time_ms_hr),
 .key( key_ms_hr), .show_a(show_a), .show_new_time(show_current_time), .display_time(display_ms_hr), .sound_alarm(sound_alarm1));

aclk_lcd_driver LS_HR (.alarm_time(alarm_time_ls_hr), .current_time(current_time_ls_hr),
 .key( key_ls_hr), .show_a(show_a), .show_new_time(show_current_time), .display_time(display_ls_hr), .sound_alarm(sound_alarm2));

aclk_lcd_driver MS_MIN (.alarm_time(alarm_time_ms_MIN), .current_time(current_time_ms_min),
 .key( key_ms_min), .show_a(show_a), .show_new_time(show_current_time), .display_time(display_ms_min), .sound_alarm(sound_alarm3));

aclk_lcd_driver LS_MIN (.alarm_time(alarm_time_ls_min), .current_time(current_time_ls_min),
 .key( key_ls_min), .show_a(show_a), .show_new_time(show_current_time), .display_time(display_ls_min), .sound_alarm(sound_alarm4));
 endmodule
