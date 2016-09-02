module collision_detector(clock, ball_x, ball_y, paddle_x,paddle_y, brick_out, enable_brick_detector,
						 paddle_collision, brick_collision, h_ball_direction, v_ball_direction);
	// Input ports
	input [7:0] ball_x, paddle_x;
	input [6:0] ball_y, paddle_y;
	
	input [18:0] brick_out; // x = brick_out[18:11], y = brick_out[9:3], colour = brick_out[2:0]
	input enable_brick_detector; // high when we want to check for collision
	input clock; // not sure about this one 
	
	input h_ball_direction, v_ball_direction;
	
	// Output ports
	output reg paddle_collision;
	output reg [1:0] brick_collision; //[1] signals h collision, [0] signals y collision
	
	// Assign color
	wire [2:0] color;
	assign color = brick_out[2:0]; 
	
	// Assign direction of ball
	wire [1:0] direction; 
	assign direction = {h_ball_direction, v_ball_direction}; 
	
	// Assign direction in separate wires
	wire hq, vq; 
	assign hq = h_ball_direction;
	assign vq = v_ball_direction;
	
	// Current ball corners: 
	
	// Ball  - (x,y) coordinates of each side of the ball
	wire [7:0] ball_x1 = ball_x;
	wire [6:0] ball_y1 = ball_y;
	
	wire [7:0] ball_x2 = ball_x + 2'd2;
	wire [6:0] ball_y2 = ball_y;
	
	wire [7:0] ball_x3 = ball_x1;
	wire [6:0] ball_y3 = ball_y + 2'd2;
	
	wire [7:0] ball_x4 = ball_x + 2'd2;
	wire [6:0] ball_y4 = ball_y + 2'd2; 
	
	
	// HORIZONTAL Ball  - (x,y) coordinates of each side of the ball
	// To be used for left and right side collisions on brick
	wire [7:0] h_ball_x1 = ball_x - 1'd1;
	wire [6:0] h_ball_y1 = ball_y;
	
	wire [7:0] h_ball_x2 = ball_x + 2'd3;
	wire [6:0] h_ball_y2 = ball_y;
	
	wire [7:0] h_ball_x3 = ball_x - 1'd1;
	wire [6:0] h_ball_y3 = ball_y + 2'd2;
	
	wire [7:0] h_ball_x4 = ball_x + 2'd3;
	wire [6:0] h_ball_y4 = ball_y + 2'd2; 
		

	// VERTICAL Ball  - (x,y) coordinates of each side of the ball
	// To be used for top and bottom collisions on brick
	wire [7:0] v_ball_x1 = ball_x;
	wire [6:0] v_ball_y1 = ball_y - 1'd1;
	
	wire [7:0] v_ball_x2 = ball_x + 2'd2;
	wire [6:0] v_ball_y2 = ball_y - 1'd1;
	
	wire [7:0] v_ball_x3 = ball_x1;
	wire [6:0] v_ball_y3 = ball_y + 2'd3;
	
	wire [7:0] v_ball_x4 = ball_x + 2'd2;
	wire [6:0] v_ball_y4 = ball_y + 2'd3; 
	
	// Ball outer corners (for diagonal collision, ie brick corners: 
	wire [7:0] top_left_x 	= ball_x - 1'd1; 
	wire [6:0] top_left_y 	= ball_y - 1'd1; 
	
	wire [7:0] top_right_x 	= ball_x + 2'd3; 
	wire [6:0] top_right_y 	= ball_y - 1'd1; 
	
	wire [7:0] bot_left_x 	= ball_x - 1'd1; 
	wire [6:0] bot_left_y 	= ball_y + 2'd3; 
	
	wire [7:0] bot_right_x 	= ball_x + 2'd3; 
	wire [6:0] bot_right_y 	= ball_y + 2'd3; 
	
	// Paddle - (x,y) coordinates of the top left and top right corners of the paddle
	wire [7:0] paddle_x1 = paddle_x;
	wire [7:0] paddle_x2 = paddle_x + 5'd19;
	
	wire [6:0] paddle_y1 = paddle_y;
	wire [6:0] paddle_y2 = paddle_y;  
	
	// Brick = (x,y) coordinates of each side of the brick
	wire [7:0] brick_x1 = brick_out[18:11];
	wire [6:0] brick_y1 = brick_out[9:3];
	
	wire [7:0] brick_x2 = brick_out[18:11] + 4'd15;
	wire [6:0] brick_y2 = brick_out[9:3];
	
	wire [7:0] brick_x3 = brick_out[18:11];
	wire [6:0] brick_y3 = brick_out[9:3] + 2'd3;
	
	wire [7:0] brick_x4 = brick_out[18:11] + 4'd15;
	wire [6:0] brick_y4 = brick_out[9:3] + 2'd3;  
	
	// Compare the paddle's and ball's coordinates to test collision 
	always @ (*) 
	begin 
		if (
			(((ball_x3 <= paddle_x1) && (paddle_x1 <= ball_x4)) ||
		     ((ball_x3 <= paddle_x2) && (paddle_x2 <= ball_x4)) ||
	 	     ((paddle_x1 <= ball_x3) && (ball_x3 <= paddle_x2))) && 
	 	     (ball_y3 == paddle_y1)
	 	  )
	 	  begin
	 	  	paddle_collision = 1;
	 	  end
	 	else
	 		paddle_collision = 0;
    end 
    	 
   // Compare the brick's and ball's coordinates to test collision 
	/* The process goes as follows (only one step is executed): 
	 * 	- Check for diagonal collision, set collision to 11 at success
	 *		- Check for vertical collision, set collision to 01 at sucess
	 * 	- Check for horizontal collision, set collision to 10 at success
	 */	
	always @ (posedge clock)
	begin
		if ((enable_brick_detector) && (ball_y1 < 7'd34))
		begin
			if (color == 3'd0)
				brick_collision = 2'b00;
			else if (
			((direction == 2'b11) && (brick_x1 ==  bot_right_x) && (brick_y1 == bot_right_y)) ||
			((direction == 2'b10) && (brick_x3 ==  top_right_x) && (brick_y3 == top_right_y)) ||
			((direction == 2'b01) && (brick_x2 ==  bot_left_x) && (brick_y2 == bot_left_y)) ||
			((direction == 2'b00) && (brick_x4 ==  top_left_x) && (brick_y4 == top_left_y))
			)
				brick_collision = 2'b11; // Diagonal Check
			else if (
				((((v_ball_x1 <= brick_x3) && (brick_x3 <= v_ball_x2))||
				((v_ball_x1 <= brick_x4) && (brick_x4 <= v_ball_x2))||
				((brick_x3 <= v_ball_x1) && (v_ball_x1 <= brick_x4)))&&
				(v_ball_y1 == brick_y3)) ||
				
				((((v_ball_x3 <= brick_x1) && (brick_x1 <= v_ball_x4))||
				((v_ball_x3 <= brick_x2) && (brick_x2 <= v_ball_x4))||
				((brick_x1 <= ball_x3) && (v_ball_x3 <= brick_x2)))&&
				(v_ball_y3 == brick_y1)))
				brick_collision = 2'b01; // Vertical Check
			
			else if(((((h_ball_y2 <= brick_y1) && (brick_y1 <= h_ball_y4))||
				((h_ball_y2 <= brick_y3) && (brick_y3 <= h_ball_y4))||
				((brick_y1 <= h_ball_y2) && (h_ball_y2 <= brick_y3))) &&
				(h_ball_x2 == brick_x1)) ||
		
				 ((((h_ball_y1 <= brick_y2) && (brick_y2 <= h_ball_y3))||
				((h_ball_y1 <= brick_y4) && (brick_y4 <= h_ball_y3))||
				((brick_y2 <= h_ball_y1) && (h_ball_y1 <= brick_y4))) &&
				(h_ball_x1 == brick_x2)))
				brick_collision = 2'b10; // Horizontal Check
			else
				brick_collision = 2'b00;
		end 
		else 
			brick_collision = 2'b00; 
	end 
   	
	
endmodule
