import ddf.minim.*;
Minim minim;
// CLEAR ARRAYS TO NEXT LEVEL
//https://www.pinterest.ca/pin/817473769834335480/
//https://opengameart.org/content/lpc-skeleton
//https://rmitisaacsoonggds.wordpress.com/2015/05/25/character-sprite-sheet/
// author wulax
// https://www.deviantart.com/asylusgoji91/art/MLSS-Luigi-Sprites-from-LUS-215189143
//https://www.pngitem.com/middle/wThiRh_enter-the-gungeon-sprite-sheet-hd-png-download/
AudioPlayer startMenu;
AudioPlayer shopMenu;
AudioPlayer levelOneMusic;
AudioPlayer levelTwoMusic;
AudioPlayer levelThreeMusic;

int gameMode = 0;       // 0 - Title, 1 - Game, 2 - UNUSED REMOVE, 3 - Options, 4 - Credits
int character = 1;      // Select Character: 0 - Ashley, 1 - Robot, 2 - Robin Hood
int difficulty = 2; // Changes how much damage you do to the enemy, from 1.5x to 0.5x
int level = 1;          // Which level the player is on
int cash = 0;           // How much money the player has
int lives = 3;          // How many lives the player has
int bullets = 3;        // How many bullets the player has

float score = 0;          // Player's current score
int highScore = 0;      // Player's all time top score

boolean robotUnlocked = true;      // "Hidden" character, unlockable when game is beaten
boolean luigiUnlocked = false;      // "Hidden" character, unlockable all coins collected

PFont text;             // Standard Text Font
PImage titleScreen;     // Title Screen Img
PImage menuScreen;      // Menu Screen Img
PImage levelOneBG;      // Background of 1st Level
PImage platform1;       // Platform Image
PImage coinImg;         // Coin Image
PImage hearts;          // Heart Image
PImage bullet;          // Bullet Icon Image
PImage shopImg;         // Shop Screen Image
PImage lock;
PImage door;
PImage enemyImg;
PImage[] rightImages1 = new PImage [7];
PImage[] leftImages1 = new PImage [7];
PImage[] rightImages2 = new PImage [9];
PImage[] leftImages2 =  new PImage [9];
PImage[] rightImages3 = new PImage [8];
PImage[] leftImages3 = new PImage [8];
int idle = 0;
float frame = 0.0;

PImage[] enemyRightImages  = new PImage [9];
PImage[] enemyLeftImages = new PImage [9];
// author wulax
FloatList enemyFrame = new FloatList();

int[] player = {50, 700, 30, 50};   // Player's Position: [0] - X, [1] - Y, [2] - Width, [3] - Height
boolean[] keys = new boolean [255]; // Tells Game which Key is Pressed
int[] velocity = {0, 0, 800};       // Player's Velocity: [0] - Horizontal Velocity, [1] - Vertical Velocity, [2] - "Ground"
boolean canJump = true;             // Allows/Disallows Jumping Depending on Position of Player
int offset = 0;                     // Offset of Screen, for scrolling

IntList coinX = new IntList();      // IntList of all Coin X's
IntList coinY = new IntList();      // IntList of all Coin Y's

IntList heartX = new IntList();
IntList heartY = new IntList();

IntList bulletX = new IntList();
IntList bulletY = new IntList();

IntList playerBulletX = new IntList();
IntList playerBulletY = new IntList();
IntList bulletDirection = new IntList();

IntList enemyX = new IntList();
IntList enemyY = new IntList();
IntList enemyDirection = new IntList();
IntList enemyHP =  new IntList(); // TODO
IntList platforms = new IntList();

boolean doOnce = false;             // Used to prevent mousePressed/Equivalent from repeating

int[] platX = {000, 400, 1100, 1300, 1700, 2100, 2300, 2300, 2100, 2400, 3200};      // All Platform X's
int[] platY = {700, 500, 500, 400, 600, 750, 600, 425, 250, 100, 700 };      // All Platform Y's
int[] platW = {1000, 300, 100, 100, 200, 400, 200, 200, 100, 300, 300 };     // All Platform Width's

