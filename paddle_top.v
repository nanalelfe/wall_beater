`timescale 1ns / 1ns // `timescale time_unit/time_precision

/* Top level module for paddle */

module paddle_top(
					clock,
 					reset_state, 
 					enable_state, 
 					colour_in, 
 					move_left, 
 					move_right,  
 					colour_out,
					x, 
					y, 
					done, 
					plot, 
					paddle_x_top, 
					paddle_y_top
					);

	input clock, reset_state; 
	input [2:0] colour_in;     // colour of the paddle
	input enable_state;        // enables the paddle movement     
	input move_left; // moves the paddle to the left  (active low)
	input move_right; // moves the paddle to the right (active low)
	
	/* The top-left coordinate of the paddle */
	wire [7:0] x_in;
	wire [6:0] y_in;        
	             
	/* Final plotting coordinates to send to VGA */
	output [7:0] x;
	output [6:0] y;
	output [2:0] colour_out;
	       
	                      
	output done; // goes high when the FSM has completed a cycle
	output plot; // gives permission to plot to VGA
	output [7:0] paddle_x_top;
	output [6:0] paddle_y_top;
	assign paddle_x_top = x_in;
	assign paddle_y_top = y_in;
		              
		
	/* Controls for paddle_movement */
	wire ld_x; // loads x into the paddle_display
	wire ld_y; // loads y into paddle_display 
	wire reset_dividers;
	wire reset_x; 
	wire sel_colour;   
	wire enable_change; // enables change of x and y coordinates
		
	reg [4:0] counter_x; // x counts till 20
	reg [4:0] counter_y; // y counts till 3    
	
	wire en_counters;
	wire enable_delay, counter_enable;  
	wire reset_registers;     
	
	paddle_control c0(
			.reset_state(reset_state), 
			.clock(clock), 
			.counter_y(counter_y),   
			.counter_x(counter_x),
			.x_in(x_in), 
			.y_in(y_in),
			.move_left(move_left),
			.move_right(move_right), 
			.enable_state(enable_state), 
			.done(done),
		 	.plot(plot), 
		 	.ld_x(ld_x), 
		 	.ld_y(ld_y), 
		 	.reset_dividers(reset_dividers), 
		 	.reset_x(reset_x), 
		 	.sel_colour(sel_colour), 
		 	.enable_change(enable_change),
		 	.enable_delay(enable_delay), 
		 	.counter_enable(counter_enable), 
		 	.reset_registers(reset_registers)
		 	);
	                                            
	
	paddle_movement d0 (
			.reset_counts(reset_x), 
			.clock(clock), 
			.en_counters(enable_change), 
			.move_left(move_left), 
			.move_right(move_right), 
			.colour_in(colour_in), 
			.sel_c(sel_colour),  
			.x(x_in), 
			.y(y_in), 
			.colour_out(colour_out)
			);
	             
	
	paddle_display d1(
			.x_in(x_in), 
			.y_in(y_in), 
			.reset_n(reset_registers), 
			.ld_x(ld_x), 
			.ld_y(ld_y), 
			.counter_x(counter_x), 
			.counter_y(counter_y), 
			.clock(clock), 
			.x(x), 
			.y(y)
			);


	// COUNTER for paddle_display - generates x and y coordinates to draw the paddle
	always @ (posedge clock, negedge reset_dividers)
		begin
		if (!reset_dividers)
			begin
			counter_x <= 5'd0;
			counter_y <= 5'd0; 
			end
		else if (counter_enable)
			begin	
			if ((counter_y == 5'd2) & (counter_x == 5'd20))
				begin
				counter_x <= 5'd0;
				counter_y <= 5'd0;
				end 
			else if (counter_x == 5'd20)
			begin
				counter_x <= 5'd0;
				counter_y <= counter_y + 1'd1;
			end
			else 
				counter_x <= counter_x + 1'd1; 
			end
		end
		              
endmodule
