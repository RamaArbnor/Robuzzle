final color yellow = #F5C825;
final color darkblue = #1217FF;
final color red = #E0022F;
final color green = #04C118;

HashMap<String, Screen> mode;
Screen active;

void setup(){
  size(1000, 650);
  // frameRate(30);

  mode = new HashMap<String, Screen>();
  createLevel1();
  // createGameOverScreen();
  active = mode.get("level1");
}

void createGameOverScreen(){
  Screen gameOver = new Screen(yellow);
  gameOver.register(new TextBeing("GAME OVER", darkblue, 50, new PVector(width/2, height/2)));
  gameOver.register(new TextBeing("Your Score is "+score, darkblue, 40, new PVector(width/2, 60+height/2)));
  ButtonBeing restart = new ButtonBeing("play again", green, 30, new PVector(width/2, 110+height/2), red){
    void act(){
      createLevel1();
      active = mode.get("level1");
    }    
  };
  gameOver.register(restart);
  mode.put("gameOver", gameOver);
}

void createLevel1(){
  Screen level1 = new Screen(darkblue);

  mode.put("level1", level1);
}

//GAME LOOP
void draw(){
  
  //1. UPDATE
  active.update();
  
  //2. INTERACT
  active.interact();
  
  //3. RENDER
  active.render();
}
