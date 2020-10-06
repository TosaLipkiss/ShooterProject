void updateBullets()
{
  //Update bullets
  for (int i = 0 ; i < bullets.length ; i++)
  {
    if (bullets[i] == null)
    {
      //No bullet, skip to the next one.
      continue;
    } 
    else
    {
      //found a bullet, update it.
      bullets[i].move();
      bullets[i].draw();
    }
    if (roundCollision(bullets[i].bulletPosX, bullets[i].bulletPosY, bullets[i].bulletWidth / 2, enemy.bossPos.x, enemy.bossPos.y, enemy.bossSize / 2))
    {
      healthmanager.bossHealthBarWidthDamage -= 5;
      bullets[i] = null;
    } 
    else if (bullets[i].bulletPosX >= width)
    {
      bullets[i] = null;
    }
  }
}
