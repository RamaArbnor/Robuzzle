public class FoodAvatarInteractor extends Interactor<Food, Avatar>{
  
  FoodAvatarInteractor(){
    super();
  }
  
  boolean detect(Food f, Avatar a){
    return f.collides(a);  
  }
  
  void resolve(Food f, Avatar a){
    score++;
    println(score);
    f.spawn();
    active.register("ghosts", new Ghost());
  }
}

//////////////////////////////////////////

public class GhostAvatarInteractor extends Interactor<Ghost, Avatar>{
  
  GhostAvatarInteractor(){
    super();
  }
  
  boolean detect(Ghost g, Avatar a){
    return g.collides(a);  
  }
  
  void resolve(Ghost g, Avatar a){
    a.life--;
    g.spawn();
    if(a.life==0){
      active = mode.get("gameOver");
    }
  }
}
