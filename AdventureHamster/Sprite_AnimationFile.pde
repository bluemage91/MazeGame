//Initialization of proper global variables
import processing.sound.*;
PImage playerImages []; //animation images
PImage player; //player image
PImage map; //map image
PImage fog; //fog of war
PImage victory; //victory screen
PImage loss; //defeat screen
int playerFrames; //current frame of character animation
int countdown = millis();
int frameCnt=1; //frame count in the program
PFont myFont; //new font
SoundFile bgm;
boolean defeat = false;


//Defining the start Points
int[][] StartPointXY = {{815,547},
                        {255,255},
                        {965,547},
                        {1113,403}};//array of starting points
int[][] doorLocal = {{1161,692},{38,107}}; //array of starting point for the door

//Classes
class player
{
int initialPlayer = int(random(0,4));
float p_x=StartPointXY[initialPlayer][0];
float p_y=StartPointXY[initialPlayer][1];
float v_x, v_y; //player velocity
float a_x=0; float a_y=0; //player acceleration
PImage image; //image of the player
int size = 35; //default size of player
}

class berryKey
{
int initialKey = int(random(0,4));
float p_x=StartPointXY[initialKey][0];
float p_y=StartPointXY[initialKey][1];
boolean tengo=false; //start the game with the key unacquired
PImage image; //image of key
int size=25; //size of the key
}

class door
{
 int initialDoor = int(random(0,2)); //0 or 1 value
 float p_x=doorLocal[initialDoor][0];
 float p_y=doorLocal[initialDoor][1];
 boolean keyMet = false; //key meets the door
 PImage image; //image of the door
 int size=85; //size of the door
}

//Creating the Objects
player one = new player();
berryKey berry = new berryKey();
door door = new door();

//Setup Function
void setup()
{
if (one.initialPlayer == berry.initialKey) {
    if (berry.initialKey == 3) {
      berry.initialKey--;
      berry.p_x=StartPointXY[berry.initialKey][0];
      berry.p_y=StartPointXY[berry.initialKey][1];
    } else {
      berry.initialKey++;
      berry.p_x=StartPointXY[berry.initialKey][0];
      berry.p_y=StartPointXY[berry.initialKey][1];
    }
    berry.tengo = false;
  }
map = loadImage("Maze SpriteV2.jpg"); //attributes map png to variable
fog = createImage(map.width,map.height,ARGB); //map sized blank image
victory = loadImage("youwon.jpg"); //victory screen
loss = loadImage("gameover.jpg"); //defeat screen
one.image = loadImage("hamster.png");//loads hamster
one.image.loadPixels();
PImage tmp = createImage(one.image.width, one.image.height,ARGB);
tmp.loadPixels();
for ( int i = 0 ; i < one.image.width ; i++ ) {
  for ( int j = 0 ; j < one.image.height ; j++ ) {
    if (one.image.pixels[i + j*one.image.width] != color(255)) {
     tmp.pixels[i + j*one.image.width] = one.image.pixels[i + j*one.image.width]; //hamster remove white
    }
  }
}
one.image=tmp; //reset to have only the hamster
one.image.updatePixels();
berry.image = loadImage("key.png");//loads berry key
berry.image.loadPixels();
PImage tmp1 = createImage(berry.image.width, berry.image.height,ARGB);
tmp.loadPixels();
for ( int i = 0 ; i < berry.image.width ; i++ ) {
  for ( int j = 0 ; j < berry.image.height ; j++ ) {
    if (berry.image.pixels[i + j*berry.image.width] != color(255)) {
     tmp1.pixels[i + j*berry.image.width] = berry.image.pixels[i + j*berry.image.width];
    }
  }
}
berry.image=tmp1;
berry.image.updatePixels();
door.image = loadImage("door.png");
//Writes door to the map
map.loadPixels(); door.image.resize(door.size,door.size);
door.image.loadPixels();
for ( int i = 0 ; i < door.image.width ; i++ ) {
  for ( int j = 0 ; j < door.image.height ; j++ ) {
    int doorSpot = (int(door.p_x)-door.size/2+i)
                    + (int(door.p_y)-door.size/2 + j)*map.width;
    if (door.image.pixels[i + j*door.image.width] != color(255)) {
      map.pixels[doorSpot] = door.image.pixels[i + j*door.image.width];
    }
  }
}
map.updatePixels();

//creating the animation
playerFrames = 3;
playerImages = new PImage[playerFrames];
  for (int i = 0; i<playerFrames;i++)
  {
    playerImages[i]=loadImage("roll"+i+".png");
    playerImages[i].loadPixels();
    PImage tmp3 = createImage(playerImages[i].width, playerImages[i].height,ARGB);
    tmp3.loadPixels();
    for ( int k = 0 ; k < playerImages[i].width ; k++ ) {
      for ( int j = 0 ; j < playerImages[i].height ; j++ ) {
        if (playerImages[i].pixels[k + j*playerImages[i].width] != color(255)) {
         tmp3.pixels[k + j*playerImages[i].width] = playerImages[i].pixels[k + j*playerImages[i].width]; //hamster remove white
        }
      }
    }
    playerImages[i]=tmp3; //reset to have only the hamster
    playerImages[i].updatePixels();
  }

size(1200,800); //window creation
background(255); //background creation
myFont = createFont("PressStart2P.ttf", 128);//creation of font
//bgm = new SoundFile(this, "gamemusic.mp3");
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
      fog.pixels[index]=map.pixels[index]; //rewrites within the fog the original map
    }
    else
    {
      fog.pixels[index]=color(0,0,0); //everywhere else is black
    }
  }
}
fog.updatePixels();
}


