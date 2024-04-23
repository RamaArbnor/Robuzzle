class Screen{
  Group<Being> everyone;
  HashMap<String, Group> groups;
  ArrayList<Interaction> interactions;
  color backgroundColor;
  PImage img;
  
  Screen(){
    everyone = new Group<Being>(this);  
    groups = new HashMap<String, Group>();
    interactions = new ArrayList<Interaction>();
    img = loadImage("assets/background.jpg");
  }
  
  void register(String groupName, Being b){
    if(groups.get(groupName) == null){
      groups.put(groupName, new Group<Being>(this));
    }
    groups.get(groupName).add(b);
    everyone.add(b);  
  }
  
  void register(Being b){
    everyone.add(b);  
  }
  
  void addGroup(String name){
    groups.put(name, new Group<Being>(this));
  }

  void register(String groupA, String groupB, Interactor interactor){
    interactions.add(new Interaction(groups.get(groupA), groups.get(groupB), interactor));
  }
  
  void remove(String group, Being b){
    everyone.remove(b);
    Group g = groups.get(group);
    g.remove(b);
    if(g.size() == 0) groups.remove(group, g);
    
  }
  
  void update(){
    for(int i=0; i<everyone.size(); i++){
      everyone.get(i).update();  
    }
  }
  
  void interact(){
    for(Interaction i : interactions){
      i.handleInteraction();  
    }
  }
  
  void render(){
    background(img);
    for(int i=everyone.size()-1; i>= 0; i--){
      everyone.get(i).render();  
    }
  }
}
