class Healthmanager 
{
  float playerHealthBarX;
  float playerHealthBarY;
  float playerHealthBarWidth;
  float playerHealthBarWidthDamage;
  float playerHealthBarHeight;

  float bossHealthbarX;
  float bossHealthBarY;
  float bossHealthBarWidth;
  float bossHealthBarWidthDamage;
  float bossHealthBarHeight;

  color damage;
  color hp;
  
  public Healthmanager()
  {
    //Player healthbar
    playerHealthBarX = 10;
    playerHealthBarY = 10;
    playerHealthBarWidth = 200;
    playerHealthBarWidthDamage = 200;
    playerHealthBarHeight = 10;

    //Boss healthbar
    bossHealthbarX = width - 610;
    bossHealthBarY = 10;
    bossHealthBarWidth = 600;
    bossHealthBarWidthDamage = 600;
    bossHealthBarHeight = 10;

    //Colors
    damage = color(255,0,0);
    hp = color(0,255,0);
  }
  
  void draw()
  {
    if (playerHealthBarWidthDamage < 0)
    {
      playerHealthBarWidthDamage = 0;
    }

    fill(damage);
    rect(playerHealthBarX, playerHealthBarY, playerHealthBarWidth, playerHealthBarHeight);
    fill(hp);
    rect(playerHealthBarX, playerHealthBarY, playerHealthBarWidthDamage, playerHealthBarHeight);

    
    if (bossHealthBarWidthDamage < 0) 
    {
      bossHealthBarWidthDamage = 0;  
    }

    fill(damage);
    rect(bossHealthbarX, bossHealthBarY, bossHealthBarWidth, bossHealthBarHeight);
    fill(hp);
    rect(bossHealthbarX, bossHealthBarY, bossHealthBarWidthDamage, bossHealthBarHeight);
  }
}
