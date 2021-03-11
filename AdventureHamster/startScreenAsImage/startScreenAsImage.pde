PImage startScreen;

boolean startS=true;

void setup()
{
  size(1200, 800);

  startScreen=loadImage("startscreen.jpg");
}

void draw()
{
  if (startS==true)
  {
    image(startScreen, 0, 0);
  } else
  {
    background(255);///GAME CODE HERE
  }
}

void keyPressed()
{
  if (key == ' ')
  {
    startS=false;
  }
}
