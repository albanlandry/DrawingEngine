class Node{
  PVector pos;
  PVector normal;
  float creationTime;
  
  Node() {
    this.pos = new PVector();
    this.normal = new PVector();
    creationTime = millis();
  }

  Node(PVector pos){
    this();
    this.pos = pos;
    this.normal = new PVector();
  }
  
  Node(PVector pos, PVector normal){
    this.pos = pos;
    this.normal = normal;
  }
  
  void draw() {
    
  }
}

/**
* Circle class
**/
class Circle extends Node {
  private static final int DEFAULT_SEGMENT = 8;
  float mRadius = 1.0f;
  private int mSegments;
  private float mAngle = 0.0f;
  
  Circle(PVector pos, float radius) {
    this(pos, radius, DEFAULT_SEGMENT);
  }
 
  Circle(PVector pos, float radius, int segments) {
    super(pos);
    this.mRadius = radius;
    setSegmentsNb(segments);
  }
  
  void draw() {
    
  }
  
  void setSegmentsNb(int num) {
    this.mSegments = num;
    this.mAngle = 2 * PI / float(this.mSegments);
  }
}


/**
* Segment class
**/
class Segment extends Node {
  private static final float DEFAULT_SIZE = 10.0;
  PVector start;
  PVector end;
  float mWidth;
  PVector a, b, c, d;
  
  Segment(PVector start, PVector end) {
    this(start, end, DEFAULT_SIZE);
    // this(start, end);
    // this.mWidth = size;
  }
  
  Segment(PVector start, PVector end, float size) {
    super();
    this.start = start;
    this.end = end;
    this.mWidth = size;
    
    this.pos = end.copy().sub(start);
    this.normal = new PVector(-this.pos.y, this.pos.x).normalize();
    
    a = start.copy().add(normal.copy().mult(mWidth/2));
    b = start.copy().add(normal.copy().mult(-mWidth/2));
    c = end.copy().add(normal.copy().mult(mWidth/2));
    d = end.copy().add(normal.copy().mult(-mWidth/2));
  }
  
  void drawStartPoint() {
    color(0);
    stroke(1);
    
    line(start.x, start.y, a.x, a.y);
    // line(start.x, start.y, b.x, b.y);
    
    
    noStroke();
    fill(255, 0, 0);
    ellipse(this.start.x, this.start.y, 5, 5);
  }
  
  void drawEndPoint() {    
    color(0);
    stroke(1);
    
    line(end.x, end.y, c.x, c.y);
    // line(end.x, end.y, d.x, d.y);
    
    noStroke();
    fill(255, 0, 0);
    ellipse(this.end.x, this.end.y, 5, 5);
  }
  
  void draw() {
    super.draw();
    
    /*
    a = start.copy().add(normal.copy().mult(mWidth/2));
    b = start.copy().add(normal.copy().mult(-mWidth/2));
    c = end.copy().add(normal.copy().mult(mWidth/2));
    d = end.copy().add(normal.copy().mult(-mWidth/2));
    */
    
    color(0);
    stroke(1);
    line(start.x, start.y, a.x, a.y);
    line(start.x, start.y, b.x, b.y);
    
    line(end.x, end.y, c.x, c.y);
    line(end.x, end.y, d.x, d.y);
    
    noStroke();
    fill(255, 0, 0);
    ellipse(this.start.x, this.start.y, 5, 5);
    ellipse(this.end.x, this.end.y, 5, 5);
    
    fill(55, 55, 255);
    triangle(a.x, a.y, b.x, b.y, c.x, c.y);
    triangle(b.x, b.y, c.x, c.y, d.x, d.y);
  }
}

class LineAnchor extends Node {
  
}
