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
Player player1;
Enemy enemy;

public void setup()
{
	frameRate(144);
	
  	player1 = new Player();
  	enemy = new Enemy();
}

public void draw()
{
	background(0, 0, 0);
  	long elapsedTime = millis();
  	deltaTime = (elapsedTime - time) * 0.001f;
  	player1.move();
  	player1.display();
  	enemy.draw();
  	enemy.update();
  	time = elapsedTime;
}
class Enemy
{
	PVector bossPos = new PVector();
	PVector bossVel = new PVector();
	int bossSize = 200;


	public Enemy()
	{
		bossPos.x = width/2 + 500;
		bossPos.y = height/2;

		bossVel.x = 0;
		bossVel.y = random(0, 3);

		ellipseMode(CENTER);
	}

	public void update()
	{

		bossPos.x += bossVel.x;
		bossPos.y += bossVel.y;

		if(bossPos.y >= height - bossSize / 2 || bossPos.y <= 0 + bossSize / 2)
		{
			bossVel.y *= -1;
		}
	}

	public void draw()
	{
		bossGraphic();
	}

	public void bossGraphic()
	{
		push();
		fill(255, 0, 0);
		ellipse(bossPos.x, bossPos.y, bossSize, bossSize);
		pop();
	}

	public void charge()
	{
		if (frameCount % 5 == 0)
		{
			bossPos.y -= bossVel.y;
			bossPos.x += bossVel.x;

			if(bossPos.x >= 0)
			{

			}
		}
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
class Player
{
  float acceleration = 2500;
  float friction = 10;
  float maxVelocity = 1500;
  PVector velocityVector;
  PVector ellipsePosition;
  int playerWidth = 35;
  int playerHeight = 70;


  Player()
  {
    ellipsePosition = new PVector(0 + playerWidth / 2, height / 2);
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
    ellipsePosition.x += velocityVector.x * deltaTime;
    ellipsePosition.y += velocityVector.y * deltaTime;

  }


  public void display()
  {
    fill(35, 255, 90);
    ellipse(ellipsePosition.x, ellipsePosition.y, playerWidth, playerHeight);
  }


  public void playerCollision()
  {
    if (ellipsePosition.y + playerHeight / 2 > height || ellipsePosition.y - playerHeight / 2 < 0)
    {
      velocityVector.y *= -1; //If the ball touches the end of the screen in y led will bounce back in the other direction
    }
  }
}
  public void settings() { 	size(1280, 720); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ShooterProject" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
