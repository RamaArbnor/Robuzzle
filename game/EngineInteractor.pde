abstract class Interactor<A extends Being, B extends Being> {

  Interactor() {
  }

  abstract boolean detect(A a, B b);
  abstract void resolve(A a, B b);
}

///////////////////////////////////////////////////////////////

class Interaction<A extends Being, B extends Being> {
  Group<A> groupA;
  Group<B> groupB;
  Interactor<A, B> interactor;

  Interaction(Group<A> g1, Group<B> g2, Interactor<A, B> i) {
    groupA = g1;
    groupB = g2;
    interactor = i;
  }

  void handleInteraction() {

    for (int i=groupA.size()-1; i>=0; i--) {
      if (i >= groupA.size()) i = groupA.size()-1;
      for (int j=groupB.size()-1; j>=0; j--) {
        if (j >= groupB.size()) j = groupB.size()-1;
        if (interactor.detect(groupA.get(i), groupB.get(j))) {
          interactor.resolve(groupA.get(i), groupB.get(j));
        }
      }
    }
  }
}
