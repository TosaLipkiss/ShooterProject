class Player
{
  float acceleration = 2500;
  float friction = 20;
  float maxVelocity = 1500;
  PVector velocityVector;
  PVector playerPosition;
  int playerWidth = 40;
  int playerHeight = 40;
  PImage spaceSquirrel;
  

  Player()
  {
    playerPosition = new PVector(playerWidth * 2, height / 2);
    velocityVector = new PVector(0, 0);
    spaceSquirrel = loadImage("sprite_player_80x80.png");  
  }

  void move()
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


  void display()
  {
    fill(35, 255, 90);
    // ellipse(playerPosition.x, playerPosition.y, playerWidth, playerHeight);
    image(spaceSquirrel, playerPosition.x, playerPosition.y);
  }


  void playerCollision()
  {
    if (playerPosition.y + playerHeight / 2 > height || playerPosition.y - playerHeight / 2 < 0)
    {
      //If the player touches the end of the screen in y led will bounce back in the other direction.
      velocityVector.y *= -1; 
    }
  }
}