void setup() {
  //size (1480, 800);
  size (1200, 700);
  titleScreen = loadImage ("titleScreen.jpg");       // Initalizing all images
  menuScreen = loadImage ("titleBlank.jpg");
  levelOneBG = loadImage ("levelOneBG.png");
  platform1 = loadImage ("platform1.png");
  text = createFont("OldSchoolAdventures.ttf", 32);
  coinImg = loadImage ("coin.png");
  shopImg = loadImage ("shop.png");
  lock = loadImage ("lock.png");
  hearts = loadImage ("heart.png");
  bullet = loadImage ("bullet.png");
  door = loadImage ("door.png");
  textFont (text);
  coinX.append (new int[] {100, 150, 535, 1140, 1340, 1740, 1830, 2390, 2390, 2540});               // Appending multiple values to coin IntList
  coinY.append (new int[] {670, 670, 470, 475, 375, 575, 575, 575, 400, 75});
  heartX.append (new int[] {490, 2140});
  heartY.append (new int[] {470, 225});
  bulletX.append (new int[] {580, 2290});
  bulletY.append (new int[] {470, 725});
  enemyX.append (new int[] {450, 2400});
  enemyY.append (new int[] {450, 550});
  for (int i = 0; i < enemyX.size(); i++) {
    enemyHP.append (50);
  }
  enemyDirection.append (new int[]{1, -1});
  platforms.append (new int[] {1, 6});
  for (int i=0; i<rightImages1.length; i++) {
    rightImages1[i]=loadImage("ashley"+nf(i+7, 2)+".png");
    leftImages1[i]=loadImage("ashley"+nf(i, 2)+".png");
  }
  for (int i = 0; i < rightImages2.length; i++) {
    rightImages2[i] = loadImage ("charTwo" + nf (i, 3) + ".png");
    leftImages2[i] = loadImage ("charTwo" + nf (i + 9, 3) + ".png");
  }
  for (int i = 0; i < rightImages3.length; i++) {
    rightImages3[i] = loadImage ("charThree" + nf (i, 3) + ".png");
    leftImages3[i] = loadImage ("charThree" + nf (i + 8, 3) + ".png");
  }
  for (int i = 0; i < enemyLeftImages.length; i++) {
    enemyLeftImages[i] = loadImage ("tile" + nf(i+9, 3) + ".png"); 
    enemyRightImages[i] = loadImage ("tile" + nf(i+27, 3) + ".png");
  }

  for (int i = 0; i < enemyX.size(); i++) {
    enemyFrame.append(0.0);
  }
  minim = new Minim (this);
  //  startMenu = minim.loadFile("Angel Share Kevin MacLeod.mp3");
  //  shopMenu = minim.loadFile ("Angevin B.mp3");
  //  levelOneMusic = minim.loadFile ("Fantasia Fantasia.mp3");
  //  levelTwoMusic = minim.loadFile ("Captain Scurvy.mp3");
  //  levelThreeMusic= minim.loadFile ("Crusade.mp3");
}

