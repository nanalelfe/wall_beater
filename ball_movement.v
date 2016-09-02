`timescale 1ns / 1ns // `timescale time_unit/time_precision
       
/* Datapath that changes the top-left coordinate of the ball
 * and sends the coordinate to the ball_display */
module ball_movement(
					reset_counts, 
					en_counters, 
					clock, 
					colour_in, 
					sel_c, 
					h_t, 
					v_t, 
					h_q, 
					v_q, 
					x, 
					y, 
					colour_out
					); 

	input reset_counts; // resets the x, y, h and v counters
	input clock; 
	input sel_c; // selects a colour
	input h_t; // horizontal toggle
	input v_t; // vertical toggle
	input [2:0] colour_in; // colour of the ball
	input en_counters; // enables the X and Y counters
	
	output [2:0] colour_out; // colour to be used
     
	/* Top-left coordinate of the ball  */
	output reg [7:0] x; 	
	output reg [6:0] y; 
	
	// h and v directions
	output reg h_q, v_q;

	// h and v t-flip flips
	always @ (posedge clock, negedge reset_counts)
	begin
		if (!reset_counts)
		begin	
			h_q <= 1'b0;
			v_q <= 1'b0;
		end

		else 
		begin
			if(h_t == 1'b1)
				h_q <= ~h_q;
			if (v_t == 1'b1)
				v_q <= ~v_q;
		end
	end
				
		
	// X and Y counters
	always @ (posedge clock, negedge reset_counts)
	begin
		if (!reset_counts)
		begin
			x <= 8'd0;
			y <= 7'd34;
		end
		else if (en_counters)
		begin 
			if (h_q)
				x <= x + 1'b1;
			else if (!h_q) 
				x <= x - 1'b1;
			if (v_q)
				y <= y + 1'b1;
			else if (!v_q)
				y <= y - 1'b1;
		end
	end

	assign colour_out = sel_c ? colour_in : 3'd0;


endmodule


