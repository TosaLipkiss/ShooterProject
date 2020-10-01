void missileCollision()
{
	  if(enemy.missile != null)
  {
  		float missileRadius = enemy.missile.missileSize / 2;
  		float playerRadius = player1.playerWidth / 2;
  	  	PVector missileLocation = enemy.missile.currentLocation;
  	  	PVector playerLocation = player1.playerPosition;

  	  	//dist()
  	  	float a = abs(missileLocation.x - playerLocation.x);
  	  	float b = abs(missileLocation.y - playerLocation.y);
  	  	//hypotenusan
  	  	float c = sqrt((a * a) + (b * b));

  	  	float distance = c - missileRadius - playerRadius;

  	  	if(distance < 0)
  	  	{
          healthmanager.playerHealthBarWidthDamage -= 60;
  	  		enemy.missile = null;
  	  	}
  }
}