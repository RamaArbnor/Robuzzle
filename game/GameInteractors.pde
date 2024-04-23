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

public class RobotWallInteractor extends Interactor<Robot, Tile> {
	RobotWallInteractor(){
    	super();
  	}

  	boolean detect(Robot r, Tile t){
    	if(r == null) return false;

		int row = (int)r.position.y/50;
		int col = (int)r.position.x/50;
		if ((r.facingRight && col + 1 == t.col && row == t.row) || (!r.facingRight && col == t.col && row == t.row)) {
			return true;
		}

		return false;
  	}

	void resolve(Robot r, Tile t){
		r.velocity.x = 0;
	}
}

public class RobotRobotInteractor extends Interactor<Robot, Robot> {
	RobotRobotInteractor(){
    	super();
  	}

  	boolean detect(Robot r, Robot t){
    	if(r == null) return false;

		int rRow = (int)r.position.y/50;
		int rCol = (int)r.position.x/50;

		int tRow = (int)t.position.y/50;
		int tCol = (int)t.position.x/50;

		// println("rob: " + col + " " + row + " target: " + t.col);
		if (!r.emerging	&& ((r.facingRight && rCol + 1 == tCol && rRow == tRow)
			|| (!r.facingRight && rCol - 1 == tCol && rRow == tRow)
			|| (r.falling > 30 && rCol == tCol && rRow + 1 == tRow))) {
			return true;
		}

		return false;
  	}

	void resolve(Robot r, Robot t){
		r.velocity = new PVector(0,0);
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