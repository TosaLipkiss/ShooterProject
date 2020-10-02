class Missiles
{
  float missileSize=50;
  PVector currentLocation;
  PVector targetLocation;

  PImage missileSprite;

  PVector currentDirection;

  float speed=0.0;
  float maxSpeed=600.0;
  float acceleration = 300.0;

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
  	missileSprite = loadImage("sprite_missile_55x55.png");

    if (upOrDown < 0.5)
    {
      currentAngle = random(110, 140);
    } else
    {
      currentAngle = random(220, 250);
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

  void draw() 
  {
    elapsedTime = millis();
    deltaTime = (elapsedTime - time) * 0.001f;

    launchMissiles();
    missileGraphic();

    time = elapsedTime;
  }

  /////////METHODS///////////////
  void missileGraphic()
  {
    noStroke();
    fill(255, 0, 0);
    ellipse(currentLocation.x, currentLocation.y, missileSize, missileSize);
    image(missileSprite, currentLocation.x, currentLocation.y);
  }


  ///The Missile funtion for physics
  void launchMissiles()
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
        currentAngle = lerp(currentAngle, currentAngle + angleToTarget, 0.01);
      } 
      //turn down
      else
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
      //println("break direction");
    }
  }
}