void draw() {
  background (0);                                    // Refreshes Screen
  switch (gameMode) {                                // Changes the Screen depending on  the current gameMode
  case 0:                                            // TITLE SCREEN
    image (titleScreen, 0, 0);                       // Displays background image
    //    startMenu.play();
    textAlign (RIGHT);                               // Displays high score in corner
    fill (255);
    text ("Highscore: " + highScore, 1450, 50);

    if (mousePressed && mouseButton == LEFT) {       // Player clicks on one of the Buttons
      if (mouseIn(100, 400, 330, 90)) {              // GOTO Options Menu
        fill (0, 255, 0);
        rect (100, 400, 330, 90);
        gameMode = 3;
      } else if (mouseIn(575, 400, 330, 90)) {       // GOTO Credits Menu
        fill (0, 255, 0);
        rect (575, 400, 330, 90);
        gameMode = 4;
      } else if (mouseIn(1050, 400, 330, 90)) {      // GOTO Exit Game
        fill (0, 255, 0);
        rect (1050, 400, 330, 90);
        exit();
      } else if (mouseIn(570, 260, 330, 90)) {       // GOTO Play
        fill (0, 255, 0);
        rect (575, 260, 330, 90);
        gameMode = 1;
      }
    }
    break;
  case 1:                                         // Play Game has been selected
    if (keys[80]) {                               // If "P" is pressed, runs shop
      gameMode = 2;
    }
    if (level == 1) {
      levelOne();
    } else if (level == 2) {
      levelTwo();
    } else {
      levelThree();
    }
    for (int i = 0; i < lives; i++) {                // Draws mini hearts in top left corner, indicates lives
      image (hearts, 50 + 30 * i, 50, 25, 25);
    }
    for (int i = 0; i < bullets; i++) {              // Draws mini bullets in top left corner, indicates ammo
      image (bullet, 45 + 30 * i, 75, 25, 50);
    } 
    enemies();
    score+= 0.05;
    text (int(score), 1400, 50);
    if (score > highScore) {
      highScore = int(score);
    }
  case 2: 
    shop();
    break;
  case 3:                                          // Options Menu has been selected
    options();                          
    break;
  case 4:                                          // Credits Menu has been selected
    credits();
    break;
  }
}

void options() {                                   // Gamemode 3
  image (menuScreen, 0, 0);                        // Background Image
  fill (176, 224, 230);                            // Background Box
  strokeWeight (5);
  rect (100, 100, 1280, 600);
  textAlign (LEFT);

  fill (0);                                        // Character Select Menu
  text ("Select Character:", 140, 160);

  text ("Choose Difficulty:", 140, 320);           // Difficulty setting

  fill (0, 255, 0);                                // Draws 3 Boxes in Green (Easy), Yellow (Normal & Default), Hard (Red)
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

  if (difficulty == 1) {                         // Fills the text white depending on which difficulty is selected
    fill (255);
    text ("Easy", 720, 340);
  } else if (difficulty == 2) {
    fill (255);
    text ("Medium", 960, 340);
    ;
  } else {
    fill (255);
    text ("Hard", 1200, 340);
  }
  textAlign (LEFT);

  fill (74, 103, 56);                             // "Ashley" Image
  rect (810, 110, 90, 100);

  fill (255, 182, 193);                           // Robot Knight Image
  rect (940, 110, 90, 100);

  fill (135, 206, 235);
  rect (1070, 110, 90, 100);



  if (mouseIn(810, 110, 90, 100)) {
    if (character != 1) {
      fill (0, 255, 0);
      rect (810, 110, 90, 100);
      if (mousePressed) {
        character = 1;
      }
    } else {
      fill (255, 0, 0);
      rect (810, 110, 90, 100);
    }
  } else if (mouseIn(940, 110, 90, 100)) {
    if (character != 2 && robotUnlocked) {
      fill (0, 255, 0);
      rect (940, 110, 90, 100);
      if (mousePressed) {
        character = 2;
      }
    } else {
      fill (255, 0, 0);
      rect (940, 110, 90, 100);
    }
  } else if (mouseIn(1070, 110, 90, 100)) {
    if (character != 3 && luigiUnlocked) {
      fill (0, 255, 0);
      rect (1070, 110, 90, 100);
      if (mousePressed) {
        character = 3;
      }
    } else {
      fill (255, 0, 0); 
      rect (1070, 110, 90, 100);
    }
  }
  image (rightImages1[0], 835, 130, 40, 60);
  image (rightImages2[0], 965, 130, 40, 60);
  image (rightImages3[0], 1095, 130, 40, 60);
  if (!luigiUnlocked) {
    image (lock, 1090, 135);
  }

  // Back Button
  noFill();
  rect (110, 590, 100, 100);
  fill (0);
  text("Volume:", 140, 500);
  textSize (12);   
  text ("BACK", 135, 640);
  textSize (32);
  strokeWeight (1);

  if (mousePressed && mouseButton == LEFT) {
    if (mouseIn(110, 590, 100, 100)) {            // Clicking back button
      fill (0, 255, 0);
      rect (110, 590, 100, 100);
      gameMode = 0;
    } else if (mouseIn(620, 280, 200, 100)) {     // Clicking Easy
      difficulty = 1;
    } else if (mouseIn(860, 280, 200, 100)) {     // Clicking Normal
      difficulty = 2;
    } else if (mouseIn(1100, 280, 200, 100)) {    // Clicking Hard
      difficulty = 3;
    }
  }
}

