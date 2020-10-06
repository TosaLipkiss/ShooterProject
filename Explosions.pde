class AsteroidExplosion
{
  PVector position;
  int currentFrame = 0;
  PImage[] asteroidExplosionSprite = new PImage[20];
  float spriteTimer = 0;

  public AsteroidExplosion(PVector spawnPosition)
  {
    position = spawnPosition;

    for (int i = 0 ; i < asteroidExplosionSprite.length ; i++)
    {
      asteroidExplosionSprite[i] = loadImage("sprite_asteroidExplosion_25x25_" + (i +1) + ".png");
    }
  }

  void draw()
  {
    if (spriteTimer > 0.03)
    {
      currentFrame++;
      spriteTimer = 0;
    }

    if(currentFrame < 20)
    {
      image(asteroidExplosionSprite[currentFrame % asteroidExplosionSprite.length], position.x, position.y);
    }

    spriteTimer += deltaTime;
  }
}

class MissileExplosion
{
  PVector position;
  int currentFrame = 0;
  PImage[] missileExplosionSprite = new PImage[20];
  float spriteTimer = 0;

  public MissileExplosion(PVector spawnPosition)
  {
    position = spawnPosition;

    for (int i = 0 ; i < missileExplosionSprite.length ; i++)
    {
      missileExplosionSprite[i] = loadImage("sprite_explosion_50x50_" + (i +1) + ".png");
    }
  }

  void draw()
  {
    if (spriteTimer > 0.05)
    {
      currentFrame++;
      spriteTimer = 0;
    }

    if(currentFrame < 20)
    {
      image(missileExplosionSprite[currentFrame % missileExplosionSprite.length], position.x, position.y);
    }

    spriteTimer += deltaTime;
  }
}

void spawnAsteroidExplosion(PVector position)
{
  asteroidExplosion = new AsteroidExplosion(position);
}

void spawnMissileExplosion(PVector position)
{
  missileExplosion = new MissileExplosion(position);
}
