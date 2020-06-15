void reset() {                                                                                    // Setting all values back to their initial values
  gameMode = 0;
  cash = 0;
  lives = 3;
  bullets = 3;
  score = 0;
  level = 1;

  levelOneMusic.pause();
  levelTwoMusic.pause();
  levelThreeMusic.pause();

  player = new int[] {50, 700, 30, 50}; 
  velocity = new int[] {0, 0, 800};  
  offset = 0;
  canJump = true;  

  coinX.clear();
  coinY.clear();
  heartX.clear();
  heartY.clear();
  bulletX.clear();
  bulletY.clear();

  coinX.append (new int[] {100, 150, 535, 1140, 1340, 1740, 1830, 2390, 2390, 2540});
  coinY.append (new int[] {670, 670, 470, 475, 375, 575, 575, 575, 400, 75});
  heartX.append (new int[] {490, 2140});
  heartY.append (new int[] {470, 225});
  bulletX.append (new int[] {580, 2290});
  bulletY.append (new int[] {470, 725});

  enemyX.clear();
  enemyY.clear();
  enemyDirection.clear();
  enemyHP.clear();
  platforms.clear();

  enemyX.append (new int[] {450, 2400});
  enemyY.append (new int[] {450, 550});
  for (int i = 0; i < enemyX.size(); i++) {
    enemyHP.append (50);
  }
  enemyDirection.append (new int[]{1, -1});
  platforms.append (new int[] {1, 6});

  platX = new int[]{000, 400, 1100, 1300, 1700, 2100, 2300, 2300, 2100, 2400, 3200};
  platY = new int[] {700, 500, 500, 400, 600, 750, 600, 425, 250, 100, 700 };
  platW = new int[] {1000, 300, 100, 100, 200, 400, 200, 200, 100, 300, 300 };
  }
