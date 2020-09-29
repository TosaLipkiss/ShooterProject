float deltaTime;
float time;
Player player1;
Bullet[] bullets;
Enemy enemy;
boolean launchCollision = false;

void setup()
{
  frameRate(144);
  size(1280, 720);

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
  }
  time = elapsedTime;
}
