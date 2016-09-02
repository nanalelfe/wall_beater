`timescale 1ns / 1ns

module brick_storage_dp(clock, resetn, address_in, check_status, 
								delete_brick, brick_out, loading, 
								perform_delete, ld_status, brick_count, send_address_in);
								
	
	// Control signals from collider/vga display
	// resetn, address, check_status, delete_brick 
	input clock, resetn;
	input check_status;			// signal from higher module to read/write
	input [5:0] address_in; 	// 0-59 bricks 
	input delete_brick; 
	input loading;
	input ld_status;
	input perform_delete;
	input send_address_in;

	output reg [18:0] brick_out;
	output [5:0] brick_count; 
	reg [7:0] x_coord;
	reg [7:0] y_coord;
	
	// Wires
	wire [18:0] data_out;
	wire write_en; 			// write status for ram module
	reg [2:0] color; 			// Color of brick
	reg [5:0] counter;		// Counter for brick loading
	reg [5:0] address_wire;	// Address of brick 
	reg [18:0] data_in; 		// Format {x, y, color} where x/y are 8 bits
									// and color is 3 bits 
	
	
	assign write_en = perform_delete; 
	
	// Setting up address and R/W data inputs
	always @(*)
	begin
		if(!loading) 
		begin
			if(!send_address_in)
			begin
				address_wire = 6'b0;
			end
			else
			begin
				address_wire = address_in;
			end				
		end
		else
		begin
			address_wire = counter;
		end
	end
	
	// Read from RAM 
	always @(posedge clock)
	begin
		if(ld_status)
			brick_out = data_out; //read from ram
	end
	
	// Count bricks to load
	always @(posedge clock, negedge resetn)
	begin
		if (!resetn)
		begin
			counter <= 6'd0;
			x_coord <= 8'b0; 
			y_coord <= 8'b00001000;
			 
		end	
		else if (loading)
		begin
			counter <= counter + 1;
			begin
				if (x_coord == 8'd144)begin
					x_coord <= 8'b0;
					y_coord <= y_coord + 8'd4;
				end
				else
					x_coord <= x_coord + 8'd16;
			end
		end
	end
	
	assign brick_count = counter; 
		
	// assign_colors
	always@(*)
	begin							// Assign colors
		if (y_coord == 8'd8)
			color = 3'b100;  		// Red
		else if (y_coord == 8'd12)
			color = 3'b101;		// Pink
		else if (y_coord == 8'd16)
			color = 3'b110;		// Yellow
		else if (y_coord == 8'd20)
			color = 3'b010;		// Green
		else if (y_coord == 8'd24)
			color = 3'b011;		// Turq
		else if (y_coord == 8'd28)
			color = 3'b001;		// Blue
		else 
			color = 3'b000; 
	end
	
	// Create data in
	always @(*)
	begin
		if (loading)
			data_in = {x_coord, y_coord, color};
		else if (perform_delete)
			data_in = {data_out[18:11], data_out[10:3], 3'b0};
		else 
			data_in = {8'b0, 8'b0, 3'b0};			
	end
	
	
	// Ram Module, read/write setup
	brick_ram r0 (	.address(address_wire),
						.clock(clock),
						.data(data_in),
						.wren(perform_delete),
						.q(data_out)
						);
endmodule
