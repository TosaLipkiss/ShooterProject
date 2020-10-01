float deltaTime;
float time;
Player player1;
Bullet[] bullets;
Asteroid[] asteroids;
Enemy enemy;
Healthmanager healthmanager;
boolean launchCollision = false;
boolean gameover = false;

void setup()
{
  frameRate(144);
  size(1280, 720);

  healthmanager = new Healthmanager();
  bullets = new Bullet[10];
  asteroids = new Asteroid[100];
  player1 = new Player();
  enemy = new Enemy();
}

void draw()
{
  background(0, 0, 0);

  long elapsedTime = millis();
  deltaTime = (elapsedTime - time) * 0.001f;

  player1.move();
  player1.display();

  enemy.draw();
  enemy.update();

  healthmanager.draw();

  //collision between player and missile
	missileCollision();

  for (int i = 0; i < asteroids.length; i++)
  {
    if (asteroids[i] == null)
    {
      //No Asteroid, skip to the next one.
      continue;
    }
    else
    {
      //found an Asteroid, update it.
      asteroids[i] = new Asteroid();
      asteroids[i].update();
    }
  }

  //Update bullets
  for (int i = 0; i < bullets.length; i++)
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
      healthmanager.bossHealthBarWidthDamage -= 20;
      bullets[i] = null;
    }
    else if (bullets[i].bulletPosX >= width) 
    {
      bullets[i] = null;  
    }
  }


  if (roundCollision(player1.playerPosition.x, player1.playerPosition.y, player1.playerWidth / 2, enemy.bossPos.x, enemy.bossPos.y, enemy.bossSize / 2)) 
  {
    gameover();
  }


  if (healthmanager.bossHealthBarWidthDamage <= 0) 
  {
    victory();
  }
  

  if (healthmanager.playerHealthBarWidthDamage <= 0)
  {
    gameover();
  }
  time = elapsedTime;
}

////////METHODS///
void gameover()
{
  player1.playerWidth = 0;
  player1.playerHeight = 0;
  healthmanager.playerHealthBarWidthDamage = 0;
  fill (0, 255, 0);
  textSize(64);
  textAlign(CENTER, CENTER);
  text("GAME OVER", width/2, height/2);
}

void victory()
{
  enemy.bossSize = 0;
  fill (0, 255, 0);
  textSize(64);
  textAlign(CENTER, CENTER);
  text("VICTORY - BOSS DEFEATED", width/2, height/2);
}

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
