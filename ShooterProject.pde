float deltaTime;
float time;
Player player1;
Bullet[] bullets;
Asteroid[] asteroids;
Enemy enemy;
Healthmanager healthmanager;
boolean launchCollision = false;
boolean gameover = false;

boolean isMouseHowering = false;
boolean isStartGame = false;
boolean runMainMenu = true;

float rectPosX = width/2;
float rectPosY = height/2;
float rectSizeX = 315.0;
float rectSizeY = 115.0;

void setup()
{
  frameRate(144);
  size(1280, 720);

  healthmanager = new Healthmanager();
  bullets = new Bullet[10];
  asteroids = new Asteroid[10];
  player1 = new Player();
  enemy = new Enemy();

  for (int i = 0; i < asteroids.length; i++) 
  {
    asteroids[i] = new Asteroid();
  }
}

void draw()
{
  if (runMainMenu == true)
  {
    background(0, 0, 0);
    StartButton();

    if ((mouseY < (height/2 + 50)) && (mouseY > height/2 - 50))
    {
      if ((mouseX < (width/2 + 150)) && (mouseX > width/2 - 150))
      {
        if (mousePressed)
        {
          println("Start game");
          runMainMenu = false;
        }
      }
    }
  } else 
  {
    background(0, 0, 0);

    long elapsedTime = millis();
    deltaTime = (elapsedTime - time) * 0.001f;

    //spawn asteroids
    asteroidSpawn();

    //draw and update player position
    player1.move();
    player1.display();

    //draw and update enemy (Boss) position
    enemy.draw();
    enemy.update();

    //draw hp bars
    healthmanager.draw();

    //checks collision between player and missile
    missileCollision();

    //spawning & despawning bullets (through collision or leaving the game window)
    updateBullets();

    //end scenarios
    endings();

    time = elapsedTime;
  }
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

void StartButton()
{
  noStroke();
  fill(250, 150, 10);
  rectMode(CENTER);
  rect(width/2, height/2, 300, 100);

  fill(0, 0, 0);
  textSize(42);
  textAlign(CENTER, CENTER);
  text("START", width/2, height/2);
}
