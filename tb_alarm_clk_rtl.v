module tb_alarm_clk_rtl();

reg clk, reset, alarm_button, time_button, fast_watch;

reg [3:0] key;

wire sound_a;
wire [7:0] display_ms_hr, display_ls_hr, display_ms_min, display_ls_min;

alarm_clk_rtl DUT(clk, reset, alarm_button, time_button, fast_watch, key, sound_a, display_ms_hr, display_ls_hr, display_ms_min, display_ls_min);

initial
begin
clk=1'b0;

forever #10 clk=clk;

end

task res();
begin
reset=1'b1;
#10;
reset=1'b0;
end
endtask

task in(input [3:0]l);
begin
key=l;
end
endtask

task s(input a,t);
begin
alarm_button=a;
time_button=t;
end
endtask

initial
begin
res;
fast_watch= 1'b1;

in(4'd1); // digit 1
repeat(2)
@(negedge clk);
in(4'b1010);
@(negedge clk);
in(4'd1); // digit 2
repeat(2)
@(negedge clk);
in(4'b1010);
@(negedge clk);
in(4'd1); //digit 3
repeat(2)
@(negedge clk);
in(4'b1010);
@(negedge clk);
in(4'd5);// digit 4
repeat(2)
@(negedge clk);
in(4'b1010);
@(negedge clk);
s(1'b0,1'b1);


@(negedge clk)
res;

fast_watch=1'b0;

repeat(2)
@(negedge clk);
in(4'd1); // digit 1
repeat(2)
@(negedge clk);
in(4'b1010);
@(negedge clk);
in(4'd1); // digit 2
repeat(2)
@(negedge clk);
in(4'b1010);
@(negedge clk);
in(4'd3); //digit 3
repeat(2)
@(negedge clk);
in(4'b1010);
@(negedge clk);
in(4'd0);// digit 4
repeat(2)
@(negedge clk);
in(4'b1010);
@(negedge clk);
in(4'b1010);
@(negedge clk);
s(1'b1, 1'b0);
@(negedge clk);
repeat(5)
wait(sound_a);
end

endmodule
