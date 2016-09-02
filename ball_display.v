`timescale 1ns / 1ns // `timescale time_unit/time_precision

/* Datapath that sends coordinates to the VGA adapter to plot the ball */
module ball_display(x_in, y_in, reset_n, ld_x, ld_y, counter, clock, x, y);
	  
	/* Top-left coordinate of the ball  */
	input [7:0] x_in;
	input [6:0] y_in; 
	
	input reset_n; // resets the values in the registers and the counter to 0
	input ld_x; // active low, load x_in into the X register
	input ld_y; // active low, load y_in into the Y register
	input clock;
	input [3:0] counter;  // the counter in the ball module

	reg [7:0] RX_out;  // register for X
	reg [6:0] RY_out;  // register for Y
    
	/* VGA ball plotting coordinates for the ball */
	output [7:0] x;
	output [6:0] y;

	// X AND Y REGISTER LOAD
	always @ (posedge clock, negedge reset_n)
		begin
		if (!reset_n)
			begin
			RX_out <= 8'd0;
			RY_out <= 7'd0;
			end
		else
			begin
			if (!ld_x)
				RX_out <= x_in;
			if (!ld_y)
				RY_out <= y_in;
			end		
		end
	
	assign x = RX_out + counter[3:2];
	assign y = RY_out + counter[1:0];


endmodule 