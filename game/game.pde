import gifAnimation.*;

final color yellow = #F5C825;
final color darkblue = #1217FF;
final color red = #E0022F;
final color green = #04C118;
final color grey = #313131;
final color white = #FFFFFF;

HashMap<String, Screen> mode;
Screen active;

Gif myAnimation;

void setup() {
  size(1000, 650);
  // frameRate(30);

  mode = new HashMap<String, Screen>();
  createGameStartScreen();
  createLevel(1);

  myAnimation = new Gif(this, "robotRun.gif");
  myAnimation.loop();
  //myAnimation.stop();
  //myAnimation.play();
  //myAnimation.ignoreRepeat();

  // createGameOverScreen();
  active = mode.get("gameStart");
}

void createGameStartScreen() {
  PImage img = loadImage("assets/startBackground.jpg");
  PImage title = loadImage("assets/Logo.png");
  Screen gameStart = new Screen(img);

  gameStart.register("assets", new Tile(50, 275, title, 450, 150));


  ButtonBeing start = new ButtonBeing("PLAY", grey, 30, new PVector(width/2-50, 250), white) {
    void act() {
      createLevel(1);
      active = mode.get("level1");
    }
  };

  ButtonBeing tut = new ButtonBeing("TUTORIAL", grey, 30, new PVector(width/2-80, 300), white) {
    void act() {
      createLevel(1);
      active = mode.get("level1");
    }
  };

  ButtonBeing quit = new ButtonBeing("QUIT", grey, 30, new PVector(width/2-50, 350), white) {
    void act() {
      exit();
    }
  };

  gameStart.register(start);
  gameStart.register(tut);
  gameStart.register(quit);
  mode.put("gameStart", gameStart);
}

void createGameOverScreen() {
  PImage img = loadImage("assets/startBackground.jpg");
  Screen gameOver = new Screen(img);
  gameOver.register(new TextBeing("GAME OVER", darkblue, 50, new PVector(width/2, height/2)));

  ButtonBeing restart = new ButtonBeing("play again", green, 30, new PVector(width/2, 110+height/2), red) {
    void act() {
      createLevel1();
      active = mode.get("level1");
    }
  };
  gameOver.register(restart);
  mode.put("gameOver", gameOver);
}

void createLevel1() {
  PImage img = loadImage("assets/background.jpg");
  Screen level1 = new Screen(img);
  //level1.register("Tiles" , new Tile(3, 0));

  //read a text file called Level1.txt
  String[] lines = loadStrings("Level1.txt");
  for (int i = 0; i < lines.length; i++) {
    String line = lines[i];
    for (int j = 0; j < line.length(); j++) {
      char c = line.charAt(j);
      if (c != ' ') {
        level1.register("Tiles", new Tile(i, j, c+""));
      }
    }
  }
  mode.put("level1", level1);
}

void createLevel(int number) {
  PImage img = loadImage("assets/background.jpg");
  Screen level = new Screen(img);
  //level1.register("Tiles" , new Tile(3, 0));
  HashMap<Character, PVector> tilePositions = new HashMap<Character, PVector>();

  //read a text file called Level1.txt
  String[] lines = loadStrings("Level" + number + ".txt");
  for (int i = 0; i < lines.length; i++) {
    String line = lines[i];
    for (int j = 0; j < line.length(); j++) {
      char c = line.charAt(j);
      switch(c) {
      case '#':
        level.register("Tiles", new Tile(i, j, c+""));
        break;
      case 'L':
        level.register("Tiles", new Tile(i, j, c+""));
        break;
      case 'R':
        level.register("Tiles", new Tile(i, j, c+""));
        break;
      case 'F':
        level.register("Tiles", new Tile(i, j, c+""));
        break;
      case 'S':
        level.register("Tiles", new SpawnTile(i, j, "#"+"", 4, 3, 1, this));
        break;
      case '<':
        level.register("Tiles", new Tile(i, j, c+""));
        break;
      case '>':
        level.register("Tiles", new Tile(i, j, c+""));
        break;
      case 'W':
        level.register("Tiles", new Tile(i, j, c+""));
        break;
      case 'T':
        tilePositions.put(c, new PVector(i, j));
        break;
      case 't':
        level.register("Tiles", new Tile(i, j, c+""));
        tilePositions.put(c, new PVector(i, j));
        break;
      case '8':
        level.register("Tiles", new Tile(i, j, "#"));
        level.register("Swings", new SwingTile(i,j));
        break;
      }
    }
  }
  print(tilePositions.get('T') + " " + tilePositions.get('t') + "\n");
  Teleporter tp = new Teleporter((int)tilePositions.get('T').x, (int)tilePositions.get('T').y, "T", tilePositions.get('t'));
  level.register("Tiles", tp);
  level.register("Teleporters", tp);
  RobotTileInteractor rti = new RobotTileInteractor();
  RobotTeleporterInteractor rtpi = new RobotTeleporterInteractor();
  RobotSwingInteractor rsi = new RobotSwingInteractor();
  level.addGroup("Robots");
  level.register("Robots", "Teleporters", rtpi);
  level.register("Robots", "Tiles", rti);
  level.register("Robots", "Swings", rsi);
  mode.put("level"+number, level);
}

//GAME LOOP
void draw() {
  //1. UPDATE
  active.update();

  //2. INTERACT
  active.interact();

  //3. RENDER
  active.render();

  image(myAnimation, 30, 30, 30, 30);
}
