# Wall-Beater
Based on the Atari game "Breakout", where the player's goal is to break down as many of the displayed bricks as possible using a single ball.

## Description
Wall beater is a game consisting of a block of bricks that the player has to break
 down using a single ball.
There are in total six rows of bricks, each row being a different color. If the
 player breaks a brick in the first row, he earns one point. The number of points
  to be earned increases as the player breaks a brick of a higher row. The player's
   goal is to hit as many of the bricks as possible (and thus earn as many points
    as possible), by using the ball which bounces back and forth between the wall
     of bricks and a paddle located at the bottom of the screen. If the player fails
      to bounce the ball using the paddle, he/she loses the game.

##Usage & Installation 
###Software & Hardware required
  * Quartus 2 
  * VGA Display (along with vga wiring to connect to de1)
  * De1-Soc board

###Steps for project setup, compliation and running
  * Ensure the De1-Soc board is plugged in
  * Create a new (empty) Quartus 2 Project
  * The top level module is **wall_beater_top**
  * Add all verilog files when prompted. 
  * Use 5CSEMA5F31C6 as the available device
  * Keep rest of the Family & Device settings default, click finish. 
  * Click Assignments > Import Assignments > Select DE1_SoC.qsf > Click Ok.
  * Go to Processing, Start compilation (it will take some time to finish). 
  * Once finished, click Tools > Programmer
  * Click Hardware Setup, in the pop up ensure De1-Soc board is selected
  * Click close, then click Start
  * The VGA display should now display the game. 

###Controls
  * Paddle control : KEY[1:0]
  * Reset State : KEY[2]

## Built With
* Verilog

## Authors
* Nana Nosirova
* Humair Khan
