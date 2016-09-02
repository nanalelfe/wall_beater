`timescale 1ns / 1ns // `timescale time_unit/t

module wall_beater_top(
					CLOCK_50,
					KEY,
					SW,
					VGA_CLK,   						//	VGA Clock
					VGA_HS,							//	VGA H_SYNC
					VGA_VS,							//	VGA V_SYNC
					VGA_BLANK_N,						//	VGA BLANK
					VGA_SYNC_N,						//	VGA SYNC
					VGA_R,   						//	VGA Red[9:0]
					VGA_G,	 						//	VGA Green[9:0]
					VGA_B,
						//	VGA Blue[9:0] */
					HEX0,
					HEX1,
					HEX2,
					HEX3,
					HEX4, 
					HEX5
					);

	input CLOCK_50;
	input [2:0] KEY; // paddle control : KEY[1:0], reset_state : KEY[2]  
	input [9:0] SW;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;   // needed to display score
	wire run_game; 

	wire reset_score; 
	
	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0] */

	//Input to VGA 
	
	/* The coordinates change based on the selected sprite to draw */ 
	reg [7:0] x;
	reg [6:0] y; 
	reg [2:0] colour;
	wire reset_vga;
	reg plot_to_vga;
	
	/* Reset-screen-to-black variables */
	wire reset_screen;
	wire enable_reset_counter;
	wire reset_plot;
	reg [7:0] reset_counter_x;
	reg [6:0] reset_counter_y;
	wire reset_counter_done = ((reset_counter_x == 8'd159) & (reset_counter_y == 7'd119)) ? 1 : 0; 

	/* Ball movement variables */

	wire [2:0] ball_colour_in = 3'b100; //red
	wire [2:0] ball_colour_out;
	wire ball_reset_state; // control via FSM   
	wire [7:0] ball_x_top; // top left x coordinate
	wire [6:0] ball_y_top; // top left y coordinate
	wire [7:0] ball_x;
	wire [6:0] ball_y;
	wire ball_done;
	wire enable_ball; //enables ball movement (FSM) 
	wire ball_plot;


	/* Paddle movement variables */
	
	wire [2:0] paddle_colour_in = 3'b100; //red
	wire [2:0] paddle_colour_out;
	wire paddle_col_sel; // paddle colour select, 1 - colour_in, 0 - black (FSM)
	wire paddle_reset; // control via FSM
	wire enable_paddle_move; //enables paddle movement (FSM)  
	wire [7:0] paddle_x_top; // top left x coordinate
	wire [6:0] paddle_y_top; // top left y coordinate
	wire [7:0] paddle_x;
	wire [6:0] paddle_y;
	wire paddle_done;   
	wire paddle_plot;

	
	/**********************************************************************************************/ 

	reg [3:0] fr_counter;
	wire frame_wave;

	reg [16:0] del_counter;
	wire delay_wave;  
	
	reg [5:0] address_counter; 
	
	/* Control outputs (additional) */ 
	
	wire reset_dividers;
	wire enable_delay;
	
	wire [2:0] sel_draw; // 00 - ball, 01 - paddle
	
	reg [23:0] score; // score count




	/***********************************************************************************************

	/* COLLISION VARIABLES */
	
   wire paddle_collision;
	wire [1:0] brick_collision;
	wire enable_brick_detector;
	reg  [1:0] signal_ball_collision;
	wire signal_collision; 
	wire disable_collision;
	wire h_ball_direction;
	wire v_ball_direction; 
	
	reg [1:0] v_col_count; 
	reg [1:0] h_col_count; 
	reg [1:0] d_col_count; 
	
	/**********************************************************************************************/
	/*  BRICK COORDINATE GENERATOR */
	
	wire brick_gen_reset;
	wire brick_gen_enable;
	reg [7:0] x_gen;
	reg [6:0] y_gen;      
	reg [2:0] brick_col_gen;    
	wire [2:0] red = 3'b100;
	wire [2:0] pink = 3'b101;
	wire [2:0] yellow = 3'b110;
	wire [2:0] green = 3'b010;
	wire [2:0] turq = 3'b011;
	wire [2:0] blue = 3'b001;				
	
	/***********************************************************************************************/
	/* BRICKS */                 

	wire brick_display_reset;

	/* Brick counter variables */
	reg [3:0] brick_counter_x;
	reg [1:0] brick_counter_y; 
	wire brick_reset_counters, brick_enable_counters; 

	/* Brick storage variables */
	wire done_fetching;
	wire done_loading;
	wire brick_storage_reset;
	reg [5:0] address_wire; 
	wire check_status_wire; 
	wire delete_brick_wire; 
	wire [5:0] brick_count; 
	wire delete_brick;
	wire [18:0] brick_out; // output from brick_storage
	
	
	wire read; // whether brick_out should be read from brick_storage
	wire reset_regs;
	wire load_regs;
	wire [7:0] brick_x;
	wire [6:0] brick_y;
	wire [2:0] brick_colour;

	wire brick_done;
	wire brick_enable;
	wire brick_plot;
	
	/***************************************************************************************

	 /* GAME CONTROL VARIABLES */

	wire all_bricks_down; 
	wire ball_down;
	reg [5:0] brick_no;
	wire reset_brick_count, enable_brick_count; 

	assign ball_down = (ball_y_top == 7'd117) ? 1 : 0;
	assign all_bricks_down = (brick_no == 6'd60) ? 1 : 0; 
	
	wire reset_startup_counter;
	wire enable_startup_counter;
	wire [7:0] startup_x;
	wire [6:0] startup_y;
	wire startup_plot;
	wire [2:0] startup_colour = 3'b001;
		
	wire reset_over_counter;
	wire enable_over_counter;
	wire [7:0] over_x;
	wire [6:0] over_y;
	wire over_plot;
	wire [2:0] over_colour = 3'b100;

	wire [1:0] sel_screen;
	
	reg [7:0] sprite_x;
	reg [6:0] sprite_y;
	reg [2:0] sprite_colour;
	reg sprite_plot;
	
	wire [8:0] block_counter;
	wire [8:0] block_counter_over;

	wire startup_done = (block_counter == 9'd109) ? 1 : 0;
	wire over_done = (block_counter_over == 9'd246) ? 1 : 0;

	wire reset_game_control = SW[0];
	wire play_game = KEY[2];
	wire play_again = KEY[2];
	
	
	

	game_control g0(
			.clock(CLOCK_50), 
			.reset_game_control(reset_game_control), 
			.play_game(play_game), 
			.all_bricks_down(all_bricks_down), 
			.ball_down(ball_down), 
			.play_again(play_again),
			.startup_done(startup_done), 
			.over_done(over_done), 
			.reset_startup_counter(reset_startup_counter), 
			.enable_startup_counter(enable_startup_counter), 
			.reset_over_counter(reset_over_counter), 
			.enable_over_counter(enable_over_counter), 
			.startup_plot(startup_plot), 
			.over_plot(over_plot),
			.reset_brick_count(reset_brick_count), 
			.enable_brick_count(enable_brick_count), 
			.run_game(run_game), 
			.reset_control(reset_vga), 
			.sel_screen(sel_screen)
		);

	brick_display_control bc0(
			 .clock(CLOCK_50),
			 .plot(brick_plot),
			 .brick_counter_x(brick_counter_x),
			 .brick_counter_y(brick_counter_y), 
			 .enable_state(brick_enable),
			 .reset_state(brick_display_reset), 
			 .brick_reset_counters(brick_reset_counters), 
			 .brick_enable_counters(brick_enable_counters), 
			 .read(read), 
			 .reset_regs(reset_regs), 
			 .load_regs(load_regs), 
			 .done(brick_done)
			 );
	
	brick_display bd0(
			.clock(CLOCK_50), 
			.brick_out(brick_out), 
			.read(read), 
			.reset_regs(reset_regs), 
			.load_regs(load_regs), 
			.brick_counter_x(brick_counter_x), 
			.brick_counter_y(brick_counter_y), 
			.x_out(brick_x), 
			.y_out(brick_y), 
			.colour_out(brick_colour)
			);
			     
	collision_detector cd0(
		.clock(CLOCK_50),				
		.ball_x(ball_x_top), 
		.ball_y(ball_y_top), 
		.paddle_x(paddle_x_top), 
		.paddle_y(paddle_y_top),
		.brick_out(brick_out),
		.enable_brick_detector(enable_brick_detector), 
		.paddle_collision(paddle_collision), 
		.brick_collision(brick_collision),
		.h_ball_direction(h_ball_direction),
		.v_ball_direction(v_ball_direction)
		);
		
   // manages the collision signals 
	always @(posedge CLOCK_50)
	begin
		if(signal_collision) begin
			if ((brick_collision != 2'b00))begin
				case (brick_collision[1:0])
				2'd01: v_col_count <=  v_col_count + 1'd1;
				2'd10: h_col_count <=  h_col_count + 1'd1;
				2'd11: d_col_count <=  d_col_count + 1'd1;
			endcase
			end
			else if(disable_collision)begin
				h_col_count <= 2'b00;
				v_col_count <= 2'b00; 
				d_col_count <= 2'b00; 
			end
		end
	end
	
	
	
	sprite_control c0 (
		.clock(CLOCK_50), 
		.reset_control(reset_vga), 
		.ball_done(ball_done), 
		.paddle_done(paddle_done),
		.reset_dividers(reset_dividers),
		.enable_delay(enable_delay),
		.frame_counter(fr_counter),
		.sel_draw(sel_draw),
		.ball_reset_state(ball_reset_state), 
		.paddle_reset_state(paddle_reset), 
		.enable_ball(enable_ball), 
		.enable_paddle(enable_paddle_move),
		.enable_brick_detector(enable_brick_detector),
		.brick_counter_x(x_gen),						// Input: When it counts all bricks, moves to draw ball
		.brick_counter_y(y_gen), 						// Input: Same as above, VGA Top -> VGA FSM 
		.brick_gen_reset(brick_gen_reset), 				// Output: VGA FSM -> VGA top
		.brick_gen_enable(brick_gen_enable), 			// Output: VGA FSM -> VGA top					// Enable brick generator counting
		.brick_done(brick_done),						// Input: From Brick FSM -> VGA FSM 		// Done drawing a brick
		.brick_enable(brick_enable), 					// Output: From VGA FSM -> VGA Top  		// Enable brick pixel counting
		.brick_display_reset(brick_display_reset), 		// Output: VGA FSM -> Brick FSM
		.brick_storage_reset(brick_storage_reset),
		.check_status(check_status_wire),
		.brick_count(address_wire),
		.got_brick(done_fetching),
		.brick_collision(brick_collision),
		.delete_brick(delete_brick),
		.signal_collision(signal_collision),
		.disable_collision(disable_collision),
		.run_game(run_game),
		.reset_score(reset_score),
		.reset_counter_done(reset_counter_done),
		.reset_screen(reset_screen),
		.enable_reset_counter(enable_reset_counter),
		.reset_plot(reset_plot)
		);
		
	ball b0(
		.clock(CLOCK_50), 
		.reset_state(ball_reset_state), 
		.enable_state(enable_ball),
		.colour_in(ball_colour_in), 
		.colour(ball_colour_out), 
		.x(ball_x), 
		.y(ball_y),
		.done(ball_done),
		.plot(ball_plot),
		.paddle_collision(paddle_collision),
		.v_col_count(v_col_count),
		.h_col_count(h_col_count),
		.d_col_count(d_col_count),
		.ball_x_top(ball_x_top),
		.ball_y_top(ball_y_top),
		.h_q(h_ball_direction),
		.v_q(v_ball_direction)
		);   
		
	paddle_top p0 (
		.clock(CLOCK_50), 
		.reset_state(paddle_reset), 
		.enable_state(enable_paddle_move), 
		.colour_in(paddle_colour_in),
		.move_left(KEY[1]), 
		.move_right(KEY[0]),  
		.colour_out(paddle_colour_out), 
		.x(paddle_x), 
		.y(paddle_y), 
		.done(paddle_done),
		.plot(paddle_plot),
		.paddle_x_top(paddle_x_top),
		.paddle_y_top(paddle_y_top)
		);      
			 
	brick_storage_top bs0( 
				.clock(CLOCK_50),
				.resetn(brick_storage_reset),
				.address(address_wire),
				.delete_brick(delete_brick),
				.check_status(check_status_wire),
				.done_loading(done_loading),
				.done(done_fetching),
				.brick_out(brick_out), 
				.brick_count(brick_count)
				);

	/* Score output */
	
	hex_decoder h0 (.hex_digit(score[3:0]) , .segments(HEX0));
	hex_decoder h1 (.hex_digit(score[7:4]) , .segments(HEX1));
	hex_decoder h2 (.hex_digit(score[11:8]) , .segments(HEX2));
	hex_decoder h3 (.hex_digit(score[15:12]) , .segments(HEX3));
	hex_decoder h4 (.hex_digit(score[19:16]) , .segments(HEX4));
	hex_decoder h5 (.hex_digit(score[23:20]) , .segments(HEX5)); 
	
	
	// Select which sprite to draw
	always @ (*)
	begin
		case (sel_draw)
			3'b00:
			begin
				sprite_x = ball_x;
				sprite_y = ball_y;
				sprite_colour = ball_colour_out;
				sprite_plot = ball_plot;
			end
			3'b01:
			begin
				sprite_x = paddle_x;
				sprite_y = paddle_y;
				sprite_colour = paddle_colour_out;
				sprite_plot = paddle_plot;
			end
			3'b10:
			begin
				sprite_x = reset_counter_x;
				sprite_y = reset_counter_y;
				sprite_colour = 3'd0;
				sprite_plot = reset_plot;
			end
			3'b11:
			begin
				sprite_x = brick_x;
				sprite_y = brick_y; 
				sprite_colour = brick_colour;
				sprite_plot = brick_plot;
			end
		endcase 
	end
	
	/************************   COUNTERS    *************************************************/	
		
	// Delay counter
	always @ (posedge CLOCK_50, negedge reset_dividers)
	begin
		if (!reset_dividers)
			del_counter <= 17'd99_999_999;
		else if (del_counter == 17'd0)
			del_counter <=  17'd99_999_999;
		else if (enable_delay == 1'b1)
			begin
			del_counter <= del_counter - 1'b1;
			end
	end

	assign delay_wave = (del_counter == 17'd0) ? 1 : 0; 

	assign en_frame = delay_wave;

	// Frame counter
	always @ (posedge CLOCK_50, negedge reset_dividers)
	begin
		if (!reset_dividers)
			fr_counter <= 4'd15;
		else if (fr_counter == 4'd0)
			fr_counter <= 4'd15;
		else if (en_frame == 1'b1)
			begin 
			fr_counter <= fr_counter - 1'b1;
			end
	end
	
	assign frame_wave = (fr_counter == 4'd0) ? 1 : 0;	
	
	
	// Brick counter - generates x y coordinates to plot the brick
	always @ (posedge CLOCK_50, negedge brick_reset_counters)
		begin 
		
		if (!brick_reset_counters)
		begin
			brick_counter_x <= 4'd0;
			brick_counter_y <= 2'd0;
		end 
		
		else if (brick_enable_counters)
		begin
			if ((brick_counter_x == 4'd15) & (brick_counter_y == 2'd3))
			begin
				brick_counter_x <= 4'd0;
				brick_counter_y <= 2'd0;
			end
			else if (brick_counter_x == 4'd15)
			begin
				brick_counter_x <= 4'd0;
				brick_counter_y <= brick_counter_y + 1;
			end
			else
				brick_counter_x <= brick_counter_x + 1;
		end
		end 
	              
	              
	              
	// Address counter - for brick storage 
	always @ (posedge CLOCK_50, negedge brick_gen_reset)
	begin
			if (!brick_gen_reset)
				address_wire <= 6'b0; 
			else if (brick_gen_enable)
				address_wire <= address_wire + 1; 
	end
	
	/* Score count */	
	always @ (posedge CLOCK_50) 
	begin
		if (!reset_score)
			score <= 24'd0;
		else if (brick_collision[1:0] != 2'b00)
		begin
			case (brick_out[2:0])
				3'd001: score <= score + 24'd1;
				3'd011: score <= score + 24'd2;
				3'd010: score <= score + 24'd3;
				3'd110: score <= score + 24'd4;
				3'd101: score <= score + 24'd5;
				3'd100: score <= score + 24'd6;
				default: score <= 24'd0;
			endcase
		end  		
	end

	/* Generates (x,y) coordinates to reset the screen to black */ 
	always @ (posedge CLOCK_50)
	begin
	   if (!reset_screen)
	   		begin
	   		reset_counter_x <= 8'd0;
	   		reset_counter_y <= 7'd0;
	   		end 
		else if (enable_reset_counter)
			begin
				if ((reset_counter_x == 8'd159) & (reset_counter_y == 7'd119))
					begin
						reset_counter_x <= 8'd0;
						reset_counter_y <= 7'd0;
					end
				else if (reset_counter_x == 8'd159)
					begin 
						reset_counter_x <= 8'd0;
						reset_counter_y <= reset_counter_y + 1'd1;
					end 
				else 
						reset_counter_x <= reset_counter_x + 1'd1;
			end 	 
	  			
	end 	

	/*  Counts the number of bricks taken down */

	always @ (posedge CLOCK_50)
	begin
		if (!reset_brick_count)
			brick_no <= 6'd0;
		else if (enable_brick_count)
			begin
			if (brick_collision)
				brick_no <= brick_no + 1'd1;
			end
	end	
	
	
	// Select screen
	always @ (*)
	begin
		case (sel_screen)
			2'd0: begin      // select the startup screen 
				x = startup_x;
				y = startup_y;
				colour = startup_colour;
				plot_to_vga <= startup_plot;
			end
			2'd1: begin		// select the game over screen 
				x = over_x;
				y = over_y;
				colour = over_colour;
				plot_to_vga = over_plot;
			end
			2'd2: begin   	// select the gameplay screen
				x = sprite_x;
				y = sprite_y;
				colour = sprite_colour;
				plot_to_vga = sprite_plot;
			end
			
		endcase
	end 		
	
	
	draw_startup ds0(
		.clock(CLOCK_50), 
		.reset_startup_counter(reset_startup_counter), 
		.enable_startup_counter(enable_startup_counter), 
		.startup_x(startup_x), 
		.startup_y(startup_y),
		.block_counter(block_counter)
		);
	
	draw_over do0(
		.clock(CLOCK_50), 
		.reset_over_counter(reset_over_counter), 
		.enable_over_counter(enable_over_counter), 
		.over_x(over_x), 
		.over_y(over_y), 
		.block_counter_over(block_counter_over)
		);
		
		
   	vga_adapter VGA(
			.resetn(reset_vga),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(plot_to_vga),
			// Signals for the DAC to drive the monitor.
		    	.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif"; 
		 		 

endmodule
