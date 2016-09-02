`timescale 1ns / 1ns // `timescale time_unit/time_precision

module sprite_control(
				clock, 
				reset_control, 
				ball_done, 
				paddle_done, 
				reset_dividers, 
				enable_delay,
				frame_counter,
				sel_draw, 
				ball_reset_state, 
				paddle_reset_state, 
				enable_ball, 
				enable_paddle, 
				enable_brick_detector,
				brick_counter_x, 
				brick_counter_y, 
				brick_gen_reset, 
				brick_gen_enable, 
				brick_done, 
				brick_enable, 
				brick_display_reset,
				brick_storage_reset, 
				check_status, 
				brick_count,
				got_brick, 
				brick_collision, 
				delete_brick,
				signal_collision, 
				disable_collision, 
				run_game, 
				reset_score,
				reset_counter_done, 
				reset_screen, 
				enable_reset_counter, 
				reset_plot
				);

	input clock;
	input ball_done; // notifies when the ball is done 
	input paddle_done; // notifies when the paddle is done  
	input reset_control; // resets this fsm        
	input [3:0] frame_counter; // counts the number of frames 
	input got_brick; // signals when the brick from brick storage can be read
	input run_game; // signals when the game can run 
	output reg reset_score; // signal to reset the score 
	
	output reg reset_dividers; // resets the rate dividers
	output reg enable_delay; // enables the rate dividers                       
	output reg [2:0] sel_draw; // selects which sprite to draw
	output reg ball_reset_state; // resets the ball_control in the ball module 
	output reg paddle_reset_state; // resets the paddle_control in paddle module 
	     
	output reg enable_ball; // enables the ball_control to move to next state
	output reg enable_paddle; // enables the paddle_control to move to next state 
	
	/* Brick storage variables */
	input [5:0] brick_count; 
	output reg brick_storage_reset; 
	output reg check_status; 
	output reg delete_brick;
	
	/* Brick counter (wall_beater_top) variables*/
	input [7:0] brick_counter_x;
	input [6:0] brick_counter_y;
	output reg brick_gen_reset;
	output reg brick_gen_enable;
	      
	/* Brick display variables */
	input brick_done;
	output reg brick_enable;
	output reg brick_display_reset;  
	
	/* Collsion detector variables */
	output reg enable_brick_detector;
	output reg signal_collision; 
	output reg disable_collision; 
	input [1:0] brick_collision;
	
	/* RESET SCREEN VARIABLES */
	output reg reset_screen;
	output reg enable_reset_counter;
	output reg reset_plot;
	input reset_counter_done;
	  
	
	localparam 
		RESET_SPRITES = 5'd0, 		// reset the controls for ball and paddle 
		RESET_SCREEN = 5'd1, 		// draw the screen black
		RESET_BRICKS = 5'd2, 		// reset brick storage  
		DISPLAY_RESET = 5'd3, 		// reset brick display 
		GET_BRICK = 5'd4,			// read the brick from brick storage 
		DRAW_BRICK = 5'd5, 			// display the brick on VGA 
		CHANGE_COORD = 5'd6, 		// get another brick 
		CHECK = 5'd7,           	// check if all the bricks have been displayed 
		DRAW_BALL = 5'd8,       	// display the ball on VGA
		DISABLE_COLLISION = 5'd9,   // disable collision detection after ball moves
		DRAW_PADDLE = 5'd10,        // display paddle on VGA 
		LOAD_DIVIDERS = 5'd11,		// loads the rate dividers 
		DELAY = 5'd12,				// delays so that VGA can display the changes
		ERASE_BALL = 5'd13,			// erases ball from VGA, to show movement
		ERASE_PADDLE = 5'd14,		// erases paddle from VGA, to show movement
		RESET_COUNTER = 5'd15,		
		GET_BRICK_2 = 5'd16,        // gets brick from brick storage to check for collision 
		ENABLE_COLLISION = 5'd17,	// enables the collision detector 
		COLLISION_DETECT = 5'd18, 	// detects if a collision was made by brick (paddle collision is combinational)
		ERASE_BRICK_RESET = 5'd19,  // get ready to erase brick if hit
		DELETE_BRICK = 5'd20,		// "delete" the brick from storage 
		ERASE_BRICK = 5'd21,        // erase the brick from VGA if it has been hit by the ball 
		ENABLE_COUNTER = 5'd22;     // enable the counter that counts the number of bricks that 
									// have been tested for cllision
		
		
	reg [4:0] current_state, next_state;
	
	always@(*)
	begin : state_table
		case (current_state)
			RESET_SPRITES: next_state = RESET_SCREEN;
			RESET_SCREEN: next_state = (reset_counter_done) ?  RESET_BRICKS : RESET_SCREEN;
			RESET_BRICKS: next_state = DISPLAY_RESET;
			DISPLAY_RESET: next_state = GET_BRICK;
			GET_BRICK: next_state = (got_brick == 1'b1) ? DRAW_BRICK : GET_BRICK; 
			DRAW_BRICK: next_state = (brick_done) ? CHANGE_COORD : DRAW_BRICK;
			CHANGE_COORD: next_state = CHECK;
			CHECK: next_state = (brick_count == 6'd60) ? DRAW_BALL : DISPLAY_RESET;
			DRAW_BALL: next_state = (ball_done) ? DISABLE_COLLISION : DRAW_BALL;
			DISABLE_COLLISION: next_state = DRAW_PADDLE; 
			DRAW_PADDLE: next_state = (paddle_done) ? LOAD_DIVIDERS : DRAW_PADDLE;
			LOAD_DIVIDERS: next_state = DELAY;
			DELAY: next_state = (frame_counter == 4'd0) ? ERASE_BALL : DELAY;  
			ERASE_BALL: next_state = (ball_done) ? ERASE_PADDLE : ERASE_BALL;
			ERASE_PADDLE: next_state = (paddle_done) ? RESET_COUNTER : ERASE_PADDLE;
			RESET_COUNTER: next_state = GET_BRICK_2;
			GET_BRICK_2: next_state = (got_brick == 1'b1) ? ENABLE_COLLISION : GET_BRICK_2;
			ENABLE_COLLISION: next_state = COLLISION_DETECT;
			COLLISION_DETECT: next_state = (brick_collision != 2'd0) ? ERASE_BRICK_RESET : ENABLE_COUNTER;
			ERASE_BRICK_RESET: next_state = DELETE_BRICK;
			DELETE_BRICK: next_state = (got_brick == 1'b1) ? ERASE_BRICK : DELETE_BRICK; 
			ERASE_BRICK: next_state = (brick_done == 1'b1) ? ENABLE_COUNTER : ERASE_BRICK;
			ENABLE_COUNTER: next_state = (brick_count == 6'd60) ? DRAW_BALL : GET_BRICK_2;
		default: next_state = RESET_SPRITES;
		endcase
	end 
	
	always @ (*)
		begin: enable_signals
			ball_reset_state = 1;
			paddle_reset_state = 1;
			brick_storage_reset = 1; 
			enable_ball = 0;
			enable_paddle = 0;
			reset_dividers = 1;
			enable_delay = 0;
			check_status = 0; 
			brick_gen_reset = 1;
            brick_gen_enable = 0;	
   			brick_enable = 0;
   			brick_display_reset = 1;
   			enable_brick_detector = 0;   
   			delete_brick = 0;
			signal_collision = 0; 
			disable_collision = 0;
			reset_score = 1;
			reset_screen = 1;
			reset_plot = 0;
			enable_reset_counter = 0; 
			sel_draw = 3'd2;
			
			case (current_state)
				RESET_SPRITES: begin
					ball_reset_state = 0;
					paddle_reset_state = 0;
					brick_storage_reset = 0;      
					reset_dividers = 0;
					sel_draw = 3'd2;
					reset_score = 0;
					reset_screen = 0;
				end 
				RESET_SCREEN: begin
					enable_reset_counter = 1;
					reset_plot = 1;
					sel_draw = 3'd2;
				end    
				RESET_BRICKS: begin
					brick_gen_reset = 0;
					sel_draw = 3'd3;
				end 
				DISPLAY_RESET: begin
					brick_display_reset = 0;
					sel_draw = 3'd3;
				end 
				GET_BRICK: begin									
					check_status = 1; 
				end
				DRAW_BRICK: begin
					brick_enable = 1; 
					sel_draw = 3'd3;
				end 
				CHANGE_COORD: begin
					brick_gen_enable = 1;
				end   
				CHECK: begin
				end 
				DRAW_BALL: begin
					enable_ball = 1;
					sel_draw = 3'd0;
				end 
				DISABLE_COLLISION : begin
					disable_collision = 1; 
					signal_collision = 1;
				end 
				DRAW_PADDLE: begin 
					enable_paddle = 1;
					sel_draw = 3'd1;
				end 
				LOAD_DIVIDERS: begin
					reset_dividers = 0;
				end 
				DELAY: begin
					enable_delay = 1;
				end 
				ERASE_BALL: begin
					enable_ball = 1; 
					sel_draw = 3'd0;
				end 
				ERASE_PADDLE: begin
				   enable_paddle = 1;
					sel_draw = 3'd1;
				end
				RESET_COUNTER: begin
					brick_gen_reset = 0;
					sel_draw = 3'd3; 
				end
				GET_BRICK_2: begin
					check_status = 1;
				end 
				ENABLE_COLLISION: begin
					enable_brick_detector = 1;
				end 
				COLLISION_DETECT: begin
					signal_collision = 1; 
				end 
				ERASE_BRICK_RESET: begin
					brick_display_reset = 0;
					sel_draw = 3'd3;
				end
				DELETE_BRICK: begin 
					delete_brick = 1;
					check_status = 1;
				end
				ERASE_BRICK: begin
					brick_enable = 1;
					sel_draw = 3'd3;
				end
				ENABLE_COUNTER: begin
					brick_gen_enable = 1;
				end  	
			endcase 
		end
		
	// Current state registers
	always @ (posedge clock, negedge reset_control)
	begin: state_FFs
		if (!reset_control)
			current_state <= RESET_SPRITES;
		else if (run_game)
			current_state <= next_state;
	end
	
	
	
	
endmodule