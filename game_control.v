`timescale 1ns / 1ns // `timescale time_unit/t

/* Control that keeps track of the state of the game */
module game_control(
					clock, 
					reset_game_control, 
					play_game, 
					all_bricks_down, 
					ball_down, 
					play_again,
					startup_done, 
					over_done, 
					reset_startup_counter, 
					enable_startup_counter, 
					reset_over_counter, 
					enable_over_counter, 
					startup_plot, 
					over_plot,
					reset_brick_count, 
					enable_brick_count, 
					run_game, 
					reset_control, 
					sel_screen
					);
					
	input clock;
	input reset_game_control; // SW[0]
	input play_game;       // KEY[2]
	input all_bricks_down, ball_down;
	input play_again; // KEY[2]    
	
	input startup_done, over_done;
	
	output reg reset_startup_counter, enable_startup_counter;
	output reg reset_over_counter, enable_over_counter;
	output reg startup_plot, over_plot;
	
	
	output reg reset_brick_count, enable_brick_count;
	output reg run_game; // enable the control module 
	output reg reset_control; //resets the control module
	output reg [1:0] sel_screen; 
	
	localparam
		RESET_GAME = 4'd1,               // resets the needed modules
		SHOW_STARTUP_SCREEN = 4'd0, 	 // displays startup message on the screen 
		PLAY_GAME = 4'd2,     			 // plays the game - checks for failure or win
		RESTART_GAME = 4'd3, 			 // if all the bricks have been beaten down, prompts user
		GAME_OVER_SCREEN = 4'd4;		 // if failed, display game over screen
		
	reg [3:0] current_state, next_state;
	
	always @ (*)
	begin: state_table 
		case (current_state)
			RESET_GAME: next_state = SHOW_STARTUP_SCREEN;
			SHOW_STARTUP_SCREEN: begin
				if (startup_done)    
				 	next_state = (!play_game) ? PLAY_GAME: SHOW_STARTUP_SCREEN;
				else 
					next_state = SHOW_STARTUP_SCREEN;
			end 
			PLAY_GAME:
				begin
					if (ball_down)
						next_state = GAME_OVER_SCREEN;
					else if (all_bricks_down)
						next_state = RESET_GAME;
					else
						next_state = PLAY_GAME;
				end 
			GAME_OVER_SCREEN: begin
				if (over_done)
					next_state = (!play_again) ? RESET_GAME : GAME_OVER_SCREEN;
				else 
					next_state = GAME_OVER_SCREEN;
				end
			default: next_state = RESET_GAME;
		endcase 
	end
	
	always @ (*)
		begin: enable_signals
			reset_brick_count = 1; 
			enable_brick_count = 0;
			run_game = 0;
			reset_control = 1;
			reset_startup_counter = 1;
			reset_over_counter = 1;
			enable_startup_counter = 0;
			enable_over_counter = 0;
			startup_plot = 0;
			over_plot = 0; 
			sel_screen = 2'd0;
			case (current_state)
				RESET_GAME: begin
				   reset_control = 0;
				   reset_brick_count = 0;
				   reset_startup_counter = 0;
				   reset_over_counter = 0;
				   sel_screen = 2'd0;
				end 
				SHOW_STARTUP_SCREEN: begin
					enable_startup_counter = 1;
					startup_plot = 1; 
					sel_screen = 2'd0;	
				end
				PLAY_GAME: begin
					enable_brick_count = 1;
					run_game = 1;
					sel_screen = 2'd2;
				end 
				GAME_OVER_SCREEN: begin 
					sel_screen = 2'd1;
					enable_over_counter = 1;
					over_plot = 1;
				end
			endcase 
		end
		     
		
	always @ (posedge clock, negedge reset_game_control)
	begin: state_FFs
		if (!reset_game_control)
			current_state <= RESET_GAME;
		else
			current_state <= next_state;
	end 
		  	 
			
endmodule		 
	