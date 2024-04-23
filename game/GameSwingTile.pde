import gifAnimation.*;
class SwingTile extends Tile {

  float startX;
  float startY;
  float targetX;
  float targetY;
  Robot current;
  float angle;
  float magnitude;
  boolean jumping;
  boolean waiting;
  float jump;
  PApplet parent;
  Gif img;
  int previousFrame = 0;

  SwingTile(int i, int j, PApplet parent) {
    super(i, j, "");
    current = null;
    jump = 20;
    this.parent = parent;
    img = new Gif(parent, "swing.gif");
    img.loop();
  }

  void update() {
    super.update();

    if(waiting) {
      if(current.facingRight && img.currentFrame() < previousFrame){
        print("Ja nisa apet");
        img.stop();
        waiting = false;
        jumping = true;
      } else if(!current.facingRight && img.currentFrame() == 7){
        print("Ja nisa apet");
        img.stop();
        waiting = false;
        jumping = true;
      }
      
      
    }
    previousFrame = img.currentFrame();
    if (current == null) return;

    if (jumping) {
      current.position.y -= 2;
      if(current.position.y <= startY - jump) {
        jumping = false;
        img.loop();
      }
    } else if(!waiting){
      if ((current.facingRight && current.position.x >= targetX) ||(!current.facingRight && current.position.x <= targetX)) {
        if(!current.facingRight){
          push();
          img.stop();
          img.loop();
          img.jump(0);
          scale(1,1);
          translate(position.x - 50, position.y);
          image(img, 0, 0, 150, 180);
          pop();
        }
        current.swinging = false;

        current = null;
        return;
      }



      if (current.facingRight) angle += 0.04;
      else angle -= 0.04;
      PVector newPos = newRobotPosition();
      current.position.x = newPos.x;
      current.position.y = newPos.y;
    }
  }

  void render() {
    // super.render();
    push();

    if (current!= null && !current.facingRight && !waiting && !jumping) {
      translate(position.x + 100, position.y);
      scale(-1, 1);
    } else {
      translate(position.x - 50, position.y);
      scale(1, 1);
    }

    image(img, 0, 0, 150, 180);
    pop();
  }


  void setStartingAngle() {
    waiting = true;
    if (current.facingRight) {
      startX = (col-2)*50;
      startY = (row+2)*50 - jump;
      targetX = startX + 200;
      targetY = startY;
      float x = 100;
      float y = 100 - jump;
      magnitude = (float)Math.sqrt((x*x + y*y));
      angle = asin(y/magnitude);
    } else {
      startX = (col+2)*50;
      startY = (row+2)*50 - jump;
      targetX = startX - 200;
      targetY = startY;
      float x = 100;
      float y = 100 - jump;
      magnitude = (float)Math.sqrt((x*x + y*y));
      angle = PI - asin(y/magnitude);
    }
    // current.position.x = startX;
  }

  PVector newRobotPosition() {
    float angleSin = sin(angle);
    float angleCos = cos(angle);
    float y = angleSin * magnitude;
    float x = angleCos * magnitude;
    if (current.facingRight)
      return new PVector((startX+100) - x, startY - 100 + y);
    return new PVector(startX -100 -x, startY - 100 + y);
  }
}
