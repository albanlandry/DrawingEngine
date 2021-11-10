class Anchor {
  PVector p0;
  PVector p1;
  PVector p2;

  public Anchor(PVector a, PVector b, PVector c) {
    this.p0 = a;
    this.p1 = b;
    this.p2 = c;
    
    // Computing the normal lines
  }
}

class Chain{
  private ArrayList<Node> nodes = new ArrayList<Node>();
  private ArrayList<PVector> mids = new ArrayList<PVector>();
  private ArrayList<Anchor> anchors = new ArrayList<Anchor>();
  
  void add(PVector p){
    nodes.add(new Node(p));
    // initializeMids();
    // initializeAnchors();
  }
  
  void draw(){
    final int SIZE = nodes.size();
    
    if(SIZE > 1){
      initializeMids();
      
      mids.set(0, nodes.get(0).pos);
      mids.set(SIZE-2, nodes.get(SIZE-1).pos);
      
      // Create anchors
      for(int i = 0; i < SIZE - 2; i++) {
        anchors.add(new Anchor(mids.get(i-1), nodes.get(i).pos, mids.get(i)));
      }
    }
  }
  
  private void initializeMids() {
    final int SIZE = nodes.size();
      
    for(int i = 1; i < SIZE; i++) {
      mids.add(PVector.add(nodes.get(i-1).pos, nodes.get(i).pos));
    }
  }
}
