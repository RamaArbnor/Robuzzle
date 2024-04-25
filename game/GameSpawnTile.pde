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
  PFont font;
  boolean started;

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
    font = createFont("Jersey10-Regular.ttf", 32);
    started = false;
	  img = loadImage("assets/start.png");
  }

  @Override
  void update() {
    int currentTime = millis() - startTime;
    
    if ((!paused && count > 0 && ((!started && currentTime >= delay) || (started && currentTime - lastCallTime >= interval))) || (
    paused && count > 0 && ((!started && currentTime >= delay) || (started && currentTime - lastCallTime - totalPauseTime >= interval)
    ))) {
      started = true;
      paused = false;
      totalPauseTime = 0;
      count--;
      Gif[] gifs = new Gif[5];
      gifs[0] = new Gif(parent, "robotRun.gif");
      gifs[1] = new Gif(parent, "robotRed.gif");
      gifs[2] = new Gif(parent, "robotGreen.gif");
      gifs[3] = new Gif(parent, "robotYellow.gif");
      gifs[4] = new Gif(parent, "robotBlue.gif");

      myAnimation.loop();
      active.register("Robots", new Robot(row, col,spawnRight, gifs));
      lastCallTime = currentTime;
    }
  }

  void render(){
    super.render();
    fill(green);
    push();
    textFont(font);
    textSize(60);
    float adjust = size/2 - (textWidth(""+count)/2) + 1;
    text(""+count, position.x + adjust, position.y - 5);
    pop();
  
  }
  
  void stop(){
    startPauseTime = millis();
    paused = true;
  }
  
  void start(){
    totalPauseTime += millis() - startPauseTime;
  }

  
}
