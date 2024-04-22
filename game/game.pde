final color yellow = #F5C825;
final color darkblue = #1217FF;
final color red = #E0022F;
final color green = #04C118;

HashMap<String, Screen> mode;
Screen active;
int score;

TextBeing gameScore;
TextBeing lifeScore;

Avatar pacman;

void setup(){
  size(600, 800);
  frameRate(30);
  pacman = new Avatar();
  gameScore = new TextBeing("Score: "+score, yellow, 30, new PVector(10,10));
  lifeScore = new TextBeing(getLifes(), red, 30, new PVector(10,30));
  score = 0;
  mode = new HashMap<String, Screen>();
  createLevel1();
  createGameOverScreen();
  active = mode.get("level1");
}

void createGameOverScreen(){
  Screen gameOver = new Screen(yellow);
  gameOver.register(new TextBeing("GAME OVER", darkblue, 50, new PVector(width/2, height/2)));
  gameOver.register(new TextBeing("Your Score is "+score, darkblue, 40, new PVector(width/2, 60+height/2)));
  ButtonBeing restart = new ButtonBeing("play again", green, 30, new PVector(width/2, 110+height/2), red){
    void act(){
      score = 0;
      pacman.life = 3;
      createLevel1();
      active = mode.get("level1");
    }    
  };
  gameOver.register(restart);
  mode.put("gameOver", gameOver);
}

void createLevel1(){
  Screen level1 = new Screen(darkblue);
  level1.register("cherry", new Food());
  level1.register("pacman", pacman);
  level1.register(gameScore);
  level1.register(lifeScore);
  level1.register("ghosts", new Ghost());
  level1.register("cherry", "pacman", new FoodAvatarInteractor());
  level1.register("ghosts", "pacman", new GhostAvatarInteractor());
  mode.put("level1", level1);
}

String getLifes(){
  String lifes ="";
  for(int i=0; i<pacman.life; i++){
    lifes +="@";  
  }
  return lifes;
}

//GAME LOOP
void draw(){
  
  //1. UPDATE
  active.update();
  
  //2. INTERACT
  active.interact();
  
  gameScore.setText("Score :"+score, yellow, 30);
  lifeScore.setText(getLifes(), red, 30);
  
  //3. RENDER
  active.render();
}