//Draw Function
void draw(){
  //bgm.play(); //plays the music
  
  //Background and Fog of War
  imageMode(CORNER); //places the fog in the corner
  //image(map,0,0); //for debug
  int fowSize = 125;
  fogOfWar(int(one.p_x),int(one.p_y),fowSize); //lays down the fog of war
  image(fog,0,0);//places the fog on the drawing
  frameCnt++;
  
  //Countdown Timer
  int time = millis();
  int Seconds = ((time)/1000)%60;//presents the seconds
  int Minutes = ((time)/(1000*60)) % 60; //represents the amount of minutes remaining
  textFont(myFont,30);
  fill(255);
  //change position to wherever and presents the time
  text(nf(Minutes, 2) + ":" + nf(Seconds, 2), 550, 50);
  
  //GameOver Timing
  if (time/1000%60==90)
  {
    defeat=true; //means player lost
  }
  
  //Sprite Portions
  imageMode(CENTER); //sprites are presented at center
  one.v_y=3; one.v_x=3; //speed of player
  
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
    else
    {
    image(one.image,one.p_x,one.p_y,one.size,one.size);//normal player deposited
    }

  //If their field of vision enters the berrys region
  if (one.p_x+fowSize/2>berry.p_x && one.p_x-fowSize/2<berry.p_x &&
      one.p_y+fowSize/2>berry.p_y && one.p_y-fowSize/2<berry.p_y &&
      berry.tengo ==false)
  {
    image(berry.image,berry.p_x,berry.p_y,berry.size,berry.size); //berry placed
  }
  //if the player retreives the berry
  if (one.p_x+berry.size/2>berry.p_x && one.p_x-berry.size/2<berry.p_x &&
      one.p_y+berry.size/2>berry.p_y && one.p_y-berry.size/2<berry.p_y)
  {
    berry.tengo=true; //berry acquired
  }
  if (berry.tengo==true)
  {
    image(berry.image,1100,60,60,60); //Berry TR Place
    if (one.p_x+door.size/2>door.p_x && one.p_x-berry.size/2<door.p_x &&
      one.p_y+door.size/2>door.p_y && one.p_y-door.size/2<door.p_y)
      {
        door.keyMet = true;
      }
  }
  if (door.keyMet == true)
  {
    imageMode(CORNER);
    image(victory,0,0); //victory screen
    imageMode(CENTER);
  }
  
  //Game Over Screen
  if (defeat==true && door.keyMet==false)
  {
    imageMode(CORNER);
    image(loss,0,0);
    imageMode(CENTER);
  }
  
  //In case the player leaves map
  if (one.p_x>1200 || one.p_x<0 || one.p_y<0 || one.p_y>900)
  {
    one.p_x=250; one.p_y = 250;//Spawns the character here if they manage to leave map
  }
  
}

void mouseClicked()
{
  if (door.keyMet == true)
  {
  door.keyMet = false;
  berry.tengo = false;
  one.p_x=255; one.p_y=255;
  berry.p_x = 1113; berry.p_y = 403;
  }
  if (defeat == true)
  {
  defeat = false;
  berry.tengo = false;
  one.p_x=255; one.p_y=255;
  berry.p_x = 1113; berry.p_y = 403;
  }
}
