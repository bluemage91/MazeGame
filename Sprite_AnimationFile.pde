PImage playerImages [];
PImage player;
PImage map;
int playerFrames;
int frameCnt=1;

//Classes
class player
{
float p_x = 0; float p_y = 0; //player position
float v_x, v_y; //player velocity
float a_x=0; float a_y=0; //player acceleration
PImage image; //image of the player
}

player one = new player();

void setup()
{
map = loadImage("Maze SpriteV2.jpg");
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

void draw(){
  image(map,0,0);
  frameCnt++;
  image(one.image,one.p_x,one.p_y,75,75);//normal player deposited
  one.v_y=1.05; one.v_x=1.05;
    if (keyPressed && (key=='w'||key == 's'||key == 'a'||key == 'd')) {
    image(playerImages[frameCnt%3],one.p_x,one.p_y,75,75);//animates the sprite
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
