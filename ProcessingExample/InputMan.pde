class InputMan
{
  //Our directional keys
  char upKey = 'w';
  char downKey = 's';
  char leftKey = 'a';
  char rightKey = 'd';
  
  //if they're down
  boolean left;
  boolean right;
  boolean up;
  boolean down;
  
  //the last direction is x and y plane
  int lastDirX, lastDirY;
  
  InputMan()
  {
    left = false;
    right = false;
    up = false;
    down = false;
    lastDirX = 0;
    lastDirY = 0;
  }
  
  //if we're moving horizontally
  boolean movingH()
  {
    return left || right;
  }
  
  //if we're moving vertically
  boolean movingV()
  {
    return up || down;
  }
  
  //our current x direction
  int xDir()
  {
    if(left && right)
    {
      lastDirX = 0;
      return 0;
    }
    else if(left)
    {
      lastDirX = -1;
      return -1;
    }
    else if(right)
    {
      lastDirX = 1;
      return 1;
    }
    lastDirX = 0;
    return 0;
  }
  
  //our current y direction
  int yDir()
  {
    if(up && down)
    {
      lastDirY = 0;
      return 0;
    }
    else if(up)
    {
      lastDirY = -1;
      return -1;
    }
    else if(down)
    {
      lastDirY = 1;
      return 1;
    }
    lastDirY = 0;
    return 0;
  }
  
  //called whenever a key is pressed
  void keyPressed()
  {
    if(key == upKey)
    {
      up = true;
    }
    else if(key == leftKey)
    {
      left = true;
    }
    else if(key == downKey)
    {
      down = true;
    }
    else if(key == rightKey)
    {
      right = true;
    }
  }
  
  //called whenever a key is released
  void keyReleased()
  {
    if(key == 'w')
    {
      up = false;
    }
    if(key == 'a')
    {
      left = false;
    }
    if(key == 's')
    {
      down = false;
    }
    if(key == 'd')
    {
      right = false;
    }
  }
}
