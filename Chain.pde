class Chain{
  ArrayList<Node> nodes = new ArrayList<Node>();
  float subR;
  float off = 0;
  float len;
  float index;
  
  Chain(float len, float subR){
    this.len = len;
    this.subR = subR;
  }
  
  void add(PVector p, PVector n){
    nodes.add(new Node(p, n));
    index++;
  }
  
  void show(){
    if(nodes.size() > 0){
      Node prevNode = nodes.get(0);      
    }
  }
}
