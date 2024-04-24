import gifAnimation.*;
import processing.sound.*;

final color yellow = #F5C825;
final color darkblue = #1217FF;
final color red = #E0022F;
final color green = #04C118;
final color grey = #313131;
final color white = #FFFFFF;

HashMap<String, Screen> mode;
Screen active;
int currentLevel;

Gif myAnimation;

boolean selecting;
SelectionMenu menu;
Robot selectedRobot;

SoundFile levelMusic;
SoundFile tpSound;
SoundFile explosionSound;
SoundFile placeSound;
SoundFile swingSound;

void setup() {
  size(1000, 650);
  noSmooth();
  // frameRate(30);
  selecting = false;
  menu = new SelectionMenu();
  mode = new HashMap<String, Screen>();
  levelMusic = new SoundFile(this, "sounds/level.mp3");
  tpSound = new SoundFile(this, "sounds/teleport.mp3");
  explosionSound = new SoundFile(this, "sounds/explosion.wav");
  placeSound = new SoundFile(this, "sounds/place.mp3");
  swingSound = new SoundFile(this, "sounds/swing.mp3");
  createGameStartScreen();
  createGameOverScreen();
  createLevelCompletedScreen();
  // createLevel(1);

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



  ButtonBeing start = new ButtonBeing("PLAY", grey, 30, new PVector(width/2-50, 250), white) {
    void act() {
      createLevel(1);
      active = mode.get("level1");
      currentLevel = 1;
    }
  };

  ButtonBeing tut = new ButtonBeing("TUTORIAL", grey, 30, new PVector(width/2-80, 300), white) {
    void act() {
      createLevel(1);
      active = mode.get("level1");
    }
  };

  ButtonBeing lvSelect = new ButtonBeing("SELECT LV", grey, 30, new PVector(width/2-80, 350), white) {
    void act() {
      createLevelSelectionScreen();
      active = mode.get("levelSelection");
    }
  };

  ButtonBeing quit = new ButtonBeing("QUIT", grey, 30, new PVector(width/2-50, 400), white) {
    void act() {
      exit();
    }
  };

  gameStart.register(tut);
  gameStart.register(quit);
  gameStart.register(lvSelect);
  gameStart.register("assets", new Tile(50, 275, title, 450, 150));
  gameStart.register(start);

  mode.put("gameStart", gameStart);
}

void createGameOverScreen() {
  DoubleScreen gameOver = new DoubleScreen(active);
  PImage title = loadImage("assets/gameOver.png");
  textSize(30);
  ButtonBeing tut = new ButtonBeing("RESTART", grey, 30, new PVector((width - textWidth("RESTART") - 20)/2, 300), white) {
    void act() {
      levelMusic.stop();
      createLevel(currentLevel);
      active = mode.get("level" + currentLevel);
    }
  };

  ButtonBeing quit = new ButtonBeing("MAIN MENU", grey, 30, new PVector((width - textWidth("MAIN MENU") - 20)/2, 350), white) {
    void act() {
      levelMusic.stop();
      active = mode.get("gameStart");
    }
  };
  gameOver.register(tut);
  gameOver.register(quit);
  gameOver.register("assets", new Tile(50, 275, title, 450, 150));

  mode.put("gameOver", gameOver);
  active = gameOver;
}

boolean isLastLevel(int level){
  int nextLevel = level + 1;
  return loadStrings("maps/Level" + nextLevel + ".txt") == null 
  || loadStrings("maps/Level" + nextLevel + "_meta.txt") == null;

}

