public class Food extends Being{
  
  Food(){
    super();
    size = width / 20;
    spawn();
    setShape(new Circle(position, size/2));
  }
  
  void update(){
    if(position.x>width-size/2 || position.x<size/2) velocity.x *= -1;
    if(position.y>height-size/2 || position.y<size/2) velocity.y *= -1;
    position.add(velocity);
  }
  
  void render(){
    fill(red);
    noStroke();
    circle(position.x, position.y, size);
  }
  
  void spawn(){
    int corner = (int) random(4);
    switch(corner){
      case 0:
        position.x = size;
        position.y = size;
        break;
      case 1:
        position.x = width-size;
        position.y = size;
        break;
      case 2:
        position.x = width-size;
        position.y = height-size;
        break;
      default:
        position.x = size;
        position.y = height-size;
    }  
    velocity = PVector.random2D();
    velocity.setMag(5);
  }
  
}
