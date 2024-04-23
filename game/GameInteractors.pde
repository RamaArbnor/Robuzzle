public class RobotTileInteractor extends Interactor<Robot, Tile>{
  
  RobotTileInteractor(){
    super();
  }
  
  boolean detect(Robot r, Tile t){
    if(r == null || r.emerging) return false;
    if(r.position.x > width || r.position.y > height) {
      active.remove("Robots", r);
      return false;
    }
    int row = (int)r.position.y/50;
    int col = (int)r.position.x/50;
    if(col == t.col && row+1 == t.row){
      return true;
    }
    return false;
  }
  
  void resolve(Robot r, Tile t){
    r.velocity = new PVector(1,0);
    if(r.falling > 190) {
      print("Rash: " + r.falling);
      active.remove("Robots", r);
    }
    r.falling = 0;
  }
}

// public class FoodAvatarInteractor extends Interactor<Food, Avatar>{
  
//   FoodAvatarInteractor(){
//     super();
//   }
  
//   boolean detect(Food f, Avatar a){
//     return f.collides(a);  
//   }
  
//   void resolve(Food f, Avatar a){
//     score++;
//     println(score);
//     f.spawn();
//     active.register("ghosts", new Ghost());
//   }
// }

// //////////////////////////////////////////

// public class GhostAvatarInteractor extends Interactor<Ghost, Avatar>{
  
//   GhostAvatarInteractor(){
//     super();
//   }
  
//   boolean detect(Ghost g, Avatar a){
//     return g.collides(a);  
//   }
  
//   void resolve(Ghost g, Avatar a){
//     a.life--;
//     g.spawn();
//     if(a.life==0){
//       active = mode.get("gameOver");
//     }
//   }
// }
