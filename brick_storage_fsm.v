`timescale 1ns / 1ns


module brick_storage_fsm(clock, resetn, 
								brick_count, check_status, 
								loading, ld_status, done_sig, 
								send_address_in, delete_brick, perform_delete);
	
	// Control signals from collider/vga display
			// reset, deletebrick, check_status
	input clock, resetn;
	input check_status;
	input [5:0] brick_count;	
	input delete_brick; 
	
	output reg loading; 
	output reg ld_status;
	output reg done_sig;
   output reg perform_delete;
	output reg send_address_in; 
	
	localparam
		LOAD_BRICKS = 3'b000,			//0
		WAIT_FOR_SIGNAL = 3'b001,		//1
		RW_BRICK = 3'b010,				//2
		LOAD_BRICK = 3'b011,				//3
		DELETE_BRICK = 3'b100,			//4
		LOAD_DELETED_BRICK = 3'b101, 	//5
		DONE_SIGNAL = 3'b110;			//6
		
	wire brick_exists; 
	reg [2:0] current_state, next_state; 
	
	// State table
	always @(*)
	begin : state_table 
		case (current_state)
		LOAD_BRICKS: 		next_state = (brick_count == 6'd59) ?  WAIT_FOR_SIGNAL : LOAD_BRICKS;
		WAIT_FOR_SIGNAL: 	next_state = (check_status) ? RW_BRICK : WAIT_FOR_SIGNAL;
		RW_BRICK: 			next_state = LOAD_BRICK;
		LOAD_BRICK: 		next_state = (delete_brick == 1'b0) ? DONE_SIGNAL : DELETE_BRICK;
		DELETE_BRICK:		next_state = LOAD_DELETED_BRICK; 
		LOAD_DELETED_BRICK: next_state = DONE_SIGNAL; 
		DONE_SIGNAL:		next_state = WAIT_FOR_SIGNAL;
		default 				next_state = WAIT_FOR_SIGNAL; 
		endcase
	end
	
	// Set signals 
	always @ (*)
	begin: enable_signals
		loading = 1'b0; 
		ld_status = 1'b0;
		done_sig = 1'b0;
		perform_delete = 1'b0;
		send_address_in = 1'b1;		
	case (current_state)
		LOAD_BRICKS: begin
			loading = 1'b1; 
			ld_status = 1'b0;
			done_sig = 1'b0;
			perform_delete = 1'b1; 
		end
		WAIT_FOR_SIGNAL: begin
			loading = 1'b0;
			ld_status = 1'b0;
			done_sig = 1'b0;
			send_address_in = 1'b0;
		end
		RW_BRICK: begin
			loading = 1'b0;
			ld_status = 1'b0;
			done_sig = 1'b0;
		end
		LOAD_BRICK: begin
			loading = 1'b0;
			ld_status = 1'b1;
			done_sig = 1'b0; 
		end
		DELETE_BRICK: begin
			loading = 1'b0; 
			ld_status = 1'b0; 
			done_sig = 1'b0;
			perform_delete = 1'b1; 
		end
		LOAD_DELETED_BRICK: begin
			loading = 1'b0;
			ld_status = 1'b1;
			done_sig = 1'b0; 
		end
		DONE_SIGNAL: begin
			loading = 1'b0; 
			ld_status = 1'b0; 
			done_sig = 1'b1; 
		end
	default: ;
		endcase
	end
	
	// Assign next state input
	always @ (posedge clock, negedge resetn) begin
	if (resetn == 1'b0)
		current_state <= LOAD_BRICKS;
	else
		current_state <= next_state;
	end
	
endmodule
