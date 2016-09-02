`timescale 1ns / 1ns // `timescale time_unit/time_precision

/* Datapath that changes the top-left coordinate of the paddle (depending on user input)
 * and sends the coordinate to the paddle_display */
module paddle_movement(
						reset_counts, 
						clock, 
						en_counters, 
						move_left, 
						move_right, 
						colour_in, 
						sel_c, 
						x, 
						y, 
						colour_out
						);
						
	input reset_counts; // resets the x, y, h counters
	input clock; 
	input sel_c; // selects a colour
   	input en_counters; // enables the change of x coordinate
   	input move_left, move_right; // the moves that the user wants to make
	input [2:0] colour_in; // colour of the paddle	
	output [2:0] colour_out; // colour to be used 

	output reg [7:0] x; 	
	output reg [6:0] y; 				
		
	// X counter

	always @ (posedge clock, negedge reset_counts)
	begin
		if (!reset_counts)
		begin
			x <= 8'd55;
			y <= 7'd112;      // the y coordinate doesn't change
		end
		else if (en_counters)
		begin 
			if (!move_right)
				x <= x + 1'b1;
			else if (!move_left) 
				x <= x - 1'b1;
		end
	end

	assign colour_out = sel_c ? colour_in : 3'd0;


endmodule

