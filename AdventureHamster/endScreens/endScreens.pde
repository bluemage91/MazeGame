PImage gameOver;
PImage youWon;

boolean gO = false;
boolean yW = false;

void setup()
{
  size(1200, 800);
  fill(255);

  gameOver=loadImage("gameover.jpg");

  youWon=loadImage("youwon.jpg");
}

void draw ()
{
  if (gO==true)
  {
    image(gameOver, 0, 0);
  }
  if (yW==true)
  {
    image(youWon, 0, 0);
  }
}

//the following code is temporary placeholders
//gO needs to be set to true when timer runs out
//yW needs to be set to true when the hamster uses the key to open the door

void keyPressed()
{
  if (key== 'q')
  {
    gO = true;
  }
  if (key=='w')
  {
    yW = true;
  }
}
