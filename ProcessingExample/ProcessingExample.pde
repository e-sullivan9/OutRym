
Player player;

//The constructor for the main class(this one)
//Called once at the start.
void setup()
{
  //sets the size of the window
  size(600,600);
  //the frames(times draw is called) per second
  frameRate(45);
  //draw ellipses from the center point
  ellipseMode(CENTER);
  
  player = new Player(width/2,height/2,25,25,2.5);
}

//update method, not a default like the setup and draw
//but I like to seperate from the draw method so we can
//thread later on if needed.  called once per draw
void update()
{
  player.update();
}


void draw()
{
  //sets the fill color for drawing
  fill(125,25);
  //draw a rectangle across the whole screen
  //to clear the last frame
  rect(0,0,width,height);
  
  player.draw();
  update();
}

//Processing Method, called whenever a key is pressed
//already threaded for us
void keyPressed()
{
  player.keyPressed();
}

//Processing Method, called whenever a key is released
//already threaded for us
void keyReleased()
{
  player.keyReleased();
}
