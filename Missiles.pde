class Missiles
{
  PVector currentLocation;
  PVector targetLocation;

  PVector currentDirection;

  float speed=0.0;
  float maxSpeed=600.0;
  float acceleration = 300.0;

  float currentAngle=random(90.0, 270.0);

  boolean turnDirection = true;
  boolean seeker=true;

  float time;
  long elapsedTime;
  float deltaTime;

  public Missiles()
  {
   currentLocation = new PVector(enemy.bossPos.x, enemy.bossPos.y);
   targetLocation = new PVector(player1.playerPosition.x, player1.playerPosition.y);

    if (currentAngle <= 180)
    {
      turnDirection = true;
    } 
    else 
    {
      turnDirection = false;
    }

    //println(currentDirection);
  }

  void draw() 
  {
    elapsedTime = millis();
    deltaTime = (elapsedTime - time) * 0.001f;

    currentDirection = new PVector(cos(radians(currentAngle)), -sin(radians(currentAngle)));

    PVector targetDirection = new PVector((targetLocation.x - currentLocation.x), (targetLocation.y - currentLocation.y));
    
    targetDirection.normalize();
    println(targetLocation);

    //calculate the angle between target and current direction, convert radians to degrees.
    float angleToTarget = degrees(PVector.angleBetween(targetDirection, currentDirection));

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
      if (turnDirection == true)
      {
        currentAngle = lerp(currentAngle, currentAngle + angleToTarget, 0.01);
      } else
      {
        currentAngle = lerp(currentAngle, currentAngle - angleToTarget, 0.01);
      }
    }
    //calculate distance between players target position and missiles current position
    float distanceBetween;
    distanceBetween = dist(currentLocation.x, currentLocation.y, targetLocation.x, targetLocation.y);

    //release missile (no longer targeting player)
    if (distanceBetween <= 100)
    {
      seeker = false;
      println("break direction");
    }

    missileGraphic();

/*    stroke(255, 255, 255);
    line(currentLocation.x, currentLocation.y, currentLocation.x+currentDirection.x*20.0, currentLocation.y+currentDirection.y*20.0);
    stroke(255, 255, 255);
    line(currentLocation.x, currentLocation.y, currentLocation.x+targetDirection.x*100.0, currentLocation.y+targetDirection.y*100.0);*/

    time = elapsedTime;
  }

  void missileGraphic()
  {
    noStroke();
    fill(255, 0, 0);
    ellipse(currentLocation.x, currentLocation.y, 50, 50);
  }
/*  void ball2()
  {
    fill(0, 255, 0);
    ellipse(targetLocation.x, targetLocation.y, 10, 10);
  }*/
}
