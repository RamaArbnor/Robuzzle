abstract class Interactor<A extends Being, B extends Being>{

    Interactor(){}
    
    abstract boolean detect(A a, B b);
    abstract void resolve(A a, B b);
}

///////////////////////////////////////////////////////////////

class Interaction<A extends Being, B extends Being>{  
  Group<A> groupA;
  Group<B> groupB;
  Interactor<A,B> interactor;
  
  Interaction(Group<A> g1, Group<B> g2, Interactor<A,B> i){
    groupA = g1;
    groupB = g2;
    interactor = i;
  }
  
  void handleInteraction(){
    for(int i=0; i<groupA.size(); i++){
      for(int j=0; j<groupB.size(); j++){
        if(interactor.detect(groupA.get(i), groupB.get(j))){
          interactor.resolve(groupA.get(i), groupB.get(j));  
        }
      }
    }
  }
}
