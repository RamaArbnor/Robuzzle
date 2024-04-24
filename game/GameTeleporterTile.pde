class Teleporter extends Tile {
  PVector dest;
  ArrayList<Robot> robots;
  int tpTime;
  Teleporter(int i, int j, String t, PVector loc) {
    super(i, j, t);
    dest = loc;
    robots = new ArrayList<Robot>();
    tpTime = 0;

    img = loadImage("assets/teleporterEntry.png");
  }

  void teleport(Robot r) {
    tpSound.play();
    r.position.x = (dest.y)*50;
    r.position.y = (dest.x-1)*50;
    r.teleporting = false;
    r.resetImg();
    println("Teleporting to: " + dest.x + ", " + dest.y);
  }

  @Override
    void update() {
    super.update();
    tpTime = (tpTime + 1) % 3;
    if (tpTime == 0) {
      for (int i = 0; i < robots.size(); i++) {
        Robot r = robots.get(i);
        r.position.y--;
        if (r.position.y < position.y - 30) {
          robots.remove(r);
          teleport(r);
        }
      }
    }
  }

  void initiateTP(Robot r) {
    r.teleporting = true;
    robots.add(r);
    //t.teleport(r);
    // r.state = "Normal";
    r.changeState("Normal");
    r.position.y = position.y;
  }

  void render() {
    if (img != null) {
      image(img, position.x, position.y-30, size, size+30);
    }
  }
}
