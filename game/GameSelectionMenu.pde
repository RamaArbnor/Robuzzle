class SelectionMenu { //<>// //<>// //<>//
  PVector pos;
  PVector size;
  boolean wasPressed;
  PImage explode;
  PImage bridge;
  PImage swing;
  PImage teleport;
  SelectionMenu() {
    pos = new PVector(300, 250);
    size = new PVector(400, 100);
    wasPressed = false;
    explode = loadImage("assets/explosionIcon.png");
    bridge = loadImage("assets/bridgeIcon.png");
    swing = loadImage("assets/swingIcon.png");
    teleport = loadImage("assets/teleportIcon.png");
  }

  void update() {
    checkMouse();
  }

  void render() {
    // draw a big rectangle in the middle of the screen with 4 other smaller rectangles inside it
    fill(51);
    rect(pos.x, pos.y, size.x, size.y, 30);

    noStroke();
    image(explode, (size.x/4) * 0 + pos.x + 25, pos.y+25, 50, 50);

    image(bridge, (size.x/4) * 1 + pos.x + 25, pos.y+25, 50, 50);

    image(swing, (size.x/4) * 2 + pos.x + 25, pos.y+25, 50, 50);

    image(teleport, (size.x/4) * 3 + pos.x + 25, pos.y+25, 50, 50);
  }

  // make a function that will check if the mouse is over the rectangle and if it is clicked
  void checkMouse() {
    if (mouseX > pos.x && mouseX < pos.x + size.x && mouseY > pos.y && mouseY < pos.y + size.y) {
      if (!mousePressed && wasPressed) {
        if (mouseX > (size.x/4) * 0 + pos.x + 25 && mouseX < (size.x/4) * 0 + pos.x + 25 + 50 && mouseY > pos.y+10 && mouseY < pos.y+10 + 50) {
          // selectedRobot.state = "Explode";
          selectedRobot.changeState("Explode");
          selectedRobot.explodeTimer = 60;
          selectedRobot.selected = false;
          selecting = false;
          startSpawns();
        }
        if (mouseX > (size.x/4) * 1 + pos.x + 25 && mouseX < (size.x/4) * 1 + pos.x + 25 + 50 && mouseY > pos.y+10 && mouseY < pos.y+10 + 50) {
          // selectedRobot.state = "Bridge";
          selectedRobot.changeState("Bridge");
          selectedRobot.selected = false;
          selecting = false;
          println("2");
          startSpawns();
        }
        if (mouseX > (size.x/4) * 2 + pos.x + 25 && mouseX < (size.x/4) * 2 + pos.x + 25 + 50 && mouseY > pos.y+10 && mouseY < pos.y+10 + 50) {
          // selectedRobot.state = "Swing";
          selectedRobot.changeState("Swing");
          selectedRobot.selected = false;
          selecting = false;
          println("3");
          startSpawns();
        }
        if (mouseX > (size.x/4) * 3 + pos.x + 25 && mouseX < (size.x/4) * 3 + pos.x + 25 + 50 && mouseY > pos.y+10 && mouseY < pos.y+10 + 50) {
          // selectedRobot.state = "Teleport";
          selectedRobot.changeState("Teleport");
          selectedRobot.selected = false;
          selecting = false;
          println("4");
          startSpawns();
        }
      }
      wasPressed = mousePressed;
    }
  }
}
