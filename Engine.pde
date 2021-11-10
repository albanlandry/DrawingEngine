class Engine2D {
  int mWidth= 0;
  int mHeight = 0;
  float mRatio = 0.0f;
  
  Engine2D(int w, int h) {
    mWidth = w;
    mHeight = h;
    mRatio = float(w) / float(h);
    
  }
  
  void init() {
    noStroke();
  }
  
  void render() {
    fill(255);
    rect(0, 0, mWidth, mHeight);
  }
}
