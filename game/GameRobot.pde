
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


  Robot(int i, int j, Gif img) {
    super();
    row = i;
    col = j;
    emerging = true;
    swinging = false;
    walking = false;
    falling = 0;
    size = 50;
    facingRight = true;
    gravity = new PVector(0,3);
    //img = loadImage("assets/solid.png");
    this.img = img;
    spawn();
    setShape(new Rectangle(position, size, size));
  }

  void update() {
    if(position.x > width || position.y > height) {
      active.remove("Robots", this);
      return;
    }
    if(swinging) return;
    walking = false;
    position.add(velocity);
    if(!emerging) {
      velocity = new PVector(0,3);
      falling+=3;
    }
    if(emerging && position.y <= (row-1)*size){
      emerging = false;
    }
    
  }

  void render() {

    image(img, position.x + 10, position.y +20, 30, 30);
  }

  void spawn() {
    //set the position of the rectangle based on the row and column
    position = new PVector(col*size, row*size);
    velocity = new PVector(0, -1);
  }

  boolean detect(Tile t){
    if(emerging) return false;
    
    int row = (int)position.y/50;
    int col = (int)position.x/50;
    if ((facingRight && col == t.col && (row == t.row || row + 1 == t.row)) || (!facingRight && col + 1  == t.col && (row == t.row || row + 1 == t.row))) {
      // Check tile type
      return true;
    }
    return false;
  }
}
