class DoubleScreen extends Screen {

  Screen bgScreen;

  DoubleScreen(Screen bgScreen) {
    super(null);
    this.bgScreen = bgScreen;
  }

  @Override
  void render(){
    bgScreen.render();
    super.render();
  }


}