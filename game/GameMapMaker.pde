import javax.swing.JOptionPane;
class MapMaker extends Being {

  //a 2d array of tiles  
  Tile[][] tiles;
  PImage[] tileIcons;
  PApplet parent;
  boolean wasPressed = false;
  Teleporter teleporter;
  MapMaker(PApplet parent) {
    super(new PVector(0, 0), new PVector(0, 0), 0);
    this.parent = parent;
    tiles = new Tile[13][20];
    for (int i = 0; i < tiles.length; i++) {
      for (int j = 0; j < tiles[0].length; j++) {
        tiles[i][j] = new Tile(i, j, " ");
      }
    }
    // String[] tileTypes = {" ", "#", "L", "R", "<", ">", "W", "T", "t", "8", "F", "S"};

    tileIcons = new PImage[10];
    tileIcons[0] = loadImage("assets/solid.png");
    tileIcons[1] = loadImage("assets/leftSolid.png");
    tileIcons[2] = loadImage("assets/rightSolid.png");
    tileIcons[3] = loadImage("assets/turnLeft.png");
    tileIcons[4] = loadImage("assets/turnRight.png");
    tileIcons[5] = loadImage("assets/wall.png");
    tileIcons[6] = loadImage("assets/teleporterEntry.png");
    tileIcons[7] = loadImage("assets/swingIcon.png");
    tileIcons[8] = loadImage("assets/finish.png");
    tileIcons[9] = loadImage("assets/start.png");


    selectedTile = tileTypes[1];
  }

  void update() {
    for (int i = 0; i < tiles.length; i++) {
      for (int j = 0; j < tiles[0].length; j++) {
        // tiles[i][j].update();
        if (tiles[i][j].isHovered()) {
          tiles[i][j].isHovered = true;
        } else {
          tiles[i][j].isHovered = false;
        }
        if ((selectedTile.equals("t") && !mousePressed && wasPressed) || (!selectedTile.equals("t") && mousePressed)) {
          changeTile(i, j);
        }
      }
    }
    wasPressed = mousePressed;
  }

  void render() {
    for (int i = 0; i < tiles.length; i++) {
      for (int j = 0; j < tiles[0].length; j++) {
        tiles[i][j].render();
      }
    }
    // String[] tileTypes = {" ", "#", "L", "R", "<", ">", "t"};
    //draw a small icon image next to cursor to show what tile is selected
    switch(selectedTile) {
    case "#":
      image(tileIcons[0], mouseX + 20, mouseY, 20, 20);
      break;
    case "L":
      image(tileIcons[1], mouseX + 20, mouseY, 20, 20);
      break;
    case "R":
      image(tileIcons[2], mouseX + 20, mouseY, 20, 20);
      break;
    case "<":
      image(tileIcons[3], mouseX + 20, mouseY, 20, 20);
      break;
    case ">":
      image(tileIcons[4], mouseX + 20, mouseY, 20, 20);
      break;
    case "W":
      image(tileIcons[5], mouseX + 20, mouseY, 20, 20);
      break;
    case "T":
      image(tileIcons[6], mouseX + 20, mouseY, 20, 20);
      break;
    case "t":
      image(loadImage("assets/teleporterDest.png"), mouseX + 20, mouseY, 20, 20);
      break;
    case "8":
      image(tileIcons[7], mouseX + 20, mouseY, 20, 20);
      break;
    case "F":
      image(tileIcons[8], mouseX + 20, mouseY, 20, 20);
      break;
    case "S":
      image(tileIcons[9], mouseX + 20, mouseY, 20, 20);
      break;
    }
  }

