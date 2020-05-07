int gameMode = 0; // 0 - Title 1 - Game 2 - Game Menu 3 - Options 4 - Credits
int character = 1;
float difficulty = 1.0;
int level = 1;
int cash = 0;

int score = 0;
int highScore = 0;
int time; // Timer to count score

boolean secretCharacter = false; // "Hidden" character, unlockable when all achivements unlocked

PFont text;
PImage titleScreen;
PImage menuScreen;
PImage levelOneBG;
PImage platform1;

int[] player = {50, 700, 20, 40}; // [0] - X, [1] - Y, [2] - Width, [3] - Height
boolean[] keys = new boolean [128];
int[] velocity = {0, 0}; // [0] - Horizontal Velocity, [1] - Vertical Velocity, [2] - Bottom
boolean canJump = true;

int offset;

int[] platX = {100, 500};
int[] platY = {500, 400};
int[] platW = {1000, 300};

void setup() {
  size (1480, 800);
  titleScreen = loadImage ("titleScreen.jpg");
  menuScreen = loadImage ("titleBlank.jpg");
  levelOneBG = loadImage ("levelOneBG.png");
  platform1 = loadImage ("platform1.png");
  text = createFont("OldSchoolAdventures.ttf", 32);
  textFont (text);
}

void draw() {
  background (0);
  switch (gameMode) {
  case 0: // Title Screen
    image (titleScreen, 0, 0); // Displays background image

    textAlign (RIGHT); // Displays high score in corner
    fill (255);
    text ("Highscore: " + highScore, 1450, 50);

    if (mousePressed && mouseButton == LEFT) {
      if (mouseIn(100, 400, 330, 90)) {         // GOTO Options Menu
        fill (0, 255, 0);
        rect (100, 400, 330, 90);
        gameMode = 3;
      } else if (mouseIn(575, 400, 330, 90)) {  // GOTO Credits Menu
        fill (0, 255, 0);
        rect (575, 400, 330, 90);
        gameMode = 4;
      } else if (mouseIn(1050, 400, 330, 90)) { // GOTO Exit Game
        fill (0, 255, 0);
        rect (1050, 400, 330, 90);
        exit();
      } else if (mouseIn(570, 260, 330, 90)) {  // GOTO Play
        fill (0, 255, 0);
        rect (575, 260, 330, 90);
        gameMode = 1;
      }
    }
    break;
  case 1: // Play Game
    switch (level) {
    case 1:
      levelOne();
      break;
    case 2:
      levelTwo();
      break;
    case 3:
      levelThree();
      break;
    }
    break;
  case 2: // Game Menu
    break;
  case 3: // Options Menu
    options();
    break;
  case 4: // Credits Menu
    credits();
    break;
  }
  println (mouseX, mouseY);
}

void options() { // Gamemode 3
  image (menuScreen, 0, 0); // Background
  fill (176, 224, 230);
  strokeWeight (5);
  rect (100, 100, 1280, 600);
  textAlign (LEFT);

  fill (0); // Character Select Menu
  text ("Select Character:", 140, 160);

  text ("Choose Difficulty:", 140, 320); // Difficulty setting
  fill (0, 255, 0);
  rect (620, 280, 200, 100);
  fill (255, 255, 0);
  rect (860, 280, 200, 100);
  fill (255, 0, 0);
  rect (1100, 280, 200, 100);

  fill (0);
  textAlign (CENTER);
  text ("Easy", 720, 340);
  text ("Medium", 960, 340);
  text ("Hard", 1200, 340);

  if (difficulty == 0.5) {
    fill (255);
    text ("Easy", 720, 340);
  } else if (difficulty == 1) {
    fill (255);
    text ("Medium", 960, 340);
    ;
  } else {
    fill (255);
    text ("Hard", 1200, 340);
  }
  textAlign (LEFT);

  fill (74, 103, 56); // "Ashley" Image
  rect (810, 110, 90, 100);
  // TODO Add

  textSize (12); // Back Button
  noFill();
  rect (110, 590, 100, 100);
  fill (0);
  text ("BACK", 135, 640);
  textSize (32);

  if (mousePressed && mouseButton == LEFT) {
    if (mouseIn(110, 590, 100, 100)) { // Clicking back button
      fill (0, 255, 0);
      rect (110, 590, 100, 100);
      gameMode = 0;
    } else if (mouseIn(620, 280, 200, 100)) {
      fill (0, 255, 0);
      rect (620, 280, 200, 100);
      difficulty = 0.5;
    } else if (mouseIn(860, 280, 200, 100)) {
      fill (0, 255, 0);
      rect (620, 280, 200, 100);
      difficulty = 1;
    } else if (mouseIn(1100, 280, 200, 100)) {
      fill (0, 255, 0);
      rect (620, 280, 200, 100);
      difficulty = 1.5;
    }
  }
}

