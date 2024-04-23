import gifAnimation.*;
class SpawnTile extends Tile {

  int delay;
  int interval;
  int count;
  int lastCallTime = 0;
  PApplet parent;

  SpawnTile(int i, int j, String t, int d, int inter, int c, PApplet parent) {
    super(i, j, t);
    delay = d * 1000;
    interval = inter * 1000;
    count = c;
    this.parent = parent;
  }

  @Override
  void update() {
    int currentTime = millis();
    if (count > 0 && currentTime >= delay && currentTime - lastCallTime >= interval) {
      count--;
      Gif myAnimation = new Gif(parent, "robotRun.gif");
      myAnimation.loop();
      active.register("Robots", new Robot(row, col, myAnimation));
      lastCallTime = currentTime;
    }
  }

  
}
