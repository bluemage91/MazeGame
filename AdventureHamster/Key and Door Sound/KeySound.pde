import processing.sound.*;
SoundFile keynoise;
SoundFile doornoise;
Sound vol;
int totaltime = 90;
int countdown = millis();


boolean Keygotten = false;
void setup()
{

  frameRate(1);
  keynoise = new SoundFile(this, "KeyObtained.wav");
  doornoise = new SoundFile(this, "DoorOpen.wav");
  background(255);
  size(1000, 1000);
  vol = new Sound(this);
}

void draw() {
  if (Keygotten == false)
    TimeInterval();
  //if (dist(xpos of charactersprite, ypos of charactersprite, xpos of keysprite, ypos of keysprite) < some number (Change as needed - very far))
  //vol.volume(0.2);
  //if (dist(xpos of charactersprite, ypos of charactersprite, xpos of keysprite, ypos of keysprite) < some number (Change as needed - medium distance))
  //vol.volume(0.5);
  //if (dist(xpos of charactersprite, ypos of charactersprite, xpos of keysprite, ypos of keysprite) < some number (Change as needed - very close))
  //vol.volume(0.8);

  //if (xpos of charactersprite == xpos of keysprite & ypos of charactersprite == ypos of keysprite)
  //KEYGET();

  //if (Keygotten == true) 
  //DoorOpened();
}

void KEYGET() {
  keynoise.play();
  Keygotten = true;
}
void DoorOpened()
{
  //if (xpos of charactersprite == xpos of doorsprite & ypos of charactersprite == ypos of doorsprite) (+ or - position of the door so that the character sprite doesn't have to be on the door)
  //doornoise.play();
}

void TimeInterval() {

  int Seconds = (totaltime - countdown); 
  countdown = countdown + 1;
  println(Seconds);


  if (Seconds == 80)
    keynoise.play();
  else if (Seconds == 70)
    keynoise.play();
  else if (Seconds == 60)
    keynoise.play();
  else if (Seconds == 50)
    keynoise.play();
  else if (Seconds == 40)
    keynoise.play();
  else if (Seconds == 30)
    keynoise.play();
  else if (Seconds == 20)
    keynoise.play();
  else if (Seconds == 10)
    keynoise.play();
}
