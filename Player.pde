class Player
{
  float acceleration = 2500;
  float friction = 10;
  float maxVelocity = 1500;
  PVector velocityVector;
  PVector playerPosition;
  int playerWidth = 35;
  int playerHeight = 70;


  Player()
  {
    playerPosition = new PVector(0 + playerWidth / 2, height / 2);
    velocityVector = new PVector(0, 0);
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
    ellipse(playerPosition.x, playerPosition.y, playerWidth, playerHeight);
  }


  void playerCollision()
  {
    if (playerPosition.y + playerHeight / 2 > height || playerPosition.y - playerHeight / 2 < 0)
    {
      velocityVector.y *= -1; //If the ball touches the end of the screen in y led will bounce back in the other direction
    }
  }
}