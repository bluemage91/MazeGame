import processing.sound.*;
PImage hamster;
PImage hamtrans;
PImage howto;
PFont f;

//bgm = background music
SoundFile bgm;

boolean startScreen=true;

int backColor= color(101, 95, 54);
int fColor=color(205, 163, 114);
int f1Color=color(172, 149, 124);

void setup()
{
  size(1200, 800);
  fill(255);

  hamster=loadImage("hamStartScreen.png");
  hamster.loadPixels();

  hamtrans=createImage(hamster.width, hamster.height, ARGB);
  hamtrans.loadPixels();

  howto=loadImage("howToPlay.png");
  howto.loadPixels();

  f=createFont("PressStart2P.ttf", 128);

  bgm = new SoundFile(this, "gamemusic.wav");
  
}

void draw()
{
  bgm.play();

  if (startScreen==true)
  {
    background(backColor);

    for (int x=0; x<hamster.width; x++)
    {
      for (int y=0; y<hamster.height; y++)
      {
        //hamloc = hamster location
        int hamloc= x+y*hamster.width;

        if (hamster.pixels[hamloc]==color(255))
        {
          hamtrans.pixels[hamloc]=color(0, 0);
        } else
        {
          hamtrans.pixels[hamloc]=hamster.pixels[hamloc];
        }
      }
    }

    hamster.updatePixels();
    hamtrans.updatePixels();
    howto.updatePixels();

    image(hamtrans, -118, -5);
    image(howto, 612, 197);

    textFont(f, 66);
    fill(fColor);
    text("Adventure Hamster", 52, 108);

    textFont(f, 25);
    fill(f1Color);
    text("Press Space to Start!", 565, 700);
  }

  if (startScreen==false)
  {
    background(255);//GAME CODE HERE
  }
}

void keyPressed()
{
  if (key == ' ')
  {
    startScreen=false;
  }
}
