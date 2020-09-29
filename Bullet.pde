class Bullet
{
  float x, y;
  float speed;

  Bullet(float x, float y)
  {
    this.x = x;
    this.y = y;
    speed = 8;
  }
  void draw()
  {
    fill(random(255), random(255), random(255));
    rect(x, y, 16, 4);
  }

  void move()
  {
    x += speed;
  }
}
