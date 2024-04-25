class TextBeing extends Being {

  String text;
  color col;
  float size;

  TextBeing(String t, color c, float s, PVector p) {
    super();
    text = t;
    col = c;
    size = s;
    textSize(size);
    position = p;
    setShape(new Rectangle(position, textWidth(text), size));
  }

  void update() {
    position.add(velocity);
  }

  void setText(String t, color c, float s) {
    text = t;
    col = c;
    size = s;
  }

  void render() {
    fill(col);
    textSize(size);
    text(text, position.x, position.y + size);
  }
}
