void reset(){                                                                                    // Setting all values back to their initial values
  gameMode = 0;
  cash = 0;
  lives = 3;
  bullets = 3;
  score = 0;
  level = 1;
  
  player = new int[] {50, 700, 20, 40}; 
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
}