  void changeTile(int i, int j) {

    if ((!selectedTile.equals("t") && tiles[i][j].isHovered && isMapMaker)) {


      if ((!selectedTile.equals("t"))) {
        if (selectedTile.equals("#")) {
          tiles[i][j] = new Tile(i, j, selectedTile);
          tiles[i][j].img = loadImage("assets/solid.png");
        } else if (selectedTile.equals("L")) {
          tiles[i][j] = new Tile(i, j, selectedTile);
          tiles[i][j].img = loadImage("assets/leftSolid.png");
        } else if (selectedTile.equals("R")) {
          tiles[i][j] = new Tile(i, j, selectedTile);
          tiles[i][j].img = loadImage("assets/rightSolid.png");
        } else if (selectedTile.equals("W")) {
          tiles[i][j] = new Tile(i, j, selectedTile);
          tiles[i][j].img = loadImage("assets/wall.png");
        } else if (selectedTile.equals("<")) {
          tiles[i][j] = new Tile(i, j, selectedTile);
          tiles[i][j].img = loadImage("assets/turnLeft.png");
        } else if (selectedTile.equals(">")) {
          tiles[i][j] = new Tile(i, j, selectedTile);
          tiles[i][j].img = loadImage("assets/turnRight.png");
        } else if (selectedTile.equals("t") && !tiles[i][j].type.equals("T")) {
          tiles[i][j] = new Tile(i, j, selectedTile);
          teleporter.dest = new PVector(i, j);
          tiles[i][j].img = loadImage("assets/teleporterDest.png");
          selectedTile = " ";
        } else if (selectedTile.equals("S")) {
          println("mrena");
          setTile(i, j, "S");
        } else if (selectedTile.equals("T")) {
          setTile(i, j, "T");
        } else if (selectedTile.equals("F")) {
          setTile(i, j, "F");
        } else if (selectedTile.equals("8")) {
          tiles[i][j] = new SwingTile(i, j, parent);
        } else if (selectedTile.equals(" ")) {
          tiles[i][j] = new Tile(i, j, selectedTile);
        }
      }
    } else if (selectedTile.equals("t") && tiles[i][j].isHovered && isMapMaker) {
      tiles[i][j] = new Tile(i, j, selectedTile);
      teleporter.dest = tiles[i][j].position;
      // teleporter.dest = new PVector(i, j);
      tiles[i][j].img = loadImage("assets/teleporterDest.png");
      selectedTile = " ";
    }
  }


  void setTile(int i, int j, String type) {
    if (type.equals("S")) {
      String countString = JOptionPane.showInputDialog("Enter how many robots to spawn:");
      if (countString == null) {
        mousePressed = false;
        selectedTile = " ";
        return;
      }
      try {
        Integer.parseInt(countString);
      }
      catch (Exception e) {
        countString = "4";
      }
      String delayString = JOptionPane.showInputDialog("Enter seconds to wait before spawning:");
      if (delayString == null) {
        mousePressed = false;
        selectedTile = " ";
        return;
      }
      try {
        Integer.parseInt(delayString);
      }
      catch (Exception e) {
        delayString = "2";
      }
      String intervalString = JOptionPane.showInputDialog("Enter seconds between spawns:");
      if (intervalString == null) {
        mousePressed = false;
        selectedTile = " ";
        return;
      }
      try {
        Integer.parseInt(intervalString);
      }
      catch (Exception e) {
        intervalString = "2";
      }

      String rightString = JOptionPane.showInputDialog("Enter Right or Left for the direction of the robots:");
      if (rightString == null) {
        mousePressed = false;
        selectedTile = " ";
        return;
      }
      try {
        rightString.toUpperCase().charAt(0);
      }
      catch (Exception e) {
        rightString = "R";
      }

      int count = Integer.parseInt(countString);
      int delay = Integer.parseInt(delayString);
      int interval = Integer.parseInt(intervalString);
      boolean right = rightString.toUpperCase().charAt(0) == 'R';

      tiles[i][j] = new SpawnTile(i, j, type, delay, interval, count, right, parent);
      //createa new processing window to get user input and set the values of the spawn tile
    } else if (type.equals("T")) {
      teleporter = new Teleporter(i, j, type, new PVector());
      tiles[i][j] = teleporter;
      selectedTile = "t";
    } else if (type.equals("F")) {
      println("mrenasadfsdff");

      String count = JOptionPane.showInputDialog("Please, enter how many robots to finish the game:");
      if (count == null) {
        mousePressed = false;
        selectedTile = " ";
        return;
      }
      try {
        Integer.parseInt(count);
      }
      catch (Exception e) {
        count = "1";
      }
      tiles[i][j] = new FinishTile(i, j, Integer.parseInt(count));
    }
    try {
    }
    catch (Exception e) {
    }
    mousePressed = false;
    selectedTile = selectedTile.equals("t")? "t": " ";
  }
}
