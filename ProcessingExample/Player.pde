class Player
{
  //position and dimensions
  float x,y,w,h;
  //velocities and speed
  float vX, vY, s;
  //draw color
  color c;
  //how we're being controlled
  InputMan inMan;
  //gravity constant
  float g = .25f;
  
  Player(int x, int y,int w, int h, float s)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.s = s;
    this.vX = 0;
    this.vY = 0;
    c = color (15,125,15);
    inMan = new InputMan();
  }
  
  void update()
  {
    //set our x speed
    if(inMan.left || inMan.right)
    {
      vX = s;
    }
    else
    {
      if(vX > g)
      {
        vX -= g;
      }
      else
      {
        vX = 0f;
      }
    }
  
  //set our y speed
    if(inMan.up || inMan.down)
    {
      vY = s;
    }
    else
    {
      if(vY > g)
      {
        vY -= g;
      }
      else
      {
        vY = 0f;
      }
    }
    
    //add our velocities to position
    if(inMan.movingH())
    {
      x += vX*inMan.xDir();
    }
    else
    {
      x+= vX*inMan.lastDirX;
    }
    if(inMan.movingV())
    {
      y += vY*inMan.yDir();
    }
    else
    {
      y+= vY*inMan.lastDirY;
    } 
  }
  
  
  void draw()
  {
    //yeah, that easy
    fill(c);
    ellipse(x,y,w,h);
  }
  
  //wrapper for keypressed
  void keyPressed()
  {
    inMan.keyPressed();
  }
  
  //wrapper for keyreleased
  void keyReleased()
  {
    inMan.keyReleased();
  }
  
}
