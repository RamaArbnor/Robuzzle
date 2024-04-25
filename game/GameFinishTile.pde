class FinishTile extends Tile {

  PFont font;
  int count;
  
  FinishTile(int i, int j, int c){
    super(i,j,"F");
    count = c;
    font = createFont("Jersey10-Regular.ttf", 32);
  }
  
  void update(){
    super.update();
  }
  
  void render(){
    super.render();
    fill(200);
    push();
    textFont(font);
    textSize(60);
    text(""+count, position.x + size - 12, position.y+25);
    pop();
  }
  
}
