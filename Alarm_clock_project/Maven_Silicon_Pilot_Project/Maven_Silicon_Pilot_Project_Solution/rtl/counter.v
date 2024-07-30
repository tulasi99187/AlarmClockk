module counter (
    input clk,
    input reset,
    input one_minute,
    input load_new_c,
    input [3:0] new_current_time_ms_hr,
    input [3:0] new_current_time_ms_min,
    input [3:0] new_current_time_ls_hr,
    input [3:0] new_current_time_ls_min,
    output reg [3:0] current_time_ms_hr,
    output reg [3:0] current_time_ms_min,
    output reg [3:0] current_time_ls_hr,
    output reg [3:0] current_time_ls_min
);

// Loadable binary up synchronous counter logic

// Always block with asynchronous reset
always @ (posedge clk or posedge reset) begin
    // Check for reset signal and upon reset, set the current_time register to default values
    if (reset) begin
        current_time_ms_hr <= 4'd0;
        current_time_ms_min <= 4'd0;
        current_time_ls_hr <= 4'd0;
        current_time_ls_min <= 4'd0;
    end
    // Else if there is no reset, then check for load_new_c signal and load new_current_time to current_time register
    else if (load_new_c) begin
        current_time_ms_hr <= new_current_time_ms_hr;
        current_time_ms_min <= new_current_time_ms_min;
        current_time_ls_hr <= new_current_time_ls_hr;
        current_time_ls_min <= new_current_time_ls_min;         
    end   
    // Else if there is no load_new_c signal, then check for one_minute signal and implement the counting algorithms
    else if (one_minute == 1) begin
        // Check for the counter case
        // If the current_time is 23:59 then the next current time will be 00:00
        if (current_time_ms_hr == 4'd2 && current_time_ls_hr == 4'd3 &&
            current_time_ms_min == 4'd5 && current_time_ls_min == 4'd9) begin
            current_time_ms_hr <= 4'd0;
            current_time_ls_hr <= 4'd0;
            current_time_ms_min <= 4'd0;
            current_time_ls_min <= 4'd0;
        end
        // Else check if the current time is 09:59 then the next current time will be 10:00
        else if (current_time_ls_hr == 4'd9 && current_time_ms_min == 4'd5 && current_time_ls_min == 4'd9) begin
            current_time_ms_hr <= current_time_ms_hr + 4'd1;
            current_time_ls_hr <= 4'd0;
            current_time_ms_min <= 4'd0;
            current_time_ls_min <= 4'd0;      
        end
        // Else check if the time represented by minutes is 59, increment the ls_hr by 1 and set ms_min and ls_min to 1'b0
        else if (current_time_ms_min == 4'd5 && current_time_ls_min == 4'd9) begin 
            current_time_ls_hr <= current_time_ls_hr + 4'd1;
            current_time_ms_min <= 4'd0;
            current_time_ls_min <= 4'd0;   
        end
        // Else check if the ls_min is equal to 9, increment the ms_min by 1 and set ls_min to 1'b0
        else if (current_time_ls_min == 4'd9) begin 
            current_time_ms_min <= current_time_ms_min + 4'd1;
            current_time_ls_min <= 4'd0;   
        end            
        // Else just increment the ls_min by 1
        else begin
            current_time_ls_min <= current_time_ls_min + 4'd1;
        end
    end
end

endmodule











        
              



