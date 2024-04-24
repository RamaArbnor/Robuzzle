abstract class ButtonBeing extends TextBeing{
    color background;
    boolean wasPressed;
    color hoveredColor;
  
    ButtonBeing(String t, color c, float s, PVector p, color bgcol){
      super(t, c, s, p);  
      background = bgcol;
      hoveredColor = bgcol - 100;
      wasPressed = false;
    }
    
    void render(){
      noStroke();
      fill(background);
      // textSize(size);
      rect(position.x-10, position.y, textWidth(text)+20, size+10, 20);
      super.render();
    }
    
    void update(){
      super.update();
      if(shape.contains(new PVector(mouseX, mouseY))){
        //if the mouse is over the button make the background lighter
        background = hoveredColor;


        if(!mousePressed && wasPressed){
          act();
        }
        wasPressed = mousePressed;
      }else{
        background = hoveredColor + 100;
      }
    }
    
    abstract void act();
}
