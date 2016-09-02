`timescale 1ns / 1ns // `timescale time_unit/time_precision
        
/* Control for paddle_top, paddle_movement and paddle_display */
module paddle_control(
			reset_state, 
			clock,  
			counter_y, 
			counter_x, 
			x_in, 
			y_in, 
			move_left, 
			move_right, 
			enable_state, 
			done,
		 	plot, 
		 	ld_x, 
		 	ld_y, 
		 	reset_dividers, 
		 	reset_x, 
		 	sel_colour, 
		 	enable_change, 
		 	enable_delay, 
		 	counter_enable, 
		 	reset_registers
		 	);
   
	input reset_state;
	input clock;
	input enable_state;
	
	input [4:0] counter_y;  
	input [4:0] counter_x;  
	
	// Top-left coordinates of the paddle
	input [7:0] x_in;
	input [6:0] y_in;
	
	input move_left, move_right; 
	
	/* Controls for the top level module (counter) */
	output reg reset_dividers;
	output reg enable_delay;
	output reg counter_enable;
	output reg plot;
	output reg done;
	
	/* Controls for paddle_movement */
	output reg enable_change; // enables X movement depending on user input
	output reg reset_x; // resets the value of X to default
	
	// selects the colour to output, depending on whether we need to erase the paddle or draw it
	output reg sel_colour; 
	
	/*Controls for paddle_display */
	output reg ld_x;
	output reg ld_y;
	output reg reset_registers; // resets the registers
	
	
	
	localparam
		RESET = 4'd0,  
		LOAD_VALUES = 4'd1,
		LOAD_COUNTER = 4'd2,
		LOAD_DIVIDERS = 4'd3,
		COUNT = 4'd4,
		ERASE_1 = 4'd5,
		ERASE_2 = 4'd6,
		HOLD_1 = 4'd7,
		UPDATE = 4'd8,
		HOLD_2 = 4'd9,
		WAIT = 4'd10;
		
	reg [3:0] current_state, next_state;
	
	always @ (*)
	begin : state_table
		case (current_state)
			RESET: next_state = LOAD_VALUES;
			LOAD_VALUES: next_state = LOAD_COUNTER;
			LOAD_COUNTER: next_state = ((counter_y == 5'd2) & (counter_x == 5'd20)) ? LOAD_DIVIDERS : LOAD_COUNTER;
			LOAD_DIVIDERS: next_state = HOLD_1;
			HOLD_1: next_state = ERASE_1;
			ERASE_1: next_state = ERASE_2;
			ERASE_2: next_state = ((counter_y == 5'd2) & (counter_x == 5'd20)) ? HOLD_2 : ERASE_2;
			HOLD_2: next_state = WAIT; 
			WAIT: next_state = UPDATE;
			UPDATE: next_state = LOAD_VALUES;
		default: next_state  = RESET;
		endcase
	end 
	
	
	always @ (*)
	begin: enable_signals
		reset_dividers = 1;
		reset_registers = 1;
		reset_x = 1;    
		enable_change = 0;     
		sel_colour = 1;
		counter_enable = 0;
		enable_delay = 0;
		ld_x = 1;
		ld_y = 1;
		plot = 0;
		done = 0;
		case(current_state)
			RESET: begin
				reset_dividers = 0; // resets the dividers in the top level module
				reset_registers = 0; // resets registers in paddle_display
				reset_x = 0; // resets the counter in paddle_movement
			end
			LOAD_VALUES: begin
				ld_x = 1'b0; // load x
				ld_y = 1'b0; // load y
			end
			LOAD_COUNTER: begin
				counter_enable = 1;
				plot = 1;
			end
			LOAD_DIVIDERS: begin
				reset_dividers = 0;
			end
		    	HOLD_1: begin
				done = 1;
			end 
			ERASE_1: begin
				reset_dividers = 0;
				sel_colour = 0;
				ld_x = 0;
				ld_y = 0;
			end 
			ERASE_2: begin
				sel_colour = 0;
				counter_enable = 1;
				plot = 1;
			end 
			HOLD_2: begin
				done = 1;
			end
			WAIT: begin
			end  
			UPDATE: begin
				if (!(((x_in == 8'd0) & (!move_left)) | ((x_in == 8'd140) & (!move_right))))  
					enable_change = 1;
			end 
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
