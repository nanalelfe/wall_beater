`timescale 1ns / 1ns


module brick_storage_top(clock, resetn, address, delete_brick, 
								brick_count, check_status, brick_out, 
								done, done_loading);

	// Input ports
	input clock, resetn, delete_brick, check_status; 
	input [5:0] address; 
		
	// Output ports
	output done_loading;
	output reg [18:0] brick_out;
	output done; 
	output [5:0] brick_count;
	
	// Wires
	wire loading; 
	wire [18:0] brick_received; 
	wire ld_status; 
	wire perform_delete; 
	wire send_address_in;
	
	assign done_loading = ~loading;
		
	brick_storage_fsm f0(.clock(clock),   							// Clock 50 MHZ 
								.resetn(resetn),							// Reset
								.brick_count(brick_count), 			// Number of bricks in storage
								.check_status(check_status), 			// Signal input from collider or display 
								.loading(loading), 						// Control Signal output from fsm
								.ld_status(ld_status),					// Control Signal output from fsm
								.done_sig(done),							// Sends a signal when finished loading brick
								.perform_delete(perform_delete),		// Write status for ram module
								.delete_brick(delete_brick),			// Signal for brick deletion from control fsm
								.send_address_in(send_address_in)	// Address for brick consideration 
								);												
																				
	
	brick_storage_dp d0(.clock(clock), 							// Clock 50 MHZ
							  .resetn(resetn), 						// Reset
							  .address_in(address), 				// Address input from collider or display
							  .check_status(check_status), 		// Signal input from collider or display 
							  .delete_brick(delete_brick),   	// Signal input from collider or display  
							  .ld_status(ld_status),				// Load status of brick
							  .brick_out(brick_received),			// Brick output for top level module 
							  .loading(loading), 					// Signal input from fsm
							  .brick_count(brick_count),			// Number of bricks in storage
							  .perform_delete(perform_delete),	// Signal for brick deletion from control fsm
							  .send_address_in(send_address_in)	// Address for brick consideration 
							  );
	
	// If done = 1, load brick into reg for retrieval
	always @(posedge clock)
	begin
		if (done)begin
			brick_out <= brick_received; 
		end 
	end
	
endmodule
