class Enemy
{
	PVector bossPos = new PVector();
	PVector bossVel = new PVector();
	int bossSize = 200;
	boolean isCharging = false;

	float timer;
	float chargeInterval = 8;

	public Enemy()
	{
		bossPos.x = width/2 + 500;
		bossPos.y = height/2;

		bossVel.x = -5;
		bossVel.y = 1;
		ellipseMode(CENTER);
		//startTime = millis();
		//passedTime = startTime - millis();
	}

	void update()
	{
		if(bossPos.y <=  width/2 + 500)
		{
			bossPos.y += bossVel.y;
		}

		if(bossPos.y >= height - bossSize / 2 || bossPos.y <= 0 + bossSize / 2)
		{
			bossVel.y *= -1;
		}

		if(timer >= chargeInterval)
		{
			isCharging=true;
			timer = 0;
		}

		if(isCharging==true)
		{
			charge();
		}

		timer += deltaTime;
	}

	void draw()
	{
		
		bossGraphic();
	}

	void bossGraphic()
	{
		push();
		fill(255, 0, 0);
		ellipse(bossPos.x, bossPos.y, bossSize, bossSize);
		pop();
	}

	void charge()
	{
		bossPos.y -= bossVel.y;
		bossPos.x += bossVel.x;

		if(bossPos.x <= 0)
		{
			bossVel.x *= -1;
		}

		if (bossPos.x > width/2 + 500)
		{
			bossPos.x = width/2 + 500;
			chargeInterval = random(5, 15);
			
			isCharging = false;
			bossVel.x *= -1;
		}
	}
}
