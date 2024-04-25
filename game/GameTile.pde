class Tile extends Being {

  int row;
  int col;
  String type;
  PImage img;
  int w;
  int h;
  boolean isHovered = false;

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
	  }else if(type.equals("B")){
	    img = loadImage("assets/bridgeRobot.png");	
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
    //if the type is " " and is hovered by the mouse draw a trasparent rectangle on top of it
    changeTile(); 
    if(isHovered()){
      isHovered = true;
    }else{
      isHovered = false;
    }
  }

  boolean isHovered(){
    return mouseX > position.x && mouseX < position.x + size && mouseY > position.y && mouseY < position.y + size;
  }
  
  void render(){
    
    if(type.equals(" ") && isHovered){
      fill(51, 51, 51, 100);
      rect(position.x, position.y, size, size);
    }

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

  //if the mouse is pressed on the tile, change the type of the tile
  void changeTile(){
    if(mousePressed && isHovered){
      if(isHovered){
        if(selectedTile.equals("#")){
          type = "#";
          img = loadImage("assets/solid.png");
        }else if(selectedTile.equals("L")){
          type = "L";
          img = loadImage("assets/leftSolid.png");
        }else if(selectedTile.equals("R")){
          type = "R";
          img = loadImage("assets/rightSolid.png");
        }else if(selectedTile.equals("W")){
          type = "W";
          img = loadImage("assets/wall.png");
        }else if(selectedTile.equals("<")){
          type = "<";
          img = loadImage("assets/turnLeft.png");
        }else if(selectedTile.equals(">")){
          type = ">";
          img = loadImage("assets/turnRight.png");
        }else if(selectedTile.equals("t")){
          type = "t";
          img = loadImage("assets/teleporterDest.png");
        }
      }
    }
  }
  }

