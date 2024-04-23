class Robot extends Being {
  int row;
  int col;
  Gif img;
  boolean emerging;
  int falling;
  PVector gravity;



  Robot(int i, int j, Gif img) {
    super();
    row = i;
    col = j;
    emerging = true;
    falling = 0;
    size = 50;
    gravity = new PVector(0,3);
    //img = loadImage("assets/solid.png");
    this.img = img;
    spawn();
    setShape(new Rectangle(position, size, size));
  }

  void update() {
    position.add(velocity);
    if(!emerging) {
      velocity = new PVector(0,3);
      falling++;
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
}
