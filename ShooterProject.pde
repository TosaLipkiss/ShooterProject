float deltaTime;
float time;
Player player1;
Enemy enemy;

void setup()
{
	frameRate(144);
	size(1280, 720);

  	player1 = new Player();
  	enemy = new Enemy();
}

void draw()
{
	background(0, 0, 0);

  	long elapsedTime = millis();
  	deltaTime = (elapsedTime - time) * 0.001f;
  	
  	player1.move();
  	player1.display();

  	enemy.draw();
  	enemy.update();

  	time = elapsedTime;
}
