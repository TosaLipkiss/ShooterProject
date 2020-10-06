void gameOver()
{
  player1.playerWidth = 0;
  player1.playerHeight = 0;
  healthmanager.playerHealthBarWidthDamage = 0;
  fill (0, 255, 0);
  textSize(64);
  textAlign(CENTER, CENTER);
  text("GAME OVER", width / 2, height / 2);
}
