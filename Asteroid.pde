class Asteroid
{
  boolean isAsteroidsRain = false;
  float timer;
  float asteroidsInterval = 3;
  PVector asterPos;
  PVector asterVel = new PVector();
  float asterSize = 25;

  Asteroid()
  {
    asterPos = new PVector(width, random(25, 695));
    asterVel.x = -3;
    asterVel.y = 0;
  }

  void update()
  {
    // if (timer >= asteroidsInterval)
    // {
    //   isAsteroidsRain=true;
    //   timer = 0;
    // }
    // if (isAsteroidsRain==true)
    // {
    //   draw();
    // }
    draw();

    timer += deltaTime;
  }

  void draw()
  {
    asteroidRain();
    asteroidGrahpic();
  }

  void asteroidGrahpic()
  {
    fill(0, 100, 100);
    ellipse(asterPos.x, asterPos.y, asterSize, asterSize);
    ellipseMode(CENTER);
  }

  void asteroidRain()
  {
    asterPos.x += asterVel.x;
  }
}
