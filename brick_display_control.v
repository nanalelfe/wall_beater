`timescale 1ns / 1ns // `timescale time_unit/time_precision   

/* Controls the brick_display module to draw the brick */ 
module brick_display_control(
					clock, 
					plot,  
					brick_counter_x, 
					brick_counter_y, 
					enable_state,
					reset_state, 
					brick_reset_counters, 
					brick_enable_counters, 
					read, 
					reset_regs, 
					load_regs, 
					done
					);
					
	input clock;       
	output reg plot; 
	
	/* Counters that generate the coodinates to plot the brick */ 
	input [3:0] brick_counter_x; 
	input [1:0] brick_counter_y; 

	input enable_state;
	input reset_state;
	
	output reg brick_reset_counters, brick_enable_counters;
 	output reg read;
 	output reg reset_regs;
 	output reg load_regs;
 	output reg done;
 	 
	localparam 
		RESET = 4'd0,
		LOAD = 4'd1,
		ENABLE_COUNTER = 4'd2,
		DONE = 4'd3;
		
	reg [3:0] current_state, next_state;
	
	always @ (*)
	begin : state_table
		case (current_state)
			RESET: next_state = LOAD;
			LOAD: next_state = ENABLE_COUNTER;
			ENABLE_COUNTER: next_state = ((brick_counter_x == 4'd15) & (brick_counter_y == 2'd3)) ? DONE : ENABLE_COUNTER;
			DONE: next_state = RESET;
		default: current_state = RESET;
		endcase
	end 
	
	always  @ (*)
	begin: enable_signals
		read = 0;
		reset_regs = 1;
		load_regs = 0;
		done = 0;
		brick_reset_counters = 1;
		brick_enable_counters = 0;
		plot = 0;
		case(current_state)
			RESET: begin
				reset_regs = 0;
				brick_reset_counters = 0;
			end
			LOAD: begin
				read = 1;
				load_regs = 1;
			end 
			ENABLE_COUNTER: begin
				brick_enable_counters = 1;
				plot = 1;
		     end
			DONE:
				done = 1;
		endcase 
	end 
	
   always @ (posedge clock, negedge reset_state)
	begin: state_FFs
		if (!reset_state)
			current_state <= RESET;
		else if (enable_state)
			current_state <= next_state;
	end 		
		
endmodule

