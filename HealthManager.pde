class Healthmanager 
{
  float value;
  float max;
  float healthBarX;
  float healthBarY;
  float healthBarWidth;
  float healthBarHeight;
  color damage;
  color hp;
  
  Healthmanager()
  {
    value = 50;
    max = 100;
    healthBarX = 10;
    healthBarY = 10;
    healthBarWidth = 200;
    healthBarHeight = 10;
    damage = color(255,0,0);
    hp = color(0,255,0);
  }
  void draw(){
    fill(damage);
    stroke(0);
    rect(healthBarX,healthBarY,healthBarWidth,healthBarHeight);
    fill(hp);
    rect(healthBarX,healthBarY,map(value,0,max,0,healthBarWidth),healthBarHeight);
  }
}
