class Enemy
{
  PVector bossPos = new PVector();
  PVector bossVel = new PVector();
  int bossSize = 200;
  boolean isCharging = false;
  boolean isLaunching = false;
  boolean missileLaunch = false;

  PImage bossSprite;

  Missiles missile = null;

  float timer;
  float timerLaunch;
  float chargeInterval = 3;
  float launchInterval = 3;

  public Enemy()
  {
    bossPos.x = width/2 + 500;
    bossPos.y = height/2;

    bossSprite = loadImage("sprite_boss0001.png");

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

    //Checking if its time for a charge
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
    push();
    fill(255, 0, 0);
    // ellipse(bossPos.x, bossPos.y, bossSize, bossSize);
    image(bossSprite, bossPos.x, bossPos.y);
    pop();
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