void credits() { 
  image (menuScreen, 0, 0);                       // Background Image  
  fill (255, 204, 203);                           // Background Box
  strokeWeight (5);
  rect (100, 100, 1280, 600);

  textAlign (LEFT);                               // Displays Credits
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
  text ("Heart Icon: clipartlibrary.com", 120, 375);

  textSize (12);
  noFill();
  rect (110, 590, 100, 100);
  fill (0);
  text ("BACK", 135, 640);
  textSize (32);

  if (mousePressed && mouseButton == LEFT) {     // Back Button
    if (mouseIn(110, 590, 100, 100)) {
      fill (0, 255, 0);
      rect (110, 590, 100, 100);
      gameMode = 0;
    }
  }
}

void levelOne() {
  int[] lvl1Door = {3400 + offset, 600, 50, 100};
  int[] lvl2Door = {3400 + offset, 600, 50, 100};
  if (level == 1) {
    image (door, lvl1Door[0], lvl1Door[1], lvl1Door[2], lvl1Door[3]);
  } else if (level == 2) {
    image (door, lvl2Door[0], lvl2Door[1], lvl2Door[2], lvl2Door[3]);
  }
  if (hitBox(player, lvl1Door) || hitBox (player, lvl2Door)) {
    level++;
  }
  image (levelOneBG, offset, 0);                // Draws the background, initally at (0,0), but goes back as player progresses
  text ("Press \"P\" to open shop!", 400 +  offset, 400);
  levelUp();
  drawPlatform ();                              
  movePlayer();                                      
  checkHit();
  items();
}
void levelTwo() {
}
void levelThree() {
}



boolean mouseIn(int left, int top, int w, int h) {                                     // Returns true if mouse is in between top left and bottom right of rect
  return (mouseX >= left && mouseX <= left + w && mouseY >= top && mouseY <= top + h);
}



void drawPlatform() {                                                                  // Draws the platforms, draws multiple small platforms in order to avoid streching
  int[] len= new int [platW.length];                                                   // Creates an array the size of # platforms
  for (int i = 0; i < platW.length; i++) {                                             // Assigns each index the total width needed / 100
    len[i] = platW[i]/100;                                                             // This is needed to find # of platforms neccesary
  }
  for (int j = 0; j < len.length; j++) {                                               // The "j" variable is used to determine platform # (which X value, which Y value, etc.)
    for (int i = 0; i < len [j]; i++) {                                                // The "i" variable is used to determine how long the platform needs to be
      image (platform1, platX[j] + (100 * i) + offset, platY[j], 100, 25);             // Draws the image at the first X and first Y pos, then adds 100px each time until the length is satisfied
    }
  }
}

void items() {
  int[] coin = {};                                                                     // New Blank array for storing coin values                                                               
  fill (255, 255, 0);
  for (int i = 0; i < coinX.size(); i++) {                                             // Runs for all X (and therefore Y) values in the list
    image (coinImg, coinX.get(i) + offset, coinY.get (i), 20, 20);                     // Draws an image of coin @ the specified X and Y values
    coin = new int[] {coinX.get(i) + offset, coinY.get(i), 20, 20};                    // Appends the current coinX and coinY values
    if (hitBox(player, coin)) {                                                        // Checks collision between the player and coin, if so removes coin and adds cash
      coinX.remove(i);
      coinY.remove(i);
      cash++;
      score+=5;
    }
  }

  int[] heart = {};
  for (int i=0; i < heartX.size(); i++) {
    image (hearts, heartX.get(i) + offset, heartY.get(i), 20, 20);
    heart = new int[] {heartX.get(i)+ offset, heartY.get(i), 20, 20};
    if (hitBox(player, heart) && lives <= 10) {
      heartX.remove(i);
      heartY.remove(i);
      lives++;
      score += 5;
    }
  }

  int bulletPos[] = {};
  for (int i = 0; i < bulletX.size(); i++) {
    image (bullet, bulletX.get(i) + offset, bulletY.get(i), 20, 20);
    bulletPos =  new int[] {bulletX.get(i) + offset, bulletY.get(i), 20, 20};
    if (hitBox(player, bulletPos) && bullets <= 10) {
      bulletX.remove(i);
      bulletY.remove(i);
      bullets++;
      score += 5;
    }
  }

  fill (255);                                                                          // Shows the current cash in the center top of screen
  textAlign (CENTER);
  textSize (12);
  text ("$" + cash, 740, 50);
  textSize (32);
}
void levelUp() {
}

