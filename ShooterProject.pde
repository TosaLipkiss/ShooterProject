float deltaTime;
float time;
float startTime;
float endTime;

Player player1;

PImage splashScreen;
PImage gameBackground;

Enemy enemy;
Healthmanager healthmanager;

Bullet[] bullets;
Asteroid[] asteroids;
AsteroidExplosion asteroidExplosion = null;
MissileExplosion missileExplosion = null;

boolean launchCollision = false;
boolean gameOver = false;
boolean win = false;
boolean timerStopped = false;

boolean isStartGame = false;
boolean runMainMenu = true;
color startButtonBackground = color(250, 150, 10);

float rectPosX = width / 2;
float rectPosY = height / 2;
float rectSizeX = 315.0;
float rectSizeY = 115.0;

void setup()
{
  frameRate(144);
  size(1280, 720);
  imageMode(CENTER);

  splashScreen = loadImage("SplashScreen.png");
  gameBackground = loadImage("Background.png");
  start();
}

void start()
{
  startTime = millis();
  healthmanager = new Healthmanager();
  bullets = new Bullet[10];
  asteroids = new Asteroid[10];
  player1 = new Player();
  enemy = new Enemy();

  win = false;
  gameOver = false;
  runMainMenu = true;

  for (int i = 0 ; i < asteroids.length ; i++) 
  {
    asteroids[i] = new Asteroid();
  }
}

void draw()
{
  if (runMainMenu == true)
  {
    background(0, 0, 0);
    image(splashScreen, width / 2, height / 2);
    startButton();

    if ((mouseY < (height / 2 + 150)) && (mouseY > height / 2 + 50))
    {
      if ((mouseX < (width / 2 + 150)) && (mouseX > width / 2 - 150))
      {
        hoverGraphics();
        startButtonBackground = color(255, 250, 50);
        if (mousePressed)
        {
          println("Start game");
          runMainMenu = false;
        }
      }
      startButtonBackground = color(250, 150, 10);
    }
  } 
  else if (gameOver == true)
  {
    gameOver();
  } 
  else if (win == true)
  {
    victory();
  }
   else
  {
    image(gameBackground, width / 2, height / 2);

    long elapsedTime = millis();
    deltaTime = (elapsedTime - time) * 0.001f;

    asteroidSpawn();

    //draw and update player position
    player1.move();
    player1.display();

    //draw and update enemy (Boss) position
    enemy.draw();
    enemy.update();

    if (asteroidExplosion != null)
    {
      asteroidExplosion.draw();
    }

    if (missileExplosion != null)
    {
      missileExplosion.draw();
    }

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

void spawnAsteroidExplosion(PVector position)
{
  asteroidExplosion = new AsteroidExplosion(position);
}
void spawnMissileExplosion(PVector position)
{
  missileExplosion = new MissileExplosion(position);
}
