public class RobotTileInteractor extends Interactor<Robot, Tile> {

  RobotTileInteractor() {
    super();
  }

  boolean detect(Robot r, Tile t) {
    if (r == null) return false;

    return r.detect(t);
  }

  void resolve(Robot r, Tile t) {
    r.walking = true;
    if (t.type.equals("<")) {
      r.velocity = new PVector(-1, 0);
      r.facingRight = false;
      r.falling = 0;
    } else if (t.type.equals(">")) {
      r.velocity = new PVector(1, 0);
      r.facingRight = true;
      r.falling = 0;
    } else {

      if (r.facingRight) {
        r.velocity = new PVector(1, 0);
      } else {
        r.velocity = new PVector(-1, 0);
      }
      if (r.falling > 190) {
        print("Rash: " + r.falling);
        active.remove("Robots", r);
      }
      r.falling = 0;
    }
  }
}

public class RobotTeleporterInteractor extends Interactor<Robot, Teleporter> {

  RobotTeleporterInteractor() {
    super();
  }

  boolean detect(Robot r, Teleporter t) {
    if (r == null) return false;

    return r.detect(t);
  }

  void resolve(Robot r, Teleporter t) {
    t.teleport(r);
  }
}

public class RobotSwingInteractor extends Interactor<Robot, SwingTile> {

  RobotSwingInteractor() {
    super();
  }

  boolean detect(Robot r, SwingTile s) {
    if (r.swinging) return false;
    int row = (int)r.position.y/50;
    int col = (int)r.position.x/50;
    if ((r.facingRight && col+2 == s.col && row == s.row + 2) || (!r.facingRight && col - 1  == s.col && row == s.row + 2)) {

      if (r.walking) {
        print("HELLO");
        return true;
      }
    }
    return false;
  }

  void resolve(Robot r, SwingTile s) {
    s.current = r;
    r.swinging = true;

    s.setStartingAngle();
  }
}