void movePlayer() {
  if (keys[65] && player[0] > 50) {                                                     // If "A" Button Pressed && player is not at the left edge
    velocity[0] = -5;                                                                   
    offset += 10;                                                                       // Moves the background right
    if (character == 1) {
      image(leftImages1[int(frame)], player[0], player[1], player[2], player[3]);
    } else if (character == 2) {
      image(leftImages2[int(frame)], player[0], player[1], player[2], player[3]);
    } else {
      image(leftImages2[int(frame)], player[0], player[1], player[2], player[3]);
    }
    idle = 0;
  } else if (keys[68] && player[0] < 1250) {                                            // If "D" Button Pressed && player is not at the right edge
    velocity[0] = 5;
    offset -= 10;                                                                       // Moves the background left
    if (character == 1) {
      image(rightImages1[int(frame)], player[0], player[1], player[2], player[3]);
    } else if (character == 2) {
      image(rightImages2[int(frame)], player[0], player[1], player[2], player[3]);
    } else {
      image(rightImages3[int(frame)], player[0], player[1], player[2], player[3]);
    }
    idle = 1;
  } else {                                                                              // Stop if Nothing Pressed
    velocity[0] = 0;
    if (idle == 0) {
      if (character == 1) {
        image (leftImages1[0], player[0], player[1], player[2], player[3]);
      } else if (character == 2) {
        image (leftImages2[0], player[0], player[1], player[2], player[3]);
      } else {
        image (leftImages3[0], player[0], player[1], player[2], player[3]);
      }
    } else {
      if (character == 1) {
        image (rightImages1[0], player[0], player[1], player[2], player[3]);
      } else if (character == 2) {
        image (rightImages2[0], player[0], player[1], player[2], player[3]);
      } else {
        image (rightImages3[0], player[0], player[1], player[2], player[3]);
      }
    }
  }
  if (keys[32] && canJump == true) {                                                    // Spacebar pressed, player on platform
    velocity[1] = -20;                                                                  // Vertical velocity become negative
    canJump = false;                                                                    // Prevents jumping in midair
  }
  player[0] += velocity[0];                                                             // Adds player velocity to X and Y
  player[1] += velocity[1];
  velocity[1]++;                                                                        // Gravity, pulls the player down
  frame += 0.1;
  if (frame > 6 && character == 1) {
    frame  = 1.0;
  } else if (frame > 8 && character == 2) {
    frame  = 1.0;
  } else if (frame > 7 && character == 3) {
    frame  = 1.0;
  }
}

void checkHit() {
  for (int i = 0; i < platX.length; i++) {
    if (player[0] >= platX[i] + offset && player[0] <= platX[i] + platW[i] + offset
      && player[1] <= platY[i]) {                                                       // Player reaches new platform, player is greater than platform start, and less than width, and above platform
      velocity[2] = platY[i];                                                           // Sets "ground" to height of that platform
    } else {
      velocity[2] = 800;
    }
    if (player[0] >= platX[i] + offset && player[0] <= platX[i] + platW[i] + offset
      && player[1] <= platY[i] + 25 && player[1] >= platY[i]) {                         // Player hits bottom of platform
      velocity[1] = 10;                                                                 // Shoots the player down
      player[1] = platY[i] + 25;                                                        // Prevents player from "clipping"
    }
    if (player[1] + player [3] >= velocity[2]) {                                        // Player touches "ground"
      player[1] = velocity[2] - player[3];                                              // Sets player's Y to avoid "clipping"
      velocity[1] = 0;                                                                  // Removes vertical velocity
      canJump = true;                                                                   // Allows player to jump
    }
  }
  if (player[1] + player[3] >= 800) {                                                   // Player falls through world
    die();
  }
}