void createLevelCompletedScreen(){
  DoubleScreen next = new DoubleScreen(active);
  PImage title = loadImage("assets/levelComplete.png");

  textSize(30);
  if(!isLastLevel(currentLevel)){
    ButtonBeing restart = new ButtonBeing("NEXT LEVEL", grey, 30, new PVector((width - textWidth("NEXT LEVEL") - 20)/2, 250), white) {
      void act() {
        currentLevel += 1;
        levelMusic.stop();
        createLevel(currentLevel);
        active = mode.get("level" + currentLevel);
      }
    };
    next.register(restart);
  }
  ButtonBeing tut = new ButtonBeing("RESTART", grey, 30, new PVector((width - textWidth("RESTART") - 20)/2, 300), white) {
    void act() {
      levelMusic.stop();
      createLevel(currentLevel);
      active = mode.get("level" + currentLevel);
    }
  };

  ButtonBeing quit = new ButtonBeing("MAIN MENU", grey, 30, new PVector((width - textWidth("MAIN MENU") - 20)/2, 350), white) {
    void act() {
      levelMusic.stop();
      active = mode.get("gameStart");
    }
  };

  next.register(tut);
  next.register(quit);
  next.register("assets", new Tile(50, 275, title, 450, 150));

  active = next;
}



void createLevel(int number) {
  PImage img = loadImage("assets/background.jpg");
  levelMusic.play();
  levelMusic.amp(0.04);
  levelMusic.amp(0.04);
  Screen level = new Screen(img);
  //level1.register("Tiles" , new Tile(3, 0));
  HashMap<Character, PVector> tilePositions = new HashMap<Character, PVector>();
  ArrayList<PVector> tpsPos = new ArrayList<PVector>();
  ArrayList<PVector> tpDestPos = new ArrayList<PVector>();


  //read a text file called Level1.txt
  String[] lines = loadStrings("maps/Level" + number + ".txt");
  String[] meta = loadStrings("maps/Level" + number + "_meta.txt");
  int currentMeta = 0;
  level.addGroup("Robots"); 
  level.addGroup("Swings");
  level.addGroup("Tiles");
  level.addGroup("Walls");
  level.addGroup("Teleporters");
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
        int destinationCount = Integer.parseInt(meta[currentMeta].trim());
        level.register("Destinations", new FinishTile(i, j, destinationCount));
        currentMeta++;
        break;
      case 'S':
        String[] spawnMeta = meta[currentMeta].split("_");
        int delay = Integer.parseInt(spawnMeta[0]);
        int interval = Integer.parseInt(spawnMeta[1]);
        int count = Integer.parseInt(spawnMeta[2]);
        level.register("Tiles", new SpawnTile(i, j, "S"+"", delay, interval, count, spawnMeta[3].equals("R"), this));
        currentMeta++;
        break;
      case '<':
        level.register("Tiles", new Tile(i, j, c+""));
        break;
      case '>':
        level.register("Tiles", new Tile(i, j, c+""));
        break;
      case 'W':
        level.register("Walls", new Tile(i, j, c+""));
        break;
      case 'T':
        tilePositions.put(c, new PVector(i, j));
        tpsPos.add(new PVector(i,j));
        break;
      case 't':
        level.register("Tiles", new Tile(i, j, c+""));
        tilePositions.put(c, new PVector(i, j));
        tpDestPos.add(new PVector(i,j));
        break;
      case '8':
        level.register("Tiles", new Tile(i, j, ""));
        level.register("Swings", new SwingTile(i, j, this));
        break;
      }
    }
  }
  
  if(tpsPos.size() > 0 && tpsPos.size() == tpDestPos.size()){
    for(int i = 0; i < tpsPos.size(); i++){
      int destination = Integer.parseInt(meta[currentMeta]);
      Teleporter tp = new Teleporter((int)tpsPos.get(i).x, (int)tpsPos.get(i).y, "T", tpDestPos.get(destination));
      
      level.register("Teleporters", tp);
      currentMeta++;
    }  
  }

  //if (tilePositions.get('T') != null) {
  //  Teleporter tp = new Teleporter((int)tilePositions.get('T').x, (int)tilePositions.get('T').y, "T", tilePositions.get('t'));
  //  level.register("Tiles", tp);
  //  level.register("Teleporters", tp);
  //}
  RobotTileInteractor rti = new RobotTileInteractor();
  RobotWallInteractor rwi = new RobotWallInteractor();
  RobotRobotInteractor rri = new RobotRobotInteractor();
  RobotTeleporterInteractor rtpi = new RobotTeleporterInteractor();
  RobotSwingInteractor rsi = new RobotSwingInteractor();
  RobotDestinationInteractor rdi = new RobotDestinationInteractor();

  level.register("Robots", "Teleporters", rtpi);
  level.register("Robots", "Tiles", rti);
  level.register("Robots", "Swings", rsi);
  level.register("Robots", "Walls", rwi);
  level.register("Robots", "Robots", rri);
  level.register("Robots", "Destinations", rdi);
  mode.put("level"+number, level);
}

