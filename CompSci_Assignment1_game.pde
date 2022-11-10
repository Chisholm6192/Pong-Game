/*
Ryan Chisholm
April 12th 2022
Pong Game

Full functioning AI
Single player and Two player mode, can be changed in settings
Live Scoreboard
Start and Pause screens
Pause, Resume and Restart Functions
Full functioning pause menu
Adjustable AI difficulty

Things added since last update:
Changeable control schemes, the changed controls are viewable in the settings menu,
and the new controls for the pause, resume and restart functions are displayed at the
top of the screen, as well as a new added quit game function, which ends the game.
*/

int screen = 0;//menu screen is default screen
int speedx = 0;
int speedy = 10;
int ax = 200;//x value for AI
int ay = 50;//y value for AI
int rx = 200;//x value for player
int ry = 650;//y value for player
int x = 300;//x value for ball
int y = 450;//y value for ball
int ControlScheme = 1;

int[] PlayerScore = new int[7];
int[] OPScore = new int[7];

boolean twoplayer = false;//two player mode, default mode is single player
String difficulty = "MEDIUM";//AI difficulty, default difficulty is medium


void setup(){
  size(600, 700); 
  PlayerScore[0] = 0;//player score 
  OPScore[0] = 0;//opponent score
}

void draw(){
  //graphics
  background(0);
  rect(0,350,600,10);//line in middle of screen
  rect(rx,ry,150,20);//player paddle
  rect(ax,ay,150,20);//opponent paddle
  ellipse(x,y,30,30);//ball
  textSize(17);
  if(ControlScheme == 1){
    text("ENTER = PAUSE    TAB = RESUME    SHIFT = RESTART    QUIT = DELETE",10,20);//controls heading
  }
  else if(ControlScheme == 2){
    text("Z = PAUSE      X = RESUME      C = RESTART      QUIT = DELETE",40,20);
  }
  textSize(13);
  text("AI Difficulty: " + difficulty,450,660);
  
  if(twoplayer == false){
  text("SNGLE PLAYER MODE",20,660);
  }
  else if(twoplayer == true){
    text("TWO PLAYER MODE",20,660);
  }
  //score function setup
    if(y < 10){//if the balls goes through the opponent goal
      PlayerScore[0] = PlayerScore[0] + 1;//player score increase by 1
      Pause();//stop motion, and reset paddles
      ax = 200;
      ay = 50;
      rx = 200;
      ry = 650;
      x = 300;
      y = 450;
    }
    else if(y > 690){//if the ball goes through the Players goal
      OPScore[0] = OPScore[0] + 1;//opponent score increase by 1
      Pause();
      ax = 200;
      ay = 50;
      rx = 200;
      ry = 650;
      x = 300;
      y = 450;
    }
    textSize(30);
    text(OPScore[0], 10,300);//scoreboard
    text(PlayerScore[0], 10,400);
    
    //movement
  y = y + speedy;
  x = x + speedx;
  
  if(screen == 0){//start screen
    textSize(50);
    text("START", 200, 300);
    textSize(20);
    text("CLICK ANYWHERE TO START", 160, 330);
    speedy = 0;
  }
  else if(screen == 1){//game screen
    game();
    endgame();
    if(twoplayer == false){
      AI();//if not on two player mode than use AI
    }
  }
  else if(screen == 2){//pause screen
    textSize(50);
    text("PAUSED",200,300);
    textSize(20);
    text("SETTINGS" , 230, 340);
    rect(200,320,20,20);
  }
  else if(screen == 3){//settings menu screen
    background(0);
    textSize(50);
    text("SETTINGS",20,50);
    textSize(30);
    text("GAMES CHANGES",20,140);
    textSize(20);
    text("2-PLAYER MODE",45,200);
    text("AI DIFFICULTY INCREASE",45,220);
    rect(50,240,20,20);//easy mode box
    textSize(15);
    text("EASY",50,235);
    rect(120,240,20,20);//medium mode box
    text("MEDIUM",120,235);
    rect(190,240,20,20);//hard mode box
    text("HARD",190,235);
    rect(260,240,20,20);//alien mode box
    text("Alien",260,235);
    textSize(20);
    text("CONTROLS",50,300);
    textSize(15);
    if(ControlScheme == 1){
      text("Player 1: LEFT = LEFT ARROW    RIGHT = RIGHT ARROW",50,330);
    }
    else if(ControlScheme == 2){
      text("Player 1: LEFT = N             RIGHT = M",50,330);
    }
    text("Player 2: LEFT = A             RIGHT = S",50,350);
    textSize(20);
    text("Control Scheme 1",50,380);
    rect(20,360,20,20);
    text("Control Scheme 2",50,405);
    rect(20,385,20,20);
    rect(20,180,20,20);//2 player mode box
    rect(20,420,20,20);//main menu box
    textSize(30);
    text("<-- MAIN MENU",60,440);
  }
}

