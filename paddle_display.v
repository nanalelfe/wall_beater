`timescale 1ns / 1ns // `timescale time_unit/time_precision

/* Datapath that sends coordinates to the VGA adapter to plot the paddle */
module paddle_display(x_in, y_in, reset_n, ld_x, ld_y, counter_x, counter_y, clock, x, y);
	  
	/* Top-left coordinates of the ball */	
	input [7:0] x_in;
	input [6:0] y_in;
	input reset_n; // resets the values in the registers
	input ld_x; // active low, load data_in into the X register
	input ld_y; // active low, load data_in into the Y register
	input clock;
	input [4:0] counter_x; // add to x
	input [4:0] counter_y; // add to y

	reg [7:0] RX_out;
	reg [6:0] RY_out;

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
	
	// ADDERS for X and Y
		
	assign x = RX_out + counter_x;
	assign y = RY_out + counter_y;


endmodule 