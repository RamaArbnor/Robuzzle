public class RobotTileInteractor extends Interactor<Robot, Tile>{

  RobotTileInteractor(){
    super();
  }

  boolean detect(Robot r, Tile t){
    if(r == null) return false;

    return r.detect(t);
    
  }

  void resolve(Robot r, Tile t){

    if (t.type.equals("<")) {
      r.velocity = new PVector(-1,0);
      r.facingRight = false;
      r.falling = 0;
    } else if (t.type.equals(">")) {
      r.velocity = new PVector(1,0);
      r.facingRight = true;
      r.falling = 0;
    } else {

      if(r.facingRight){
        r.velocity = new PVector(1,0);
      } else {
        r.velocity = new PVector(-1,0);
      }
      if(r.falling > 190) {
        print("Rash: " + r.falling);
        active.remove("Robots", r);
      }
      r.falling = 0;
    }
  }
}

public class RobotTeleporterInteractor extends Interactor<Robot, Teleporter>{

  RobotTeleporterInteractor(){
    super();
  }

  boolean detect(Robot r, Teleporter t){
    if(r == null) return false;

    return r.detect(t);
  }

  void resolve(Robot r, Teleporter t){
    t.teleport(r);
  }
}

