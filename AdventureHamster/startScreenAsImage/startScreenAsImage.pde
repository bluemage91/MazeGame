PImage startScreen;

void setup()
{
 size(1200,800);
 
 startScreen=loadImage("startscreen.jpg");
}

void draw()
{
  image(startScreen,0,0);
}
