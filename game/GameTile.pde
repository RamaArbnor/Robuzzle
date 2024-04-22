class Tile extends Being {
    int row;
    int col;
    
  Tile(int i, int j){
    super();
    row = i;
    col = j;
    size = 50;
    spawn();
    setShape(new Rectangle(position, size, size));
  }
  
  void update(){

  }
  
  void render(){
    noFill();
    stroke(255);
    rect(position.x, position.y, size, size);
  }
  
  void spawn(){
    //set the position of the rectangle based on the row and column 
    position = new PVector(col*size, row*size);
  }
}