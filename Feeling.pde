class FeelingObject {
  
  String feeling;
  String sentence;
  
  PVector pos = new PVector();
  PVector tpos = new PVector();
  
  void update() {
    pos.x += (tpos.x - pos.x) * 0.1;
    pos.y += (tpos.y - pos.y) * 0.1;
    
    /*
    if (random(100) < 0.1) {
      tpos.x = random(width);
      tpos.y = random(height);
    }
    */
  }
  
  void render() {
    pushMatrix();
    
      translate(pos.x, pos.y);
      text(feeling, 0, 0);
    
    popMatrix();
  }
}
