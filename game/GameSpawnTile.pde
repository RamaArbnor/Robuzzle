import gifAnimation.*;
class SpawnTile extends Tile {

  int delay;
  int interval;
  int count;
  int lastCallTime = 0;
  boolean spawnRight;
  PApplet parent;
  int startTime;
  int startPauseTime;
  int totalPauseTime;
  boolean paused;

  SpawnTile(int i, int j, String t, int d, int inter, int c, boolean right, PApplet parent) {
    super(i, j, t);
    delay = d * 1000;
    interval = inter * 1000;
    count = c;
    this.parent = parent;
    spawnRight = right;
    startTime = millis();
    totalPauseTime = 0;
    paused = false;

	img = loadImage("assets/start.png");
  }

  @Override
  void update() {
    int currentTime = millis() - startTime;
    
    if ((!paused && count > 0 && currentTime >= delay && currentTime - lastCallTime >= interval) || (
    paused && count > 0 && currentTime >= delay && currentTime - lastCallTime - totalPauseTime >= interval
    )) {
      paused = false;
      totalPauseTime = 0;
      count--;
      Gif[] gifs = new Gif[4];
      gifs[0] = new Gif(parent, "robotRun.gif");
      gifs[1] = new Gif(parent, "robotBlue.gif");
      myAnimation.loop();
      active.register("Robots", new Robot(row, col,spawnRight, gifs));
      lastCallTime = currentTime;
    }
  }
  
  void stop(){
    startPauseTime = millis();
    paused = true;
  }
  
  void start(){
    totalPauseTime += millis() - startPauseTime;
  }

  
}