void credits() { // Gamemode 4
  image (menuScreen, 0, 0);
  fill (255, 204, 203);
  strokeWeight (5);
  rect (100, 100, 1280, 600);

  textAlign (LEFT);
  textSize (14);
  fill (0);

  text ("Programming:  Kevin Liu, Mr. Macanovik, Processing Foundation", 120, 150);
  text ("Game and Level Design:  Kevin Liu", 120, 175);
  text ("Bug Fixing:  Kevin Liu", 120, 200);

  text ("Graphics Assets:", 120, 250);
  text ("Kevin Liu", 120, 275);
  text ("Background Art: Avante.biz", 120, 300);
  text ("Main Menu Buttons: pixelartmaker.com", 120, 325);
  text ("Character Sprite:  Bonsaiheldin @ OpenGameArt.org", 120, 350);

  textSize (12);
  noFill();
  rect (110, 590, 100, 100);
  fill (0);
  text ("BACK", 135, 640);
  textSize (32);

  if (mousePressed && mouseButton == LEFT) {
    if (mouseIn(110, 590, 100, 100)) {
      fill (0, 255, 0);
      rect (110, 590, 100, 100);
      gameMode = 0;
    }
  }
}


void levelOne() {
  offset = 0 - player[0];
  image (levelOneBG, offset, 0); 
  drawPlatform ();
  movePlayer();
}
void levelTwo() {
}
void levelThree() {
}



boolean mouseIn(int left, int top, int w, int h) {
  return (mouseX >= left && mouseX <= left + w && mouseY >= top && mouseY <= top + h);
}

void drawPlatform() { // Draws the platforms, draws multiple small platforms in order to avoid streching
  int[] len= new int [platW.length];                             // Creates an array the size of # platforms
  for (int i = 0; i < platW.length; i++) {                       // Assigns each index the total width needed / 100
    len[i] = platW[i]/100;                                       // This is needed to find # of platforms neccesary
  }
  for (int j = 0; j < len.length; j++) {                         // The "j" variable is used to determine platform # (which X value, which Y value, etc.)
    for (int i = 0; i < len [j]; i++) {                          // The "i" variable is used to determine how long the platform needs to be
      image (platform1, platX[j] + (100 * i) + offset, platY[j], 100, 25);// Draws the image at the first X and first Y pos, then adds 100px each time until the length is satisfied
    }
  }
}

void movePlayer() {

  rect (500, player[1], player[2], player[3]);

  if (keys[65]) {        // "A" Button Pressed
    velocity[0] = -5;
  } else if (keys[68]) { //"D" Button Pressed
    velocity[0] = 5;
  } else {               // Stop if Nothing Pressed
    velocity[0] = 0;
  }

  player[0] += velocity[0];
  
  if (keys[32] && canJump == true) {
    velocity[1] = -20;
    canJump = false;
    if (velocity[0] != 0){
     velocity[0] *= 10; 
     println (velocity[0]);
    }
  }
  player[1] += velocity[1];
  if (player[1] + player [3] >= height) {
    player[1] = height - player[3]; 
    velocity[1] = 0;
    canJump = true;
  }
  velocity[1]++;
}


void keyPressed() {
  keys[keyCode] = true;
}

void keyReleased() {
  keys[keyCode] = false;
}
