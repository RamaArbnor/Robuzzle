class Group<B extends Being>{
  ArrayList<B> collection;
  Screen owner;
  
  Group(Screen screen){
    collection = new ArrayList<B>(); 
    owner = screen;
  }
  
  void add(B being){
    if(!collection.contains(being)){
      collection.add(being);
      //owner.register(being);
    }
  }
  
  void remove(B being){
    collection.remove(being);  
  }
  
  void empty(){
    collection.clear();  
  }
  
  B get(int i){
    if(collection.size() == 0 && i >= collection.size()) return null;
    return collection.get(i);  
  }
  
  int getIndex(B being){
    return collection.indexOf(being);  
  }
  
  int size(){
    if(collection == null) return 0;
    return collection.size();
  }
  
}
