class Missiles
{
	PVector missilesPos = new PVector();
	PVector missilesVel = new PVector();
	PVector missilesDir = new PVector();

	PVector currentLocation;
	PVector targetLocation;
	PVector playerSeeker = new PVector();

	int missilesSize = 40;
	int numberOfMissiles = 5;
	// int speed = 0.5;
	// float moveTime = 0.0;

	boolean missilesLaunch = false;

	float timer;
	float missilesInterval = 5;

  public Missiles()
  {
  	currentLocation = new PVector(enemy.bossPos.x,enemy.bossPos.y);
	targetLocation = new PVector((player1.playerPosition.x-100), (player1.playerPosition.y));

    missilesPos.x = width / 2 + 500;
    missilesPos.y = height / 2;

    missilesVel.x = -3;
    missilesVel.y = random(-3, 3);

    ellipseMode(CENTER);
  }

	void update()
	{
		playerSeeker = currentLocation.lerp(targetLocation, 0.01);

		if(timer > missilesInterval)
		{
			missilesLaunch = true;
			timer = 0;
		}

		if(missilesLaunch == true)
		{
			//launch();
		}

		timer += deltaTime;
	}

	void draw()
	{
		missilesGraphic();
	}

	  void missilesGraphic()
	  {
	    fill(50, 200, 210);
	    ellipse(playerSeeker.x, playerSeeker.y, missilesSize, missilesSize);
	  }

	  void launch()
	  {
	 //  	moveTime += Time.deltaTime * speed;

	 //  	currentLocation = new PVector(enemy.bossPos.x,enemy.bossPos.y);
		// targetLocation = new PVector((player1.playerPosition.x-100), (player1.playerPosition.y-100));

	 //  	playerSeeker = currentLocation.lerp(targetLocation, moveTime);
	  }
}