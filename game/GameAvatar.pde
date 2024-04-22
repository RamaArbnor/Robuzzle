public class Avatar extends Being{
  
  int life;
  
  Avatar(){
    super();
    size = width / 16;
    position = new PVector(width/2, height/2);
    life = 3;
    setShape(new Circle(position, size/2));
  }
  
  void update(){
    position.x = mouseX;
    position.y = mouseY;
  }
  
  void render(){
    fill(yellow);
    noStroke();
    circle(position.x, position.y, size);
  }
}
