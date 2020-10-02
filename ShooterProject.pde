float deltaTime;
float time;
float startTime;
float endTime;

Player player1;

PImage splashScreen;

Enemy enemy;
Healthmanager healthmanager;

Bullet[] bullets;
Asteroid[] asteroids;

boolean launchCollision = false;
boolean gameOver = false;
boolean win = false;
boolean timerStopped = false;

boolean isMouseHowering = false;
boolean isStartGame = false;
boolean runMainMenu = true;
color startButtonBackground = color(250, 150, 10);

float rectPosX = width/2;
float rectPosY = height/2;
float rectSizeX = 315.0;
float rectSizeY = 115.0;

void setup()
{
  frameRate(144);
  size(1280, 720);
  imageMode(CENTER);

  splashScreen = loadImage("SplashScreen.png");
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
    image(splashScreen, width / 2, height / 2);
    StartButton();

    if ((mouseY < (height/2 + 150)) && (mouseY > height/2 + 50))
    {
      if ((mouseX < (width/2 + 150)) && (mouseX > width/2 - 150))
      {
      	howerGraphics();
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
    gameover();
  }
  else if (win == true)
  {
    victory();
  }
  else
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
  if (timerStopped == false) 
  {
  endTime = (millis() - startTime) * 0.001f;
  }
  timerStopped = true;
  fill (0, 255, 0);
  textSize(64);
  textAlign(CENTER, CENTER);
  text("VICTORY - BOSS DEFEATED\nTOTAL TIME: " + endTime, width/2, height/2);
}

void StartButton()
{
  noStroke();
  fill(250, 150, 10);
  rectMode(CENTER);
  rect(width/2, height/2 + 100, 300, 100);

  fill(0, 0, 0);
  textSize(42);
  textAlign(CENTER, CENTER);
  text("START", width/2, height/2 + 100);
}

void howerGraphics()
 {
  fill(255, 255, 255, 50);
  rectMode(CENTER);
  rect(width/2, height/2 + 100, 300, 100);  
 }

 void spaceToContinue()
 {
  
 }
