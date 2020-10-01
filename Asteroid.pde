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
    asterPos = new PVector(width + random(10, 695), random(25, 695));
    asterVel.x = random(-6, -4);
    asterVel.y = 0;
  }

  void update()
  {
    asterPos.x += asterVel.x;
    asteroidGrahpic();
  }

  void asteroidGrahpic()
  {
    fill(0, 100, 100);
    ellipse(asterPos.x, asterPos.y, asterSize, asterSize);
    ellipseMode(CENTER);
  }
}
