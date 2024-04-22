public class Ghost extends Being{
  float fieldOfView;
  float topSpeed;
  float searchSpeed;
  
  Ghost(){
    super();
    size = width / 20;
    searchSpeed = 10;
    topSpeed = 13;
    spawn();
    fieldOfView = width / 3;
    setShape(new Circle(position, size/2));
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
    velocity.setMag(searchSpeed);
  }
  
  void update(){
    if(position.x>width-size/2 || position.x<size/2) velocity.x *= -1;
    if(position.y>height-size/2 || position.y<size/2) velocity.y *= -1;
    seek(pacman.position);
    position.add(velocity);
  }
  
  void seek(PVector target){
    PVector seekVector = PVector.sub(target, this.position);
    if(seekVector.mag() < fieldOfView){
      velocity = seekVector;
      velocity.setMag(topSpeed);
    }else{
      velocity.setMag(searchSpeed);  
    }
  }
  
  void render(){
    fill(green);
    noStroke();
    circle(position.x, position.y, size);
  }
  
}
