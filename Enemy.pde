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

	void update()
	{

		bossPos.x += bossVel.x;
		bossPos.y += bossVel.y;

		if(bossPos.y >= height - bossSize / 2 || bossPos.y <= 0 + bossSize / 2)
		{
			bossVel.y *= -1;
		}
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
