abstract class ButtonBeing extends TextBeing {
  color background;
  boolean wasPressed;
  color hoveredColor;
  int padding;

  ButtonBeing(String t, color c, float s, PVector p, color bgcol) {
    super(t, c, s, p);
    background = bgcol;
    hoveredColor = bgcol - 100;
    wasPressed = false;
    this.padding = 20;
  }

  ButtonBeing(String t, color c, float s, PVector p, color bgcol, int padding) {
    super(t, c, s, p);
    background = bgcol;
    hoveredColor = bgcol - 100;
    wasPressed = false;
    this.padding = padding;
  }

  void render() {
    noStroke();
    fill(background);
    textSize(size);
    rect(position.x - padding / 2, position.y, textWidth(text) + padding, size + padding / 2, padding);
    super.render();
  }

  void update() {
    super.update();
    if (shape.contains(new PVector(mouseX, mouseY))) {
      //ifthe mouse is over the button make the background lighter
      background = hoveredColor;


      if (!mousePressed && wasPressed) {
        act();
      }
      wasPressed = mousePressed;
    } else {
      background = hoveredColor + 100;
    }
  }

  abstract void act();
}
