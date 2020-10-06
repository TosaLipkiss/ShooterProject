void asteroidSpawn()
{
  for (int i = 0 ; i < asteroids.length ; i++) 
  {
    asteroids[i].update();
    if (asteroids[i].asterPos.x < 0) 
    {
      asteroids[i] = new Asteroid();
    }
    if (roundCollision(asteroids[i].asterPos.x, asteroids[i].asterPos.y, asteroids[i].asterSize / 2, player1.playerPosition.x, player1.playerPosition.y, player1.playerWidth / 2))
    {
      healthmanager.playerHealthBarWidthDamage -= 20;
      spawnAsteroidExplosion(asteroids[i].asterPos);
      asteroids[i] = new Asteroid();
    }
  }
}
