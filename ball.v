`timescale 1ns / 1ns // `timescale time_unit/t

/* Top level module for the ball */
module ball(clock, reset_state, enable_state, colour_in, colour, x, y, 
			done, plot, paddle_collision, ball_x_top, ball_y_top,
			v_col_count, h_col_count, d_col_count, h_q, v_q);
	   
				
	input clock; 
	input reset_state; // resets the ball_control 
	input enable_state; // enables the ball_control
	
	input [2:0] colour_in; // colour of the ball
	

	
	input paddle_collision;
	input [1:0] v_col_count; 
	input [1:0] h_col_count; 
	input [1:0] d_col_count; 
	
	wire resetn;   
	
	// signals when one cycle of the ball_control is done to sprite_control
	output done; 
	
	// colour to be outputted, either black or colour_in  
	output [2:0] colour;   
	
	/* Coordinates plotting the ball's image */ 
	output [7:0] x;
	output [6:0] y; 
	
	/* Top-left coordinates of the ball */ 
	output [7:0] ball_x_top;
	output [6:0] ball_y_top; 
	assign ball_x_top = x_in;
	assign ball_y_top = y_in;  
	
	output plot; // plotting signal for the VGA adapter
	
	wire [7:0] x_in;
	wire [6:0] y_in; 
	
	wire en_counters; // enables ball coordinate change
	wire reset_dividers; // resets the counter
	wire h_t, v_t;  // horizontal and vertical toggling for ball direction
	wire sel_colour;
	wire ld_x, ld_y; // load x and y
	wire enable, enable_delay;  // enables the counter
		
	reg [3:0] counter;
	
	output h_q, v_q; // horizontal and vertical ball direction


	ball_control f0(.clock(clock),
		.reset_state(reset_state), 
		.counter(counter),
		.x(x_in), 
		.y(y_in),
		.en_counters(en_counters),
		.reset_dividers(reset_dividers), 
		.reset_n(resetn), 
		.h_t(h_t),
		.v_t(v_t),
		.sel_colour(sel_colour),
		.ld_x(ld_x), 
		.ld_y(ld_y), 
		.enable(enable), 
		.plot(plot),
		.done(done),
		.enable_state(enable_state),
		.paddle_collision(paddle_collision),
		.v_col_count(v_col_count),
		.h_col_count(h_col_count),
		.d_col_count(d_col_count)
		);

                                                    
	ball_movement d0(
		.reset_counts(resetn), 
		.en_counters(en_counters), 
		.clock(clock), 
		.colour_in(colour_in), 
		.sel_c(sel_colour), 
		.h_t(h_t), 
		.v_t(v_t),
		.h_q(h_q), 
		.v_q(v_q),  
		.x(x_in), 
		.y(y_in), 
		.colour_out(colour)
		); 
		

	ball_display d1(
		.x_in(x_in), 
		.y_in(y_in), 
		.reset_n(resetn), 
		.ld_x(ld_x), 
		.ld_y(ld_y), 
		.counter(counter), 
		.clock(clock), 
		.x(x), 
		.y(y)
		);
	

	// Counter that generates (x, y) coordinates to draw the ball
	always @(posedge clock, negedge reset_dividers)
		begin
		if (!reset_dividers)
			counter <= 4'd0;
		else if (enable)
			if (counter == 4'b1010)
				counter <= 4'd0;
			else if (counter[1:0] == 2'b10)
				counter <= counter + 2'd2;
			else
				counter <= counter + 1;
		end


endmodule