void game(){//game physics
  for(int i=0; i<1; i++){
    if(y == ry && x >= rx + 38 && x < rx + (38*2)){//if ball hits the middle of the players paddle
      speedy = -speedy;
    }
    else if(y == ry && x >= rx && x < rx + 38){//if the ball hits the left side of the players paddle
      speedy = -speedy;
      speedx = 4;
    }
    else if(y == ry && x >= rx + (38*2) && x < rx +150){//if the ball hits the right side of the players paddle
      speedy = -speedy;
      speedx = -4;
    }
    else if(y == ay && x >= ax + 38 && x < ax +(38*2)){//if the ball hits the middle of the AI's paddle
      speedy = -speedy;
    }
    else if(y == ay && x >= ax && x < ax + 38){//if the ball hits the left side of the AI's paddle
      speedy = -speedy;
      speedx = 4;
    }
    else if(y == ay && x >= ax + (38*2) && x < ax +150){//if the balls hits the right side of the AI's paddle
      speedy = -speedy;
      speedx = -4;
    }
    else if(x < 10 || x > 590){//if the ball hits the outer walls on the left or right side
      speedx = -speedx;
    }
  }
}

void AI(){//code for AI
/*The code is basically saying that the harder difficulties
make it so it's less of a chance that the AI will miss the ball
easier difficulties have a higher chance of missing the ball
*/
if(difficulty == "EASY"){//easy difficulty AI
  if(random(floor(7)) > 6){
    if(random(floor(7)) > 8){
      ax = x + 40;
    }
    else if(random(floor(7)) <= 8){
      ax = x - 40;
    }
  }
   else if(random(floor(7)) <= 6){
    ax = x + 100;//miss the ball
  }
}
else if(difficulty == "MEDIUM"){//medium difficulty AI
  if(random(floor(7)) > 4){
    if(random(floor(7)) > 7){
      ax = x + 50;
    }
    else if(random(floor(7)) <= 7){
      ax = x - 50;
    }
    }
    else if(random(floor(7)) <= 4){
      ax = x + 100;
  }
}
else if(difficulty == "HARD"){//hard difficulty AI
  if(random(floor(7)) > 2){
    if(random(floor(7)) > 6){
      ax = x + 30;
    }
    else if(random(floor(7)) <= 6){
      ax = x - 30;
    }
  }
  else if(random(floor(7)) <= 2){
      ax = x + 100;
    }
}
else if(difficulty == "Alien"){//Alien difficulty AI
  if(random(floor(7)) >= 1/2){
    if(random(floor(7)) > 6){
      ax = x + 40;
    }
    else if(random(floor(7)) <= 6){
      ax = x - 40;
    }
  }
  else if(random(floor(7)) < 1/2){
    ax = x + 100;
  }
}
}
void reset(){//function to start a new game
  OPScore[0] = 0;
  PlayerScore[0] = 0;
  x = 300;
  y = 350;
  speedy = 0;
  speedx = 0;
  screen = 0;
}
void endgame(){//function for the end of the game
if(twoplayer == false){
  if(PlayerScore[0] == 6){//if player wins
    textSize(30);
    text("YOU WIN!",100,100);
    text("Try a Harder Difficulty Next Time",50,160);
    Pause();
  }
  else if(OPScore[0] == 6){//if computer wins
    textSize(30);
    text("GAME OVER",100,100);
    text("YOU LOSE, TRY AGAIN!", 50,200);
    pause();
  }
}
else if(twoplayer == true){//if player 1 wins
  if(PlayerScore[0] ==6){
    textSize(30);
    text("PLAYER 1 WINS!!",50,100);
    pause();
  }
  else if(OPScore[0] == 6){//if player 2 wins
    textSize(30);
    text("PLAYER 2 WINS!!",50,200);
    pause();
  }
}
}
void Pause(){
  speedx = 0;
  speedy = 0;
}
void keyPressed(){
  if(ControlScheme == 1){
    if(keyCode == LEFT){
      rx = rx - 40;
    }
    else if(keyCode == RIGHT){
      rx = rx + 40;
    }
    if(keyCode == SHIFT){//resets the game
      reset();
    }
    else if(keyCode == ENTER){//pauses the game
      Pause();
      screen = 2;
    }
    else if(keyCode == TAB){//resumes the game
      if(speedx == 0 && speedy == 0){//if its paused
        speedy = 10;
        screen = 1;
      }
    }
  }
  else if(ControlScheme == 2){
    if(key == 'c'){
      reset();
    }
    else if(key == 'z'){
      Pause();
      screen = 2;
    }
    else if(key == 'x'){
      if(speedx == 0 && speedy == 0){//if its paused
        speedy = 10;
        screen = 1;
      }
    }
    else if(key == 'n'){
      rx = rx - 40;
    }
    else if(key == 'm'){
      rx = rx + 40;
    }
  }
  if(twoplayer == true){//if on two player mode
    if(key == 'a'){//player2 move left
      ax = ax - 50;
    }
    else if(key == 's'){//player2 move right
      ax = ax + 50;
    }
  }
  else if(keyCode == DELETE){
    exit();
  }
}

