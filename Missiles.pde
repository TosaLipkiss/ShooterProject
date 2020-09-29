class Missiles
{
	PVector missilesPos = new PVector();
	PVector missilesVel = new PVector();

	float missilesAccelation=200;
	int missilesSize = 50;
	boolean missilesLaunch = false;

	float timer;
	float missilesInterval = 10;

	public Missiles()
	{
		missilesPos.x = width / 2 + 500;
		missilesPos.y = height / 2;

		missilesVel.x = -3;
		missilesVel.y = random(-3, 3);

		ellipseMode(CENTER);
	}

	void draw()
	{
		missilesGraphic();
	}

	void missilesGraphic()
	{
		fill(50, 200, 210);
		ellipse(missilesPos.x, missilesPos.y, missilesSize, missilesSize);
	}
}