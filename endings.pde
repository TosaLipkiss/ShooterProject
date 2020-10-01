void endings()
{
  if (roundCollision(player1.playerPosition.x, player1.playerPosition.y, player1.playerWidth / 2, enemy.bossPos.x, enemy.bossPos.y, enemy.bossSize / 2)) 
  {
    gameOver = true;
  }


  if (healthmanager.bossHealthBarWidthDamage <= 0) 
  {
    win = true;
  }


  if (healthmanager.playerHealthBarWidthDamage <= 0)
  {
    gameOver = true;
  }
}
