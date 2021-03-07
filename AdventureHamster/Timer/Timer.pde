PFont font1;
int totaltime = 90;
int countdown = millis();

void setup()
{
  frameRate(1);
  size(1200, 800);
  background(255);
  //Load whatever font we are using
  font1 = loadFont("ComicSansMS-48.vlw");
}

void draw()
{
  background(255);
int Seconds = (totaltime - countdown) % 60;
int Minutes = (totaltime - countdown) / 60;
  countdown = countdown + 1;
  textFont(font1,60);
  fill(1);
  //change position to wherever 
  text(nf(Minutes, 2) + ":" + nf(Seconds, 2), 950, 100);
  
}
