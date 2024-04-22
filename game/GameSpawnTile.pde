class SpawnTile extends Tile {

  int delay;
  int interval;
  int count;
  int lastCallTime = 0;

  SpawnTile(int i, int j, String t, int d, int inter, int c) {
    super(i, j, t);
    delay = d * 1000;
    interval = inter * 1000;
    count = c;
  }

  @Override
  void update() {
    int currentTime = millis();
    if (count > 0 && currentTime >= delay && currentTime - lastCallTime >= interval) {
      count--;
      print("LMAO");
      lastCallTime = currentTime;
    }
  }
}
