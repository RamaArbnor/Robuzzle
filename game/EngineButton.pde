abstract class ButtonBeing extends TextBeing{
    color background;
    boolean wasPressed;
  
    ButtonBeing(String t, color c, float s, PVector p, color bgcol){
      super(t, c, s, p);  
      background = bgcol;
      wasPressed = false;
    }
    
    void render(){
      fill(background);
      rect(position.x, position.y, textWidth(text), size);
      super.render();
    }
    
    void update(){
      super.update();
      if(shape.contains(new PVector(mouseX, mouseY))){
        if(!mousePressed && wasPressed){
          act();
        }
        wasPressed = mousePressed;
      }
    }
    
    abstract void act();
}
