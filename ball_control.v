`timescale 1ns / 1ns // `timescale time_unit/time_precision
 
/* Control for ball_movement, ball_display and the top ball module */
module ball_control(reset_state,
					clock,
					counter, 
					x, 
					y, 
					en_counters,
			 		reset_dividers, 
			 		reset_n, 
			 		h_t, 
			 		v_t, 
			 		sel_colour, 
			 		ld_x, 
			 		ld_y, 
			 		enable,
			 		plot, 
			 		done, 
			 		enable_state, 
			 		paddle_collision, 
			 		v_col_count, 
			 		h_col_count, 
			 		d_col_count
			 		);
			 
	input clock;
	input [3:0] counter;
	
	input enable_state;
	
	/* Top-left coordinate of the ball */ 
	input [7:0] x;
	input [6:0] y;  
	
	input reset_state; 
	
	/* Signal the notifies when a paddle collision has been detected */
	input paddle_collision; 
	
	/* Count the number of vertical, horizontal and diagonal collisions */
	input [1:0] v_col_count; 
	input [1:0] h_col_count; 
	input [1:0] d_col_count; 
	            
	

   	/* Controls for the ball top module */
	output reg reset_dividers; // resets the counter 
	output reg enable; // enables the counter in ball
	output reg plot; // plotting signal for the VGA adapter
	
	/* Controls for ball module - ball_movement */ 		
	output reg en_counters; //enables the X and Y counters
	output reg reset_n; // resets the X, Y counters and h and v registers
	output reg h_t; // direction register for X counter
	output reg v_t; // direction register for Y counter
	output reg sel_colour;


	/* Controls for ball module - ball_display */ 
	output reg ld_x; // loads x into the datapath
	output reg ld_y; // loads y into the datapath
                                                   


	/* Controls for the wall_beater_top module */
	
	// when done is high, enable_state is turned off until the vga_adapter	
	// gets to draw the remaining sprites, given that they have been changed
	
	output reg done; // high when the fsm completes a cycle (at UPDATE)

	localparam
		RESET = 4'd0,
		LOAD_COORD = 4'd1,
		ENABLE_CHANGE = 4'd2,
		RESET_COUNTER = 4'd3,
		HOLD_1 = 4'd4,
		ERASE_1 = 4'd5,
		ERASE_2 = 4'd6,
		HOLD_2 = 4'd7,
		SKIP = 4'd8,
		CHECK_BRICK_COLLISION = 4'd9,
		UPDATE = 4'd10;
		
		

	reg [3:0] current_state, next_state;

	always @ (*)
	begin : state_table
		case (current_state)
			RESET: next_state = LOAD_COORD;
			LOAD_COORD: next_state = ENABLE_CHANGE; 
			ENABLE_CHANGE: next_state = (counter == 4'd10) ? RESET_COUNTER : ENABLE_CHANGE;
			RESET_COUNTER: next_state = HOLD_1;
			HOLD_1: next_state = ERASE_1;
			ERASE_1: next_state = ERASE_2;
			ERASE_2: next_state = (counter == 4'd10) ? HOLD_2 : ERASE_2;
			HOLD_2: next_state = SKIP; 
			SKIP: next_state = CHECK_BRICK_COLLISION;
			CHECK_BRICK_COLLISION: next_state = UPDATE;
			UPDATE: next_state = LOAD_COORD; // updates the values of x and y
			
		default: next_state = RESET;
		endcase
	end

	 

	always @ (*)
	begin: enable_signals
		reset_dividers = 1;
		reset_n = 1;
		h_t = 0;
		v_t = 0;
		en_counters = 0;
		sel_colour = 1;
		enable = 1'b0; 
		ld_x = 1'b1; 
		ld_y = 1'b1; 
		plot = 1'b0; 
		done = 1'b0;
		case (current_state)
			RESET: begin	
				reset_dividers = 0;
				reset_n = 0; // resets the datapath
			end
			LOAD_COORD: begin                             
				ld_x = 1'b0; // load x
				ld_y = 1'b0; // load y
				if ((x == 8'd0) | (x == 8'd157))
					h_t = 1'd1;
			 	if ((y == 7'd0) | (y == 7'd117) | (paddle_collision))
					v_t = 1'd1;
			end
			ENABLE_CHANGE: begin
				enable = 1'b1;
				plot = 1'b1;
			end
			RESET_COUNTER: begin
				reset_dividers = 0;
			end
			HOLD_1: begin
				done = 1;
			end 
			ERASE_1: begin
				reset_dividers = 0; // resets the datapath
				sel_colour = 1'd0;
				ld_x = 1'b0; // load x
				ld_y = 1'b0; // load y
			end
			ERASE_2: begin
				sel_colour = 1'd0;
				enable = 1'b1;
				plot = 1'b1;
			end
			HOLD_2: begin
				done = 1;
			end
			SKIP: begin
			end
			CHECK_BRICK_COLLISION: begin
				if ((d_col_count == 1'd1) && (v_col_count == 1'd1))
					v_t = 1'd1;
				else if ((d_col_count == 1'd1) && (h_col_count == 1'd1))
					h_t = 1'd1;
				else if (d_col_count == 1'd1)begin
					h_t = 1'd1; 
					v_t = 1'd1; 
				end
				else if ((h_col_count == 1) && (v_col_count == 1)) begin
					h_t = 1'd1; 
					v_t = 1'd1;
				end
				else if (h_col_count >= 2'd1) begin
					h_t = 1'd1;
				end
				else if ((v_col_count >= 2'd1) ) begin
					v_t = 1'd1;
				end
			end 
			UPDATE: begin
				en_counters = 1;
			end 
			
		default: next_state = RESET;
		endcase
	end
				
	// Current state registers
	always @ (posedge clock, negedge reset_state)
	begin: state_FFs
		if (!reset_state)
			current_state <= RESET;
		else if (enable_state)
			current_state <= next_state;
	end
				


endmodule


