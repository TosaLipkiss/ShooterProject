boolean moveUp;
boolean moveDown;

//Key pressed, set our variables to true
void keyPressed()
{
  if (keyCode == UP || key == 'a')
    moveUp = true;
  else if (keyCode == DOWN || key == 'd')
    moveDown = true;
}

//When a key is released, we will set our variable to false
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
