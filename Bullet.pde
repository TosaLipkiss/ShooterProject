class Bullet
{
  float bulletPosX;
  float bulletPosY;
  float speed;
  int bulletWidth = 16;
  int bulletHeight = 4;

  Bullet(float x, float y)
  {
    bulletPosX = x;
    bulletPosY = y;
    speed = 8;
  }

  void draw()
  {
    fill(random(255), random(255), random(255));
    rect(bulletPosX, bulletPosY, bulletWidth, bulletHeight);
  }

  void move()
  {
    bulletPosX += speed;
  }
}
