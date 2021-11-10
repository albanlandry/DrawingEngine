Engine2D engine;
int WIDTH = 700;
int HEIGHT = 500;
Segment seg = new Segment(new PVector(50, 50), new PVector(400, 100), 50);
PVector prev;
ArrayList<Node> line = new ArrayList<Node>();
final float SPACING = 20.0;

void setup() {
  size(700, 500);
  engine = new Engine2D(width, height );
  engine.init();
  
  
  
}

void draw() {
  engine.render();
  
  for (Node n: line) {
    //fill(255);
    // rect(0, 0, width, height);
    // ((Segment)n).drawStartPoint();
    // ((Segment)n).drawEndPoint();
    n.draw();
  }
  
  /*
  if (seg.mWidth >= 100) { 
    seg.mWidth = 10;
  }else {
    seg.mWidth += 1;
  }
  seg.draw();
  */
}

float leftOverDistance = 0;

void mouseDragged() {
  PVector pos = new PVector(mouseX, mouseY);
    
  if (prev == null) {
    prev = pos.copy();
    return;
  } 
    
  float dist = PVector.dist(prev, pos);
  PVector direction = PVector.sub(pos, prev).normalize().mult(SPACING);
  
  // println("Distance", dist);
  if (dist >= SPACING ) {
    leftOverDistance += dist; 
    
    while(leftOverDistance > SPACING) {
      PVector currentPt = prev.copy().add(direction);  
      
      // Add a new segment with the previous point and the newly computed point
      Segment s = new Segment(prev, currentPt, 30);
      line.add(s);
      
      prev = currentPt.copy();
      leftOverDistance -= SPACING;
    }
  }
  
  
  /*
  if (dist >= SPACING) {
    Segment s = new Segment(prev, pos, 50);
    line.add(s);
    println("prev", prev);
    println("pos", pos);
    println();
    prev = pos.copy();
  }
  */
}
