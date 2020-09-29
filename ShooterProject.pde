float deltaTime;
float time;
Player player1;
Bullet[] bullets;
Enemy enemy;
Healthmanager healthmanager;
boolean launchCollision = false;
boolean gameover = false;

void setup()
{
  frameRate(144);
  size(1280, 720);

  healthmanager = new Healthmanager();
  bullets = new Bullet[10];
  player1 = new Player();
  enemy = new Enemy();
}

void draw()
{
  background(0, 0, 0);

  long elapsedTime = millis();
  deltaTime = (elapsedTime - time) * 0.001f;

  player1.move();
  player1.display();

  enemy.draw();
  enemy.update();

  healthmanager.draw();

  //Update bullets
  for (int i = 0; i < bullets.length; i++)
  {
    if (bullets[i] == null)
    {
      //No bullet, skip to the next one.
      continue;
    } else
    {
      //found a bullet, update it.
      bullets[i].move();
      bullets[i].draw();
    }
    if (roundCollision(bullets[i].bulletPosX, bullets[i].bulletPosY, bullets[i].bulletWidth / 2, enemy.bossPos.x, enemy.bossPos.y, enemy.bossSize / 2))
    {
    // gameover = true;

    }
  }
  
  // if (gameover)
  // {
  //   fill (0, 255, 0);
  //   textSize(64);
  //   textAlign(CENTER, CENTER);
  //   text("GAME OVER", width/2, height/2);
  // }
  time = elapsedTime;
}

void mousePressed()
{
  healthmanager.value = random( healthmanager.max );
}
