import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ShooterProject extends PApplet {

float deltaTime;
float time;
float startTime;
float endTime;
Player player1;
Bullet[] bullets;
Asteroid[] asteroids;
Enemy enemy;
Healthmanager healthmanager;
boolean launchCollision = false;
boolean gameOver = false;
boolean win = false;
boolean timerStopped = false;

boolean isMouseHowering = false;
boolean isStartGame = false;
boolean runMainMenu = true;
int startButtonBackground = color(250, 150, 10);

float rectPosX = width/2;
float rectPosY = height/2;
float rectSizeX = 315.0f;
float rectSizeY = 115.0f;

public void setup()
{
  frameRate(144);
  
  startTime = millis();

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

public void draw()
{
  if (runMainMenu == true)
  {
    background(0, 0, 0);
    StartButton();

    if ((mouseY < (height/2 + 50)) && (mouseY > height/2 - 50))
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
public void gameover()
{
  player1.playerWidth = 0;
  player1.playerHeight = 0;
  healthmanager.playerHealthBarWidthDamage = 0;
  fill (0, 255, 0);
  textSize(64);
  textAlign(CENTER, CENTER);
  text("GAME OVER", width/2, height/2);
}

public void victory()
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

public void StartButton()
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

public void howerGraphics()
 {
  fill(255, 255, 255, 50);
  rectMode(CENTER);
  rect(width/2, height/2, 300, 100);  
 }
class Asteroid
{
  boolean isAsteroidsRain = false;
  float timer;
  float asteroidsInterval = 3;
  PVector asterPos;
  PVector asterVel = new PVector();
  float asterSize = 25;

  Asteroid()
  {
    asterPos = new PVector(width + random(10, 695), random(25, 695));
    asterVel.x = random(-6, -4);
    asterVel.y = 0;
  }

  public void update()
  {
    asterPos.x += asterVel.x;
    asteroidGrahpic();
  }

  public void asteroidGrahpic()
  {
    fill(0, 100, 100);
    ellipse(asterPos.x, asterPos.y, asterSize, asterSize);
    ellipseMode(CENTER);
  }
}
class Bullet
{
  float bulletPosX;
  float bulletPosY;
  float speed;
  public int bulletWidth = 16;
  public int bulletHeight = 4;

  Bullet(float x, float y)
  {
    bulletPosX = x;
    bulletPosY = y;
    speed = 8;
  }

  public void draw()
  {
    fill(random(255), random(255), random(255));
    rect(bulletPosX, bulletPosY, bulletWidth, bulletHeight);
  }

  public void move()
  {
    bulletPosX += speed;
  }
}
public boolean roundCollision(float x1, float y1, float size1, float x2, float y2, float size2)
{
  float maxDistance = size1 + size2;

  //first a quick check to see if we are too far away in x or y direction
  //if we are far away we dont collide so just return false and be done.
  if (abs(x1 - x2) > maxDistance || abs(y1 - y2) > maxDistance)
  {
    return false;
  }
  //we then run the slower distance calculation
  //dist uses Pythagoras to get exact distance, if we still are to far away we are not colliding.
  else if (dist(x1, y1, x2, y2) > maxDistance)
  {
    return false;
  }
  //We now know the points are closer then the distance so we are colliding!
  else
  {
    return true;
  }
}
class Enemy
{
  PVector bossPos = new PVector();
  PVector bossVel = new PVector();
  int bossSize = 200;
  boolean isCharging = false;
  boolean isLaunching = false;
  boolean missileLaunch = false;

  Missiles missile = null;

  float timer;
  float timerLaunch;
  float chargeInterval = 3;
  float launchInterval = 3;

  public Enemy()
  {
    bossPos.x = width/2 + 500;
    bossPos.y = height/2;

    bossVel.x = -5;
    bossVel.y = 1;
    ellipseMode(CENTER);
  }

  public void update()
  {
    //Boss only go up and down in Y position when the boss it on this sorten position
    if (bossPos.y <=  width/2 + 500)
    {
      bossPos.y += bossVel.y;
    }

    //Wall Collisions Y position
    if (bossPos.y >= height - bossSize / 2 || bossPos.y <= 0 + bossSize / 2)
    {
      bossVel.y *= -1;
    }

    //Checking if its time for a charge
    if (timer >= chargeInterval)
    {
      isCharging=true;
      timer = 0;
    }
    if (isCharging==true)
    {
      charge();
    }

    if (timerLaunch >= launchInterval)
    {
      if (isCharging==false)
      {
        missile = new Missiles();
        missileLaunch = true;
        timerLaunch = 0;
      }
    }


    timerLaunch += deltaTime;
    timer += deltaTime;
  }

  public void draw()
  {

    if (missile != null)
    {
      missile.draw();
    }

    bossGraphic();
  }

  public void bossGraphic()
  {
    push();
    fill(255, 0, 0);
    ellipse(bossPos.x, bossPos.y, bossSize, bossSize);
    pop();
  }

  //The boss charges forward in X position in a interval of 5-15 seconds. 
  public void charge()
  {
    bossPos.y -= bossVel.y;
    bossPos.x += bossVel.x;

    //wall Colision X 
    if (bossPos.x <= 0)
    {
      bossVel.x *= -1;
    }

    //Boss return to its start position
    if (bossPos.x > width/2 + 500)
    {
      bossPos.x = width/2 + 500;
      chargeInterval = random(10, 15);

      isCharging = false;
      bossVel.x *= -1;
    }
  }
}
class Healthmanager 
{
  float playerHealthBarX;
  float playerHealthBarY;
  float playerHealthBarWidth;
  float playerHealthBarWidthDamage;
  float playerHealthBarHeight;

  float bossHealthbarX;
  float bossHealthBarY;
  float bossHealthBarWidth;
  float bossHealthBarWidthDamage;
  float bossHealthBarHeight;

  int damage;
  int hp;

  public Healthmanager()
  {
    //Player healthbar
    playerHealthBarX = 10;
    playerHealthBarY = 10;
    playerHealthBarWidth = 200;
    playerHealthBarWidthDamage = 200;
    playerHealthBarHeight = 10;

    //Boss healthbar
    bossHealthbarX = width - 610;
    bossHealthBarY = 10;
    bossHealthBarWidth = 600;
    bossHealthBarWidthDamage = 600;
    bossHealthBarHeight = 10;

    //Colors
    damage = color(255, 0, 0);
    hp = color(0, 255, 0);
  }

  public void draw()
  {
    if (playerHealthBarWidthDamage < 0)
    {
      playerHealthBarWidthDamage = 0;
    }

    fill(damage);
    rectMode(CORNER);
    rect(playerHealthBarX, playerHealthBarY, playerHealthBarWidth, playerHealthBarHeight);
    fill(hp);
    rect(playerHealthBarX, playerHealthBarY, playerHealthBarWidthDamage, playerHealthBarHeight);


    if (bossHealthBarWidthDamage < 0) 
    {
      bossHealthBarWidthDamage = 0;
    }

    fill(damage);
    rectMode(CORNER);
    rect(bossHealthbarX, bossHealthBarY, bossHealthBarWidth, bossHealthBarHeight);
    fill(hp);
    rect(bossHealthbarX, bossHealthBarY, bossHealthBarWidthDamage, bossHealthBarHeight);
  }
}
boolean moveUp;
boolean moveDown;

//Key pressed, set our variables to true
public void keyPressed()
{
  if (keyCode == UP || key == 'a')
    moveUp = true;
  else if (keyCode == DOWN || key == 'd')
    moveDown = true;
  //Spawn new bullet it we press "space-bar"
  if (key == 32) 
  {
    //Find empty spot in array, create list.
    for (int i = 0; i < bullets.length; i++) 
    {
      if (bullets[i] == null) 
      {
        bullets[i] = new Bullet(player1.playerPosition.x, player1.playerPosition.y);
        //we are done, break/quit the loop.
        break;
      }
    }
  }
}

//When a key is released, we will set our variable to false
public void keyReleased()
{
  if (keyCode == UP || key == 'a')
    moveUp = false;
  else if (keyCode == DOWN || key == 'd')
    moveDown = false;
}

public PVector input()
{
  PVector input = new PVector();

  if (moveUp)    
    input.y += -1;

  if (moveDown)  
    input.y +=  1;

  input.normalize();
  return input;
}
class Missiles
{
  float missileSize=50;
  PVector currentLocation;
  PVector targetLocation;

  PVector currentDirection;

  float speed=0.0f;
  float maxSpeed=600.0f;
  float acceleration = 300.0f;

  //Random angle which direction the missile should launch
  float currentAngle;
  float upOrDown = random(0, 1);

  boolean turnDirection = true;
  boolean seeker = true;

  float time;
  long elapsedTime;
  float deltaTime;

  public Missiles()
  {

    if (upOrDown < 0.5f)
    {
      currentAngle = random(90.0f, 135.0f);
    } else
    {
      currentAngle = random(225.0f, 270);
    }
    //start and the current position of missile all the way to target
    currentLocation = new PVector(enemy.bossPos.x, enemy.bossPos.y);
    //aim location, (missiles final destination)
    targetLocation = new PVector(player1.playerPosition.x, player1.playerPosition.y);

    //If the current angle is more than 180 degrees, turn (if true the missile goes up)
    if (currentAngle <= 180)
    {
      turnDirection = true;
    } 
    //if false, the degrees is less than 180 degrees, turn down
    else 
    {
      turnDirection = false;
    }
  }

  public void draw() 
  {
    elapsedTime = millis();
    deltaTime = (elapsedTime - time) * 0.001f;

    launchMissiles();
    missileGraphic();

    time = elapsedTime;
  }

  /////////METHODS///////////////
  public void missileGraphic()
  {
    noStroke();
    fill(255, 0, 0);
    ellipse(currentLocation.x, currentLocation.y, missileSize, missileSize);
  }


  ///The Missile funtion for physics
  public void launchMissiles()
  {
    currentDirection = new PVector(cos(radians(currentAngle)), -sin(radians(currentAngle)));

    //calculate distance between target and current location
    PVector targetDirection = new PVector((targetLocation.x - currentLocation.x), (targetLocation.y - currentLocation.y));
    targetDirection.normalize();

    //calculate the degreeangle between target and current direction, convert radians to degrees.
    float angleToTarget = degrees(PVector.angleBetween(targetDirection, currentDirection));

    //add speed and accelation due time
    currentLocation.x += currentDirection.x * deltaTime * speed;
    currentLocation.y += currentDirection.y * deltaTime * speed;
    speed += (deltaTime * acceleration);

    if (speed > maxSpeed)
    {
      speed = maxSpeed;
    }

    //check if what direction missiles if turnDirection (radians=180) is true, go up. If missiles radians is not more than 180 go down
    if (seeker == true)
    {
      //Turn up
      if (turnDirection == true)
      {
        currentAngle = lerp(currentAngle, currentAngle + angleToTarget, 0.01f);
      } 
      //turn down
      else
      {
        currentAngle = lerp(currentAngle, currentAngle - angleToTarget, 0.01f);
      }
    }

    //calculate distance between players target position and missiles current position
    float distanceBetween;
    distanceBetween = dist(currentLocation.x, currentLocation.y, targetLocation.x, targetLocation.y);

    //release missile (no longer targeting player)
    if (distanceBetween <= 100)
    {
      seeker = false;
      //println("break direction");
    }
  }
}
class Player
{
  float acceleration = 2500;
  float friction = 20;
  float maxVelocity = 1500;
  PVector velocityVector;
  PVector playerPosition;
  int playerWidth = 40;
  int playerHeight = 40;


  Player()
  {
    playerPosition = new PVector(playerWidth * 2, height / 2);
    velocityVector = new PVector(0, 0);
  }


  public void move()
  {
    playerCollision();

    PVector moveVector = input();
    moveVector.mult(acceleration * deltaTime);

    if (moveVector.mag() == 0)
    {
      moveVector.x = -velocityVector.x * friction * deltaTime;
      moveVector.y = -velocityVector.y * friction * deltaTime;
    }

    velocityVector.x += moveVector.x;
    velocityVector.y += moveVector.y;

    velocityVector.limit(maxVelocity);
    playerPosition.x += velocityVector.x * deltaTime;
    playerPosition.y += velocityVector.y * deltaTime;
  }


  public void display()
  {
    fill(35, 255, 90);
    ellipse(playerPosition.x, playerPosition.y, playerWidth, playerHeight);
  }


  public void playerCollision()
  {
    if (playerPosition.y + playerHeight / 2 > height || playerPosition.y - playerHeight / 2 < 0)
    {
      velocityVector.y *= -1; //If the ball touches the end of the screen in y led will bounce back in the other direction
    }
  }
}
public void asteroidSpawn()
{
  for (int i = 0; i < asteroids.length; i++) 
  {
    asteroids[i].update();
    if (asteroids[i].asterPos.x < 0) 
    {
      asteroids[i] = new Asteroid();
    }
    if (roundCollision(asteroids[i].asterPos.x, asteroids[i].asterPos.y, asteroids[i].asterSize / 2, player1.playerPosition.x, player1.playerPosition.y, player1.playerWidth / 2))
    {
      healthmanager.playerHealthBarWidthDamage -= 20;
      asteroids[i] = new Asteroid();
    }
  }
}
public void endings()
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
public void missileCollision()
{
  if (enemy.missile != null)
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

    if (distance < 0)
    {
      healthmanager.playerHealthBarWidthDamage -= 60;
      enemy.missile = null;
    }
  }
}
public void updateBullets()
{
  //Update bullets
  for (int i = 0; i < bullets.length; i++)
  {
    if (bullets[i] == null)
    {
      //No bullet, skip to the next one.
      continue;
    } else
    {
      //found a bullet, update it.
      bullets[i].move();
      bullets[i].draw();
    }
    if (roundCollision(bullets[i].bulletPosX, bullets[i].bulletPosY, bullets[i].bulletWidth / 2, enemy.bossPos.x, enemy.bossPos.y, enemy.bossSize / 2))
    {
      healthmanager.bossHealthBarWidthDamage -= 5;
      bullets[i] = null;
    } else if (bullets[i].bulletPosX >= width)
    {
      bullets[i] = null;
    }
  }
}
  public void settings() {  size(1280, 720); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ShooterProject" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
