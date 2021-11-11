public static double det(PVector p1, PVector p2, PVector p3) {
  PVector a = PVector.sub(p2, p1);
  PVector b = PVector.sub(p3, p1);
  
  return a.x * b.y - b.x * a.y;
}

public static double det(PVector a, PVector b) {
  return a.x * b.y - b.x * a.y;
}

public static PVector intersect(PVector p1, PVector p2, PVector p3, PVector p4) {
  float a1 = p2.y - p1.y;
  float b1 = p1.x - p2.x;
  float c1 = a1 * p1.x + b1 * p1.y;

  float a2 = p4.y - p3.y;
  float b2 = p3.x - p4.x;
  float c2 = a2 * p3.x + b2 * p3.y;
  
  float delta = a1 * b2 - a2 * b1;
  
  if (delta == 0)
    return null;
  
  return new PVector(
    (b2 * c1 - b1 * c2) / delta,
    (a1 * c2 - a2 * c1) / delta
  );
}

class Anchor {
  PVector p0;
  PVector p1;
  PVector p2;
  PVector t0;
  PVector t2;
  PVector miterPt;
  float size = 10.0;

  public Anchor(PVector a, PVector b, PVector c) {
    this.p0 = a;
    this.p1 = b;
    this.p2 = c;
    
    // Computing the normal lines
    t0 = PVector.sub(b, a).rotate(HALF_PI);
    t2 = PVector.sub(c, b).rotate(HALF_PI);
    
    if(det(p0, p1, p2) > 0) {
      t0.mult(-1);
      t2.mult(-1);
    }
    
    // Normalize and multiply by the weight
    t0.normalize().mult(size);
    t2.normalize().mult(size);
    
    // find the miter point by finding the interception the lines formed by the normals
    // respective to the points of each segment
    PVector intersect = intersect(PVector.add(t0, p0), PVector.add(t0, p1), PVector.add(t2, p1), PVector.add(t2, p2));
    
    if(intersect != null) {
      miterPt = intersect.copy(); //.sub(b);
    }
  }
  
  void draw() {
    drawLines();
  }
  
  private void drawLines() {
    PVector a0 = PVector.add(t0, p0);
    PVector a1 = PVector.add(t0, p1);
    PVector a2 = PVector.add(t2, p1);
    PVector a3 = PVector.add(t2, p2);
    
    // color(0, 255, 0);
    stroke(0, 0, 255);
    line(p0.x, p0.y, p1.x, p1.y);
    line(p1.x, p1.y, p2.x, p2.y);
    
    if (miterPt != null) {
      stroke(255, 0, 0);
      line(p1.x, p1.y, miterPt.x, miterPt.y);
      
      stroke(0, 255, 0);
      line(a0.x, a0.y, miterPt.x, miterPt.y);
    }
    
    stroke(0);
    line(p0.x, p0.y, a0.x, a0.y);
    noStroke();
  }
  
  private void drawPoints() {
    noStroke();
    fill(0, 255, 0);
    ellipse(p0.x, p0.y, 4, 4);
    fill(0, 255, 0);
    ellipse(p1.x, p1.y, 4, 4);
    fill(0, 255, 0);
    ellipse(p2.x, p2.y, 4, 4);
    
    PVector a0 = PVector.add(t0, p0);
    fill(0, 0, 255);
    ellipse(a0.x, a0.y, 4, 4);
    
    PVector a1 = PVector.add(t0, p1);
    fill(0, 0, 255);
    ellipse(a1.x, a1.y, 4, 4);
    
    if (miterPt != null){
      fill(0, 0, 0);
      ellipse(miterPt.x, miterPt.y, 6, 6);
    }
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
    
    if(SIZE > 2){
      initializeMids();
      
      mids.set(0, nodes.get(0).pos);
      mids.set(SIZE-2, nodes.get(SIZE-1).pos);
      
      // println(mids.size(), nodes.size(), "\n");
      // Create anchors
      for(int i = 1; i < SIZE - 2; i++) {
        anchors.add(new Anchor(mids.get(i-1), nodes.get(i).pos, mids.get(i)));
      }
      
      for(Anchor a: anchors) {
        a.draw();
      }
    }
  }
  
  private void initializeMids() {
    if (mids != null) { mids.clear(); }

    final int SIZE = nodes.size();
      
    for(int i = 0; i < SIZE - 1; i++) {
      mids.add(PVector.add(nodes.get(i).pos, nodes.get(i+1).pos).mult(0.5f));
    }
  }
}
