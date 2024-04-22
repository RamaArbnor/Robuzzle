class Robot extends Being {
  int row;
  int col;
  PImage img;
  boolean emerging;



  Robot(int i, int j) {
    super();
    row = i;
    col = j;
    emerging = true;
    size = 50;
    img = loadImage("assets/solid.png");
    spawn();
    setShape(new Rectangle(position, size, size));
  }

  void update() {
    position.add(velocity);
    if(emerging && position.y <= (row-1)*size){
      emerging = false;
      
    }
  }

  void render() {

    image(img, position.x, position.y, size, size);
  }

  void spawn() {
    //set the position of the rectangle based on the row and column
    position = new PVector(col*size, row*size);
    velocity = new PVector(0, -3);
  }
}
