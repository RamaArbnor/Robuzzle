import gifAnimation.*;

final color yellow = #F5C825;
final color darkblue = #1217FF;
final color red = #E0022F;
final color green = #04C118;
final color grey = #313131;

HashMap<String, Screen> mode;
Screen active;

Gif myAnimation;

void setup(){
  size(1000, 650);
  // frameRate(30);

  mode = new HashMap<String, Screen>();
  createLevel1();
    
  myAnimation = new Gif(this, "robotRun.gif");
  myAnimation.loop();
  //myAnimation.stop();
  //myAnimation.play();
  //myAnimation.ignoreRepeat();
  
  // createGameOverScreen();
  active = mode.get("level1");
}

void createGameOverScreen() {
  Screen gameOver = new Screen();
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
  Screen level1 = new Screen();
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
  Screen level = new Screen();
  //level1.register("Tiles" , new Tile(3, 0));

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
        level.register("Tiles", new SpawnTile(i, j, c+"", 4, 2, 3));
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
        level.register("Tiles", new Tile(i, j, c+""));
        break;
      case 't':
        level.register("Tiles", new Tile(i, j, c+""));
        break;
      }
    }
  }
  mode.put("level"+number, level);
}

//GAME LOOP
void draw(){
  //1. UPDATE
  active.update();

  //2. INTERACT
  active.interact();

  //3. RENDER
  active.render();
  
  image(myAnimation, 30,30, 30, 30);

}
