float deltaTime;
float time;
Player player1;

void setup()
{
	frameRate(144);
	size(1280, 720);
  	player1 = new Player();
}

void draw()
{
	background(0, 0, 0);
  	long elapsedTime = millis();
  	deltaTime = (elapsedTime - time) * 0.001f;
  	player1.move();
  	player1.display();
  	time = elapsedTime;
}