void createLevelSelectionScreen() {
  PImage img = loadImage("assets/startBackground.jpg");
  Screen levelSelection = new Screen(img);

  //create a grid 3x2 of buttons for levels

  int x = 120;
  int y = 100;
  int w = 200;
  int h = 100;

  int levelCount = 0;
  while(true){
    if(loadStrings("maps/Level" + (levelCount+1) + ".txt") == null || loadStrings("maps/Level" + (levelCount+1) + "_meta.txt") == null)  break;
    levelCount++;
  }

  for (int i = 1; i <= levelCount; i++) {
    final int index = i;
    ButtonBeing level = new ButtonBeing(i+"", grey, 40, new PVector(x, y), white, 30) {
      void act() {
        createLevel(index);
        active = mode.get("level"+index);
        currentLevel = index;
      }
    };
    levelSelection.register(level);
    x += width/4;
    if (i % 4 == 0) {
      x = 120;
      y += 150;
    }
  }

  textSize(30);
  ButtonBeing back = new ButtonBeing("BACK", grey, 30, new PVector(width/2-50, 500), white) {
    void act() {
      active = mode.get("gameStart");
    }
  };

  levelSelection.register(back);

  mode.put("levelSelection", levelSelection);
}

//GAME LOOP
void draw() {
  if(!selecting) {

  //1. UPDATE
  active.update();

  //2. INTERACT
  active.interact();
  }

  //3. RENDER
  active.render();
  
  

  if(selecting){
    menu.update();
    menu.render();
  }
  image(myAnimation, 30, 30, 30, 30);
}

void stopSpawns(){
  Group tiles = active.groups.get("Tiles");
  for(int i = 0; i < tiles.size(); i++){
    Being t = tiles.get(i);
    if(t instanceof SpawnTile){
      ((SpawnTile) t).stop();
    }
  }
}
void startSpawns(){
  Group tiles = active.groups.get("Tiles");
  for(int i = tiles.size() -1; i >= 0; i--){
    Being t = tiles.get(i);
    if(t instanceof SpawnTile){
      ((SpawnTile) t).start();
    }
  }
}
void checkLevelCompletion(){
  Group destinations = active.groups.get("Destinations");
  boolean levelFinished = true;
  for(int i = 0; i < destinations.size(); i++){
    if(((FinishTile)destinations.get(i)).count > 0){
      levelFinished = false;
      break;
    }
  }
  if(levelFinished){
    println("BRAVOOOO");
    createLevelCompletedScreen();
    
  }
}
void checkLevelFailure(){
  Group robots = active.groups.get("Robots");
  int robotsCount = 0;
  if(robots != null) robotsCount = robots.size();
  Group allTiles = active.groups.get("Tiles");
  int robotsToBeSpawned = 0;
  for(int i = 0; i < allTiles.size(); i++){
    Being t = allTiles.get(i);
    if(t instanceof SpawnTile && ((SpawnTile)t).count > 0){
      robotsToBeSpawned += ((SpawnTile)t).count;
    }
  }
  
  Group destinations = active.groups.get("Destinations");
  int robotsToArrive = 0;
  for(int i = 0; i < destinations.size(); i++){
    if(((FinishTile)destinations.get(i)).count > 0){
      robotsToArrive += ((FinishTile)destinations.get(i)).count;
    }
  }
  
  if(robotsCount+robotsToBeSpawned < robotsToArrive){
    println("DESHTAK"); 
    createGameOverScreen(); 
  }
  
}
