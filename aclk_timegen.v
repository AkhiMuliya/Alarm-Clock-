module aclk_timegen(clk,reset, reset_count, fast_watch,one_minute, one_second);
input clk, reset, reset_count, fast_watch;
output reg one_minute, one_second;
reg[13:0] count;
reg one_minute_reg;
always @(posedge clk or posedge reset)
begin
if(reset)
begin
count<=14'b0;
one_minute_reg<=0;
end
else if (reset_count)
begin
count<=14'b0;
one_minute_reg<=0;
end
else if(count[13:0]==14'd15359)
begin
count<=14'b0;
one_minute_reg<=0;
end
else 
begin
count<=count+1;
one_minute_reg<=0;
end
end

always @(posedge clk or posedge reset)
begin
if(reset)
begin
one_second<=1'b0;
end
else if (reset_count)
begin
one_second<=1'b0;
end
else if (count[7:0]==8'd255)
begin
one_second<=1'b1;
end
else
begin
one_second<=1'b0;
end
end

always @(*)
begin
if (fast_watch)
one_minute=one_second;
else
one_minute=one_minute_reg;
end

endmodule


