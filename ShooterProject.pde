float deltaTime;
float time;
Player player1;
Bullet[] bullets;
Asteroid asteroids;
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
  asteroids = new Asteroid();
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

  asteroids.update();

  //collision between player and missile
  if(enemy.missile != null)
  {
  		float missileRadius = enemy.missile.missileSize / 2;
  		float playerRadius = player1.playerWidth / 2;
  	  	PVector missileLocation = enemy.missile.currentLocation;
  	  	PVector playerLocation = player1.playerPosition;

  	  	float a = abs(missileLocation.x - playerLocation.x);
  	  	float b = abs(missileLocation.y - playerLocation.y);
  	  	//hypotenusan
  	  	float c = sqrt((a * a) + (b * b));

  	  	float distance = c - missileRadius - playerRadius;

  	  	if(distance < 0)
  	  	{
  	  		enemy.missile = null;
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
    // gameover = true;
      healthmanager.bossHealthBarWidthDamage -= 20;
      bullets[i] = null;
      // bullets[i].bulletWidth = 0;
      // bullets[i].bulletHeight = 0;
    }
  }
  if (healthmanager.bossHealthBarWidthDamage == 0) 
  {
    victory();
  }
  time = elapsedTime;
}
  
void gameover()
{
  fill (0, 255, 0);
  textSize(64);
  textAlign(CENTER, CENTER);
  text("GAME OVER", width/2, height/2);
}

void victory()
{
  fill (0, 255, 0);
  textSize(64);
  textAlign(CENTER, CENTER);
  text("VICTORY - BOSS DEFEATED", width/2, height/2);
}
