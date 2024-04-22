class Tile extends Being {

  int row;
  int col;
  String type;
  PImage img;

  Tile(int i, int j, String t){
    super();
    row = i;
    col = j;
    size = 50;
    type = t;
    //based on the type of tile, set the image
    if(type.equals("#")){
      img = loadImage("assets/solid.png");
    }else if(type.equals("<")){
      img = loadImage("assets/left.png");
    }else if(type.equals(">")){
      img = loadImage("assets/right.png");
    }else if(type.equals("F")){
      img = loadImage("assets/finish.png");
    }else{
      img = null;
    }
    spawn();
    setShape(new Rectangle(position, size, size));
  }
  
  void update(){

  }
  
  void render(){
    


    if(img != null){
      image(img, position.x, position.y, size, size);
    }
  }
  
  void spawn(){
    //set the position of the rectangle based on the row and column 
    position = new PVector(col*size, row*size);
  }
}