class SwingTile extends Tile {

  float startX;
  float startY;
  float targetX;
  float targetY;
  Robot current;
  float angle;
  float magnitude;
  boolean jumping;
  float jump;

  SwingTile(int i, int j) {
    super(i, j, "#");
    current = null;
    jump = 20;
  }

  void update() {
    super.update();
    if (current == null) return;

    if (jumping) {
      current.position.y -= 2;
      if(current.position.y <= startY - jump) jumping = false;
    } else {
      if ((current.facingRight && current.position.x >= targetX) ||(!current.facingRight && current.position.x <= targetX)) {

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
    super.render();
  }


  void setStartingAngle() {
    jumping = true;
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
