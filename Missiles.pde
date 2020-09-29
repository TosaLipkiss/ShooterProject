class Missiles
{
	PVector missilesPos = new PVector();
	PVector missilesVel = new PVector();
	PVector missilesDir = new PVector();
	PVector playerSeeker = new PVector();

	float missilesAccelation=200;
	int missilesSize = 40;
	int numberOfMissiles = 5;
	boolean missilesLaunch = false;

	float timer;
	float missilesInterval = 5;

  public Missiles()
  {
    missilesPos.x = width / 2 + 500;
    missilesPos.y = height / 2;

    missilesVel.x = -3;
    missilesVel.y = random(-3, 3);

    ellipseMode(CENTER);
  }

	void update()
	{
		if(timer >= missilesInterval)
		{
			missilesLaunch = true;
			timer = 0;
		}

		if(missilesLaunch == true)
		{
			launch();
		}

		timer += deltaTime;
	}

	void draw()
	{
		if(timer >= missilesInterval)
		{
			missilesLaunch = true;
			timer = 0;
		}

		if(missilesLaunch == true)
		{
			missilesGraphic();
		}

		playerSeeker.x = missilesPos.x * missilesDir.x;
		playerSeeker.y = missilesPos.y * missilesDir.y;
	}

	  void missilesGraphic()
	  {
	    fill(50, 200, 210);
	    ellipse(playerSeeker.x, playerSeeker.y, missilesSize, missilesSize);
	  }

	 //  void launch()
	 //  {
	 //  	missilesDir.x = player1.playerPosition.x;
		// missilesDir.y = player1.playerPosition.y;
	 //  }
}