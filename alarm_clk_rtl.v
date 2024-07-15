module alarm_clk_rtl (clk, key, reset, time_button, alarm_button, fast_watch, ms_hr, ls_hr, ms_minute, ls_minute, alarm_sound);
input clk, reset, time_button, alarm_button, fast_watch;
input [3:0] key;
output [7:0] ms_hr, ls_hr, ms_minute, ls_minute;
output alarm_sound;

wire one_second, one_minute, load_new_c, load_new_a, show_current_time, show_a, shift, reset_count;

wire[3:0] key_buffer_ms_hr, key_buffer_ls_hr, key_buffer_ms_min, key_buffer_ls_min,
current_time_ms_hr,current_time_ls_hr, current_time_ms_min, current_time_ls_min,
alarm_time_ms_hr,alarm_time_ls_hr,alarm_time_ms_min, alarm_time_ls_min;

aclk_timegen t1 (.clk(clk), .reset(reset),.fast_watch(fast_watch), .one_second(one_second), .one_minute(one_minute), .reset_count(reset_count));

counter count(.clk(clk),.reset(reset),.one_minute(one_minute),.load_new_c(load_new_c),.new_current_time_ms_hr(key_buffer_ms_hr), .new_current_time_ms_min(key_buffer_ms_min),.new_current_time_ls_hr(key_buffer_ls_hr), .new_current_time_ls_min (key_buffer_ls_min), .current_time_ms_hr (current_time_ms_hr), 
.current_time_ms_min(current_time_ms_min), .current_time_ls_hr(current_time_ls_hr), .current_time_ls_min(current_time_ls_min));

alarmreg areg(.clk(clk), .reset(reset), .load_new_a(load_new_a), .new_alarm_ms_hr(key_buffer_ms_hr), .new_alarm_ms_min(key_buffer_ms_min), .new_alarm_ls_hr(key_buffer_ls_hr), 
.new_alarm_ls_min(key_buffer_ls_min),.alarm_time_ms_hr(alarm_time_ms_hr), .alarm_time_ms_min(alarm_time_ms_min), .alarm_time_ls_hr(alarm_time_ls_hr), .alarm_time_ls_min(alarm_time_ls_min));

key_reg keyreg( .clk(clk), .reset(reset), .key(key), .shift(shift), .key_buffer_ms_hr(key_buffer_ms_hr), .key_buffer_ms_min(key_buffer_ms_min), .key_buffer_ls_hr(key_buffer_ls_hr), 
.key_buffer_ls_min(key_buffer_ls_min));

aclk_controller acontrol(.clk(clk), .reset(reset), .one_second(one_second), .alarm_button(alarm_button), .time_button(time_button), .key(key), 
.reset_count(reset_count), .load_new_c(load_new_c), .show_new_time(show_current_time), .show_a(show_a) , .load_new_a(load_new_a) , .shift(shift));

aclk_lcd_display  lcddisplay( .current_time_ms_hr(current_time_ms_hr), .current_time_ms_min(current_time_ms_min), .current_time_ls_hr(current_time_ls_hr), 
.current_time_ls_min(current_time_ls_min), .alarm_time_ms_hr(alarm_time_ms_hr), .alarm_time_ms_min(alarm_time_ms_min), .alarm_time_ls_hr(alarm_time_ls_hr), 
.alarm_time_ls_min(alarm_time_ls_min), .key_ms_hr(key_buffer_ms_hr), .key_ms_min(key_buffer_ms_min), .key_ls_hr(key_buffer_ls_hr), .key_ls_min(key_buffer_ls_min), 
.show_new_time(show_current_time), .show_a(show_a), .sound_alarm(alarm_sound), .display_ms_hr(ms_hr), .display_ms_min(ms_minute), .display_ls_hr(ls_hr), .display_ls_min(ls_minute));
endmodule