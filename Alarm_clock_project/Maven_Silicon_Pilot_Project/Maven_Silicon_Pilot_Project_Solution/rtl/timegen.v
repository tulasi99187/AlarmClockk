module timegen(clock,
               reset,
               reset_count,
               fastwatch,
               one_second,
               one_minute);
               
// Define input and output port directions
  input clock,
        reset,
        reset_count, // resets the timegen whenever a new current time is set
        fastwatch;

  output reg one_second,
             one_minute;
         
 // Define internal registers required
   reg [13:0] count;
   reg one_minute_reg;

// one minute pulse generation
always @ (posedge clock or posedge reset)
begin
   // Upon reset, set the one minute reg value to zero
   if (reset)
   begin
      count <= 14'b0;
      one_minute_reg <= 0;
   end
   // Else check if there is a reset from alarm controller and reset the one minute_reg and count value
   else if (reset_count)
   begin
      count <= 14'b0;
      one_minute_reg <= 1'b0;
   end
   // Else check if the count value reaches 'd15359 (10011110001111 in binary) to generate 1 minute pulse
   else if (count == 14'd15359)
   begin
       count <= 14'b0;
       one_minute_reg <= 1'b1;
   end
   //else for every posedge of clock just increment the count
   else
   begin
       count <= count + 1'b1;
       one_minute_reg <= 1'b0;
   end
end

// one second pulse generation
always @ (posedge clock or posedge reset)
begin
// if reset is asserted, set one_second and counter_sec value to zero
    if (reset)
    begin
       one_second <= 1'b0;
    end
// else check if there is reset from alarm_controller and reset the one_second and counter_sec value
    else if (reset_count)
    begin
        one_second <= 1'b0;
    end
// else check if the count value reaches the 'd255 to generate and count 1 sec pulses
    else if  (count[7:0] == 8'd255)
    begin
        one_second <= 1'b1;
    end
// else set the one_second and counter_sec value to zero
    else
    begin
        one_second <= 1'b0;
    end
end

// fastwatch mode logic that makes the counting faster
always @ (*)
begin
// if fastwatch is asserted, make one_second equivalent to one_minute
    if (fastwatch)
        one_minute = one_second;
// else assert one_minute signal when one_minute_reg is asserted
    else
        one_minute = one_minute_reg;
end

endmodule