void die() {
  if (lives > 1) {                                                                      // More lives than one
    offset = 0;                                                                         // Resets image
    player[1] = 600;                                                                    // Resets player co-ordinates & speed
    player[0] = 50 + offset;
    velocity[0] = 0;
    velocity [1] = 10;
    lives--;                                                                            // Lose life
    if (score > 100) {
      score -= 100;
    } else {
      score = 0;
    }
  } else {
    reset();
  }
}

void shop() {
  //  levelOneMusic.pause();
  //  shopMenu.play();

  if (gameMode == 2) {
    strokeWeight (5);
    rect (100, 100, 1280, 600);                                                           // Draws big rectangle on screen
    image (shopImg, 100, 100);


    rect (150, 150, 100, 100);                                                            // Image "Frames" for icons
    rect (150, 450, 100, 100);
    rect (1100, 150, 200, 400);
    rect (600, 550, 200, 100);

    if (mouseIn(150, 150, 100, 100)) {                                                    // MouseIn heart icon
      if (cash >= 5 && lives <= 10) {                                                     // If requirements sasified, fills frame with green
        fill (0, 255, 0);
        rect (150, 150, 100, 100);
        fill (255);
        if (mousePressed && mouseButton == LEFT && doOnce == false) {                     // Adds 1 heart, subtracts 5 cash when clicked
          lives++;
          cash -= 5;
          doOnce = true;
        }
      } else {                                                                            // If requirements NOT satisifed, fills red
        fill (255, 0, 0);
        rect (150, 150, 100, 100);
        fill (255);
      }
    }

    if (mouseIn(150, 450, 100, 100)) {                                                    // MouseIn bullet icon
      if (cash >= 2 && bullets <= 10) {                                                   // If requirements sasified, fills frame with green
        fill (0, 255, 0);
        rect (150, 450, 100, 100);
        fill (255);
        if (mousePressed && mouseButton == LEFT && doOnce == false) {                     // Adds 1 bullet, subtracts 2 cash when clicked
          bullets++;
          cash -= 2;
          doOnce = true;
        }
      } else {                                                                            // If requirements NOT satisifed, fills red
        fill (255, 0, 0);
        rect (150, 450, 100, 100);
        fill (255);
      }
    }
    if (mouseIn(1100, 150, 200, 400)) {                                                   // MouseIn Luigi
      if (cash >= 30 && luigiUnlocked == false) {                                        // If requirements sasified, fills frame with green
        fill (0, 255, 0);
        rect (1100, 150, 200, 400);
        fill (255);
        if (mousePressed && mouseButton == LEFT && doOnce == false) {                     // Unlocks character, subtracts 100 cash when clicked
          luigiUnlocked = true;
          doOnce = true;
          cash -= 30;
        }
      } else {                                                                            // If requirements NOT satisifed, fills red
        fill (255, 0, 0);
        rect (1100, 150, 200, 400);
        fill (255);
      }
    }

    image (hearts, 175, 175, 50, 50);
    image (bullet, 175, 450, 50, 100);
    image (rightImages3[0], 1150, 250, 100, 200);

    fill (0);
    textAlign (LEFT);
    text ("+1 Life", 350, 200);
    text ("$5", 350, 250);

    text ("+1 Bullet", 360, 500);
    text ("$2", 350, 550);

    textAlign (RIGHT);
    text ("Robin Hood Character", 1050, 200);
    text ("$100", 850, 250);

    if (mouseIn(600, 550, 200, 100)) {                                                    // Exits shop menu
      fill (0, 255, 0);
      rect (600, 550, 200, 100);
      if (mousePressed && mouseButton == LEFT) {
        gameMode = 1;
      }
    }

    fill (0);
    textAlign (LEFT);
    text ("EXIT", 635, 615);

    fill (255);
    strokeWeight (1);
  }
}

