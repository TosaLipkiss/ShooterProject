void victory()
{
  enemy.bossSize = 0;

  if (timerStopped == false) 
  {
    endTime = (millis() - startTime) * 0.001f;
  }

  timerStopped = true;

  fill (0, 255, 0);
  textSize(64);
  textAlign(CENTER, CENTER);
  text("VICTORY - BOSS DEFEATED\nTOTAL TIME: " + endTime, width / 2, height / 2);
}
