class Tile extends Being {

  int row;
  int col;
  String type;
  PImage img;
  int w;
  int h;

  Tile(int i, int j, String t){
    super();
    row = i;
    col = j;
    size = 50;
    type = t;
    //based on the type of tile, set the image
    if(type.equals("#")){
      img = loadImage("assets/solid.png");
    }else if(type.equals("L")){
      img = loadImage("assets/leftSolid.png");
    }else if(type.equals("R")){
      img = loadImage("assets/rightSolid.png");
	}else if(type.equals("W")){
	  img = loadImage("assets/wall.png");
    }else if(type.equals("<")){
      img = loadImage("assets/turnLeft.png");
    }else if(type.equals(">")){
      img = loadImage("assets/turnRight.png");
	}else if(type.equals("t")){
	  img = loadImage("assets/teleporterDest.png");
    }else if(type.equals("F")){
      img = loadImage("assets/finish.png");
    }else{
      img = null;
    }
    spawn();
    setShape(new Rectangle(position, size, size));
  }

  Tile(int x, int y, PImage img, int w, int h){
    super();
    row = x;
    col = y;
    this.w = w;
    this.h = h;
    this.img = img;
    type = "I";
    spawnImage();
    // setShape(new Rectangle(position, size, size));
  }
  
  void update(){

  }
  
  void render(){
    
    if(img != null){
      if(type.equals("F")){
        image(img, position.x, position.y-30, size+30, size+30);
      }else if(type.equals("I")){
        image(img, position.x, position.y, w, h);
      }else{
        image(img, position.x, position.y, size, size);
      }
    }
  }
  
  void spawn(){
    //set the position of the rectangle based on the row and column 
    position = new PVector(col*size, row*size);
  }

  void spawnImage(){
    //set the position of the rectangle based on the row and column 
    position = new PVector(col, row);
  }
}