void mousePressed(){
  if (screen == 0){//starts the game from the homescreen
    if(mouseX > 0 && mouseX < 600 && mouseY > 0 && mouseY < 700){//if mouse is pressed, start game
      screen = 1;
      OPScore[0] = 0;//starting score is 0
      PlayerScore[0] = 0;
      speedy = 10;
    }
  }
  else if(screen == 1){//if on screen 1 and the game is paused after a goal
    if(mouseX > 0 && mouseX < 600 && mouseY > 0 && mouseY < 700){
      game();
      speedy = 10;
    }
  }
  else if(screen == 2){//go to settings screen
    if(mouseX > 200 && mouseX < 220 && mouseY > 320 && mouseY < 340){
      screen = 3;
    }
  }
  else if(screen == 3){//settings screen
    if(mouseX > 20 && mouseX < 40 && mouseY > 180 && mouseY < 200){
      if(twoplayer == false){//if in single player mode
        twoplayer = true;
        screen = 0;
      }
      else if(twoplayer == true){//if in two player mode
        twoplayer = false;
        screen = 0;
      }
    }
    //difficulty change buttons
    if(mouseX > 50 && mouseX < 70 && mouseY > 240 && mouseY < 260){
        difficulty = "EASY";
        screen = 0;
      }
      else if(mouseX > 120 && mouseX < 140 && mouseY > 240 && mouseY < 260){
        difficulty = "MEDIUM";
        screen = 0;
      }
      else if(mouseX > 190 && mouseX < 210 && mouseY > 240 && mouseY < 260){
        difficulty = "HARD";
        screen = 0;
      }
      else if(mouseX > 260 && mouseX < 280 && mouseY > 240 && mouseY < 260){
        difficulty = "Alien";
        screen = 0;
      }
      //main menu button
      else if(mouseX > 20 && mouseX < 40 && mouseY > 420 && mouseY < 440){
        screen = 2;
      }
      else if(mouseX > 20 && mouseX < 40 && mouseY > 360 && mouseY < 380) ControlScheme = 1;
      else if(mouseX > 20 && mouseX < 40 && mouseY > 385 && mouseY < 405) ControlScheme = 2;
  } 
}