void enemies() {
  int[] enemyArray;
  for (int i = 0; i < enemyX.size(); i++) {
    // rect (enemyX.get(i) + offset, enemyY.get(i), 30, 50);
    enemyX.add(i, enemyDirection.get(i) * 2);
    enemyArray = new int[] {enemyX.get(i)+ offset, enemyY.get(i), 30, 50}; //20 IS PLACEHOLDER
    if (hitBox(enemyArray, player)) {
      die();
    }
    if (enemyX.get(i) + offset <= platX[platforms.get(i)] + offset || 
      enemyX.get(i) + offset >= (platX[platforms.get(i)] + platW[platforms.get(i)] + offset) - enemyArray[2]) {
      enemyDirection.mult(i, -1);
    }
    fill (0, 255, 0);
    rect (enemyX.get(i) + offset - 10, enemyY.get(i) - 15, enemyHP.get(i), 10);
    fill (255);

    if (enemyDirection.get(i) < 0) {
      image (enemyLeftImages[int(enemyFrame.get(i))], enemyX.get(i) + offset, enemyY.get(i), 30, 50);
    } else {
      image ( enemyRightImages[int(enemyFrame.get(i))], enemyX.get(i) + offset, enemyY.get(i), 30, 50);
    }
    enemyFrame.add(i, 0.1);
    if (enemyFrame.get(i) > 8) {
      enemyFrame.set(i, 1.0);
    }
  }
  for (int i = 0; i < playerBulletX.size(); i++) {
    ellipse (playerBulletX.get(i)+ offset, playerBulletY.get(i), 5, 5);
    if (bulletDirection.get(i) == 1) {
      playerBulletX.add(i, 10);
    } else {
      playerBulletX.add (i, -10);
    }
  }

  for (int i = 0; i <enemyX.size(); i++) {
    for (int j = 0; j < playerBulletX.size(); j++) {
      if (dist(enemyX.get(i), enemyY.get(i), playerBulletX.get(j), playerBulletY.get(j)) <= 40) {
        playerBulletX.remove(j);
        playerBulletY.remove(j);
        bulletDirection.remove(j);
        if (difficulty == 1) {
          enemyX.remove(i);
          enemyY.remove(i);
          enemyDirection.remove(i);
          enemyHP.remove(i);
          platforms.remove(i);
          score += 10;
        } else if (difficulty == 2) {
          enemyHP.sub(i, 25);
        } else {
          enemyHP.sub(i, 17);
        }
      }
    }
    if (enemyHP.get(i) <= 0 && doOnce == false) {
      enemyX.remove(i);
      enemyY.remove(i);
      enemyDirection.remove(i);
      enemyHP.remove(i);
      platforms.remove(i);
      score += 10;
      doOnce = true;
    }
  }
}

void shoot() {
  if (keyPressed && key == ENTER  && bullets > 0) {
    bullets--; 
    if (velocity[0] > 0|| idle == 1) {
      playerBulletX.append (player[0]+ player [2] + 5 - offset);
      playerBulletY.append (player[1] + (player[3] /2));
      bulletDirection.append (1);
    } else {
      playerBulletX.append (player[0] - 5 - offset);
      playerBulletY.append (player[1] + (player[3] /2));
      bulletDirection.append (-1);
    }
  }
}

boolean hitBox(int[] r1, int[] r2) {                                                   // Returns true if collision between 2 rectang;es
  int r1Bot, r1Right;
  int r2Bot, r2Right;
  r1Right=r1[0]+r1[2];
  r1Bot=r1[1]+r1[3];

  r2Right=r2[0]+r2[2];
  r2Bot=r2[1]+r2[3];

  return (r1Right > r2[0] && r1[0] < r2Right && r1Bot > r2[1] && r1[1] < r2Bot);
}

void keyPressed() {
  keys[keyCode] = true;
  if (key == ENTER) {
    shoot();
  }
}

void keyReleased() {
  keys[keyCode] = false;
}

void mouseReleased() {
  doOnce = false;
}

