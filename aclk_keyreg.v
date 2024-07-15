module key_reg(clk, reset, key, shift, key_buffer_ms_hr, key_buffer_ms_min, key_buffer_ls_hr, key_buffer_ls_min);
input clk, reset, shift;
input [3:0] key;
output reg [3:0] key_buffer_ms_hr;
output reg [3:0] key_buffer_ms_min;
output reg [3:0] key_buffer_ls_hr;
output reg [3:0] key_buffer_ls_min;
always @ (posedge clk or posedge reset)
begin
if (reset)
begin
key_buffer_ms_hr<=0;
key_buffer_ms_min<=0;
key_buffer_ls_hr<=0;
key_buffer_ls_min<=0;
end
else if (shift)
begin
key_buffer_ms_hr<=key_buffer_ls_hr;
key_buffer_ms_min<=key_buffer_ls_min;
key_buffer_ls_hr<=key_buffer_ms_min;
key_buffer_ls_min<=key;
end
end
endmodule