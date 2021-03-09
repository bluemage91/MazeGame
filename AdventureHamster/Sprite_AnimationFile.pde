PImage playerImages []; //animation images
PImage player; //player image
PImage map; //map image
PImage fog; //fog of war
int playerFrames; //current frame of character animation
int frameCnt=1; //frame count in the program
PFont myFont; //new font
int[][] StartPointXY; //array of starting points
//Defining the start Points

//Classes
class player
{
float p_x = 250; float p_y = 250; //player position
float v_x, v_y; //player velocity
float a_x=0; float a_y=0; //player acceleration
PImage image; //image of the player
int size = 35; //default size of player
}

boolean keyAcquired=false; //start the game with the key unacquired

player one = new player();

void setup()
{
map = loadImage("Maze SpriteV2.jpg");
fog = createImage(map.width,map.height,ARGB);
//creating the animation
playerFrames = 3;
one.image = loadImage("hamster.png");
playerImages = new PImage[playerFrames];
  for (int i = 0; i<playerFrames;i++){
    playerImages[i]=loadImage("roll"+i+".png");
  }
size(1200,900);
background(255);
}

void fogOfWar(int xpos,int ypos,int size)
{
//Creates the circle around the character
map.loadPixels();
fog.loadPixels();
for (int i=0; i<map.width; i++)
{
  for (int j=0; j<map.height;j++)
  {
    int index = i + j*map.width;
    int halfSize = int(size/2);
    if (i<=xpos+halfSize && i>=xpos-halfSize && j<=ypos+halfSize && j>=ypos-halfSize)
    {
      fog.pixels[index]=map.pixels[index];
    }
    else
    {
      fog.pixels[index]=color(0,0,0);
    }
  }
}
fog.updatePixels();
}

void draw(){
  imageMode(CORNER); //places the fog in the corner
  fogOfWar(int(one.p_x),int(one.p_y),125);
  image(fog,0,0);
  frameCnt++;
  imageMode(CENTER); //sprites are presented at center
  image(one.image,one.p_x,one.p_y,one.size,one.size);//normal player deposited
  one.v_y=1.05; one.v_x=1.05;
    if (keyPressed && (key=='w'||key == 's'||key == 'a'||key == 'd')) {
    image(playerImages[frameCnt%3],one.p_x,one.p_y,one.size,one.size);//animates the sprite
    if (key == 'w' || key == 'W') {
      one.p_y=one.p_y-one.v_y;//up
    }
    if (key == 's' || key == 'S') {
      one.p_y=one.v_y+one.p_y;//down
    }
    if (key == 'a' || key == 'A') {
      one.p_x=one.p_x-one.v_x;//left
    }
    if (key == 'd' || key == 'D') {
      one.p_x=one.p_x+one.v_x;//right
    }
  }

}
