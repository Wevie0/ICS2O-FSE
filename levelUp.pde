void levelUp() {                                                                                // Clears and resets everything
  player = new int[] {50, 700, 30, 50}; 
  velocity = new int[] {0, 0, 800};  
  offset = 0;
  canJump = true;

  score += 20;

  coinX.clear();
  coinY.clear();
  heartX.clear();
  heartY.clear();
  bulletX.clear();
  bulletY.clear();

  playerBulletX.clear();
  playerBulletY.clear();
  bulletDirection.clear();

  enemyX.clear();
  enemyY.clear();
  enemyDirection.clear();
  enemyHP.clear();
  platforms.clear();

  if (level == 2) {                                                                              // Depending on the level, re-adds platforms and objects
    platX = new int[] {000, 500, 200, 400, 700, 1700, 2000, 2300, 2100, 2400}; 
    platY = new int[] {700, 500, 400, 250, 100, 750, 600, 425, 250, 100};    
    platW = new int[] {200, 100, 100, 200, 100, 100, 200, 200, 100, 500};     
    coinX.append (new int[] {100, 540, 2040, 2140, 2340, 2140, 2440, 2540, 2640, 2740});        
    coinY.append (new int[] {670, 470, 575, 575, 400, 225, 75, 75, 75, 75});
    heartX.append (new int[] {1740 , 240});
    heartY.append (new int[] {725, 375});
    bulletX.append (new int[] {500});
    bulletY.append (new int[] {225});
    enemyX.append (new int[] {450, 2800});
    enemyY.append (new int[] {200, 50});
    for (int i = 0; i < enemyX.size(); i++) {
      enemyHP.append (50);
    }
    enemyDirection.append (new int[]{1 , -1});
    platforms.append (new int[] {3, 9});
  } else if (level == 3) {
    platX = new int[] {000, 300, 1000, 1400, 1800, 2500, 2500, 2500, 3300}; 
    platY = new int[] {700, 500, 300, 500, 650, 500, 300, 100, 350};    
    platW = new int[] {400, 500, 100, 200, 600, 200, 200, 200, 200};     
    coinX.append (new int[] {100, 340, 1040, 1480, 1800, 2580, 2580, 2580, 540, 3330});        
    coinY.append (new int[] {670, 570, 270, 470, 620, 475, 275, 75, 470, 325});
    heartX.append (new int[] {490});
    heartY.append (new int[] {470});
    bulletX.append (new int[] {580});
    bulletY.append (new int[] {470});
    enemyX.append (new int[] {300, 1900});
    enemyY.append (new int[] {450, 600});
    for (int i = 0; i < enemyX.size(); i++) {
      enemyHP.append (50);
    }
    enemyDirection.append (new int[]{1, -1});
    platforms.append (new int[] {1, 4});
  }
}
