class Enemy
{
  int currentFrame = 0;
  PImage[] bossSprite = new PImage[10];
  float spriteTimer = 0;

  PVector bossPos = new PVector();
  PVector bossVel = new PVector();
  int bossSize = 200;
  boolean isCharging = false;
  boolean isLaunching = false;
  boolean missileLaunch = false;

  Missiles missile = null;

  float timer;
  float timerLaunch;
  float chargeInterval = 3;
  float launchInterval = 3;

  public Enemy()
  {
  	    for(int i = 0 ; i < bossSprite.length ; i++)
    {
    	bossSprite[i] = loadImage("sprite_boss" + (i +1) + ".png");
    }

    bossPos.x = width/2 + 500;
    bossPos.y = height/2;

    bossVel.x = -5;
    bossVel.y = 1;
    ellipseMode(CENTER);
  }

  void update()
  {
    //Boss only go up and down in Y position when the boss it on this sorten position
    if (bossPos.y <=  width/2 + 500)
    {
      bossPos.y += bossVel.y;
    }

    //Wall Collisions Y position
    if (bossPos.y >= height - bossSize / 2 || bossPos.y <= 0 + bossSize / 2)
    {
      bossVel.y *= -1;
    }

    //Checking if its time to charge
    if (timer >= chargeInterval)
    {
      isCharging=true;
      timer = 0;
    }
    if (isCharging==true)
    {
      charge();
    }

    if (timerLaunch >= launchInterval)
    {
      if (isCharging==false)
      {
        missile = new Missiles();
        missileLaunch = true;
        timerLaunch = 0;
      }
    }


    timerLaunch += deltaTime;
    timer += deltaTime;
  }

  void draw()
  {

    if (missile != null)
    {
      missile.draw();
    }

    bossGraphic();
  }

  void bossGraphic()
  {
/*    fill(255, 0, 0);
    ellipse(bossPos.x, bossPos.y, bossSize, bossSize);*/
    if(spriteTimer > 0.1)
    {
    	currentFrame++;
    	spriteTimer = 0;
    }

    image(bossSprite[currentFrame % bossSprite.length], bossPos.x, bossPos.y);

    spriteTimer += deltaTime;
  }

  //The boss charges forward in X position in a interval of 5-15 seconds. 
  void charge()
  {
    bossPos.y -= bossVel.y;
    bossPos.x += bossVel.x;

    //wall Colision X 
    if (bossPos.x <= 0)
    {
      bossVel.x *= -1;
    }

    //Boss return to its start position
    if (bossPos.x > width/2 + 500)
    {
      bossPos.x = width/2 + 500;
      chargeInterval = random(10, 15);

      isCharging = false;
      bossVel.x *= -1;
    }
  }
}
