import gifAnimation.*;
class SpawnTile extends Tile {

  int delay;
  int interval;
  int count;
  int lastCallTime = 0;
  boolean spawnRight;
  PApplet parent;
  int startTime;

  SpawnTile(int i, int j, String t, int d, int inter, int c, boolean right, PApplet parent) {
    super(i, j, t);
    delay = d * 1000;
    interval = inter * 1000;
    count = c;
    this.parent = parent;
    spawnRight = right;
    startTime = millis();
  }

  @Override
  void update() {
    int currentTime = millis() - startTime;
    if (count > 0 && currentTime >= delay && currentTime - lastCallTime >= interval) {
      count--;
      Gif myAnimation = new Gif(parent, "robotRun.gif");
      myAnimation.loop();
      active.register("Robots", new Robot(row, col,spawnRight, myAnimation));
      lastCallTime = currentTime;
    }
  }

  
}
