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

class berryKey
{
float p_x; float p_y;
boolean keyAcquired=false; //start the game with the key unacquired
PImage image; //image of key
}

class door
{
 float p_x; float p_y; //original position
 boolean keyMet = false; //key meets the door
}

//Creating the Objects
player one = new player();
berryKey berry = new berryKey();
door door = new door();

//Setup Function
void setup()
{
map = loadImage("Maze SpriteV2.jpg"); //attributes map png to variable
fog = createImage(map.width,map.height,ARGB); //map sized blank image
one.image = loadImage("hamster.png");//loads hamster
berry.image = loadImage("key.png");//loads berry key
//creating the animation
playerFrames = 3;
playerImages = new PImage[playerFrames];
  for (int i = 0; i<playerFrames;i++){
    playerImages[i]=loadImage("roll"+i+".png");
  }
size(1200,900); //window creation
background(255); //background creation
}

//Removes the ability to see the full map as the player
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

//Draw Function
void draw(){
  imageMode(CORNER); //places the fog in the corner
  fogOfWar(int(one.p_x),int(one.p_y),125); //lays down the fog of war
  image(fog,0,0);//places the fog on the drawing
  frameCnt++;
  
  imageMode(CENTER); //sprites are presented at center
  image(one.image,one.p_x,one.p_y,one.size,one.size);//normal player deposited
  one.v_y=1.75; one.v_x=1.75; //speed of player
  
  //Movement
    if (keyPressed && (key=='w'||key == 's'||key == 'a'||key == 'd')) {
    //animates the sprite
    image(playerImages[frameCnt%3],one.p_x,one.p_y,one.size,one.size);
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
  println(one.p_x,one.p_y);//Prints location of player.
}
