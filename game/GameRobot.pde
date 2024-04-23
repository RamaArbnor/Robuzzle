
class Robot extends Being {
  int row;
  int col;
  Gif img;
  boolean emerging;
  int falling;
  boolean walking;
  PVector gravity;
  boolean facingRight;
  boolean swinging;
  boolean teleporting;
  boolean selected;
  String state;
  boolean isHovered;
  boolean wasPressed;
  int explodeTimer;


  Robot(int i, int j, boolean faceRight, Gif img) {
    super();
    row = i;
    col = j;
    emerging = true;
    swinging = false;
    teleporting = false;
    walking = false;
    wasPressed = false;
    falling = 0;
    size = 50;
    facingRight = true;
    gravity = new PVector(0, 3);
    selected = false;
    //img = loadImage("assets/solid.png");
    this.img = img;
    spawn();
    setShape(new Rectangle(position, size, size));
    facingRight = faceRight;
    state = "Normal";
  }

  void update() {

    if (this.shape.contains(new PVector(mouseX, mouseY))) {
      if (!mousePressed && wasPressed) {
        selected = true;
        selecting = true;
        selectedRobot = this;
        stopSpawns();
      }
      wasPressed = mousePressed;
    }

    //on robot hover make a grey outline
    if (this.shape.contains(new PVector(mouseX, mouseY))) {
      isHovered = true;
    } else {
      isHovered = false;
    }

    if (position.x > width || position.y > height) {
      //active.remove("Robots", this);
      destroyMe();
      return;
    }

    if (swinging || teleporting) return;
    if (state.equals("Explode") && falling <= 3) {
      explodeTimer--;
      if(explodeTimer <= 0) explode();
      return;
    }
    walking = false;
    position.add(velocity);
    // println("Falling for " + falling);

    if (!emerging) {
      velocity = new PVector(0, 3);
      falling += 3;

      // if the state is bridge, make bridge on the current tile after falling a bit
      if (state.equals("Bridge") && falling > 30 && falling < 40) {
        falling = 0;
        bridge();
      }
    }

    if (emerging && position.y <= (row-1)*size) {
      emerging = false;
    }
  }

  void render() {
    if (isHovered) {
      stroke(100);
      strokeWeight(3);
      noFill();
      rect(position.x, position.y, size, size);
    }

    if (selected) {
      stroke(0, 255, 0);
      strokeWeight(3);
      noFill();
      rect(position.x, position.y, size, size);
    }

    push();

    if (!facingRight) {
      translate(position.x + 40, position.y + 20);
      scale(-1, 1);
    } else {
      translate(position.x + 10, position.y + 20);
      scale(1, 1);
    }

    image(img, 0, 0, 30, 30);
    pop();
  }

  void spawn() {
    //set the position of the rectangle based on the row and column
    position.x = col*size;
    position.y = row*size;
    velocity = new PVector(0, -1);
  }

  boolean detect(Tile t) {
    if (emerging) return false;

    int row = (int)position.y/50;
    int col = (int)position.x/50;
    if ((facingRight && col == t.col && (row == t.row || row + 1 == t.row)) || (!facingRight && col + 1  == t.col && (row == t.row || row + 1 == t.row))) {
      // Check tile type
      return true;
    }
    return false;
  }

  // become a tile by taking the position, dividing by 50 and adding a new tile in that position
  void bridge() {
    int row = (int)position.y / 50;
    int col = (int)position.x / 50;

    if (!facingRight) col++;

    Tile t = new Tile(row + 1, col, "B");
    active.register("Tiles", t);
    //active.remove("Robots", this);
    destroyMe();
  }

  void explode() {
    int row = (int)position.y / 50 + 1;
    float tempCol = position.x / 50;
    int col = Math.round(tempCol);

    for (int i = active.groups.get("Tiles").size()-1; i >= 0; i--) {
      Tile t = (Tile) active.groups.get("Tiles").get(i);

      if (t.col == col && t.row == row && (t.type.equals("B") || t.type.equals("#") || t.type.equals("L") || t.type.equals("R"))) {
        active.remove("Tiles", t);
        break;
      }
    }

    for (int i = active.groups.get("Robots").size() - 1; i >= 0; i--) {
      if(i >= active.groups.get("Robots").size()) continue;
      Robot r = (Robot) active.groups.get("Robots").get(i);

      if (r.position.dist(position) < 51) {
        //active.remove("Robots", r);
        r.destroyMe();
      }
    }
  }
  
  void destroyMe(){
    active.remove("Robots", this);
    checkLevelFailure();
  }
}
