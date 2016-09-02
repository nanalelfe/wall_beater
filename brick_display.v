`timescale 1ns / 1ns // `timescale time_unit/time_precision

/* Generates x y coordinates to be sent to VGA adapter in order to draw the brick */
module brick_display(
					clock, 
					brick_out, 
					read, 
					reset_regs, 
					load_regs, 
					brick_counter_x, 
					brick_counter_y, 
					x_out, 
					y_out, 
					colour_out
					); 
					
	input clock;
	input [18:0] brick_out; // [x][y][colour]
	input read; // done - can read 
	input reset_regs;
	input load_regs;
	   
	reg [7:0] x;
	reg [6:0] y;
	reg [2:0] colour_in;
	
	output [7:0] x_out;
	output [6:0] y_out;
	output [2:0] colour_out;
	                           
	input [3:0] brick_counter_x;
	input [1:0] brick_counter_y;
	
	// Registers 
	always @ (posedge clock, negedge reset_regs)
	begin
		if (!reset_regs)
		begin
			x <= 8'd0;
			y <= 7'd0; 
			colour_in <= 3'd0;
		end
		else if (read & load_regs)
		begin
			x <= brick_out[18:11];
			y <= brick_out[9:3]; 
			colour_in <= brick_out[2:0];
		end 
	end 	   
	
	// We add pixels from counter to get brick pixels
	assign x_out = brick_counter_x + x;		
	assign y_out = brick_counter_y + y;
	assign colour_out = colour_in;	  	
	
	
endmodule 