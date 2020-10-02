boolean moveUp;
boolean moveDown;

//Key pressed, set our variables to true
void keyPressed()
{
  if (keyCode == UP || key == 'a')
    moveUp = true;
  else if (keyCode == DOWN || key == 'd')
    moveDown = true;
  //Spawn new bullet it we press "space-bar"
  if (key == 32) 
  {
    //Find empty spot in array, create list.
    for (int i = 0; i < bullets.length; i++) 
    {
      if (bullets[i] == null) 
      {
        bullets[i] = new Bullet(player1.playerPosition.x, player1.playerPosition.y);
        //we are done, break/quit the loop.
        break;
      }
    }
  }
  if (key == 'b')
  {
    start();
  }
}

void keyReleased()
{
  if (keyCode == UP || key == 'a')
    moveUp = false;
  else if (keyCode == DOWN || key == 'd')
    moveDown = false;
}

PVector input()
{
  PVector input = new PVector();

  if (moveUp)    
    input.y += -1;

  if (moveDown)  
    input.y +=  1;

  input.normalize();
  return input;
}
