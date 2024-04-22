class Tile extends Being {
    int row;
    int col;
    String type;
  Tile(int i, int j, String t){
    super();
    row = i;
    col = j;
    size = 50;
    type = t;
    spawn();
    setShape(new Rectangle(position, size, size));
  }
  
  void update(){

  }
  
  void render(){
    
    if(type.equals("#")){
      fill(0);
    }else if(type.equals("<")){
      fill(255, 0, 0);
    }else if(type.equals(">")){
      fill(230, 0, 0);
    }else if(type.equals("F")){
      fill(0, 255, 0);
    }else{
      fill(255);
    }
    //noFill();
    stroke(255);
    rect(position.x, position.y, size, size);
  }
  
  void spawn(){
    //set the position of the rectangle based on the row and column 
    position = new PVector(col*size, row*size);
  }
}