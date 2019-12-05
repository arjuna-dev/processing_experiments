class Shape{
  
  int x;
  
  Shape(int y){
    x = y;  
  }
  
  void makeTriangle(){
      triangle(x, 0, 50+x, -50, 50+x, 50);
    }
  
  void makeInvertedTriangle(){
        beginShape();
        vertex(x, 0);
        vertex(x, -50); 
        vertex(x+50, 0); 
        vertex(x, 50); 
        //vertex(x-50, 0); 
        vertex(x, -50); 
        endShape();
  }
  
  void makeLine(){
    stroke(100);
    line(0, 0, x+50, x+50);
  }
  
  void makeCircle(){
    circle(x, x, 50);
  }
  
}
