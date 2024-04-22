abstract class Being{
  PVector position;
  PVector velocity;
  Shape shape;
  float size;
  
  Being(){
    position = new PVector();
    velocity = new PVector();
    size=0;
    shape = null;
  }
  
  Being(PVector p, PVector v, float s){
    position = p;
    velocity = v;
    size = s;
    shape = null;
  }
  
  void setShape(Shape s){
    shape = s;
  }
  
  boolean collides(Being other){
    boolean result = false;
    if(this.shape != null && other.shape != null){
      result = this.shape.collides(other.shape);  
    }
    return result; 
  }
  
  abstract void update();
  abstract void render();
}
