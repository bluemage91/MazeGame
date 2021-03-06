//Fog of War elements, Music, and Minor Controls
PImage map;
PImage circle;
void setup()
{
size(600,600);
map = loadImage("landscape.jpg");
circle = createImage(100,100,ARGB);
frameRate(60);
}

class player
{
float p_x = 0; float p_y = 0; //player position
float v_x, v_y; //player velocity
float a_x=0; float a_y=0; //player acceleration
PImage image; //image of the player
}

void Fog_of_War(float xpos,float ypos,float size)
{
  //Details the code for the fog of war.
  for (int row = 0; row<=600; row++){
    for(int col=0; col<=600;col++){
      if (row<=ypos+size && row>= ypos-size && col>= xpos-size && row<= xpos+size)
      {
      //Does nothing if within the square we prescribe
      //Having trouble with dimensions of square
      }
      else
      {
        //makes all outside the box black
        int pixelNum=row+col*map.width;
        map.pixels[pixelNum] = color(0,0,0);
      }
    }
  }
  fill(255);
  ellipse(xpos,ypos,size,size);//ellipse around source
  
}

player one = new player();
int frameCnt=1;

void draw()
{
frameCnt++;
image(map,0,0,600,600);
/*
float startPosX=500; float startPosY=575; //player starting point
if (frameCnt <= 1)
{
 one.p_x=startPosX; one.p_y=startPosY; //sets player start position
}*/
Fog_of_War(one.p_x,one.p_y,25);
one.v_y=1.05; one.v_x=1.05;
//Basic Mobility
  if (keyPressed) {
    if (key == 'w' || key == 'W') {
      one.p_y=one.p_y-one.v_y;
    }
    if (key == 's' || key == 'S') {
      one.p_y=one.v_y+one.p_y;
    }
    if (key == 'a' || key == 'A') {
      one.p_x=one.p_x-one.v_x;
    }
    if (key == 'd' || key == 'D') {
      one.p_x=one.p_x+one.v_x;
    }
  }
//println();  
}
