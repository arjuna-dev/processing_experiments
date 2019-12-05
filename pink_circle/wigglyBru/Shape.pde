class Shape{

  float offsetX;
  float offsetY;
  float maxNoise;
  float z;
  float scaler;
  int   alphaVal;
  
  Shape(){
    maxNoise=1;
    z=0;
    scaler=0;
    alphaVal=255;
  }
  
  void create(){
    pushMatrix();
    scale(scaler);
    stroke(255,0,155,alphaVal);
    beginShape();
    for(float i=0; i<TWO_PI; i+=TWO_PI/360){
      offsetX = map(cos(i),-1,1,0,maxNoise);
      offsetY = map(sin(i),-1,1,0,maxNoise);
      float r = map(noise(offsetX, offsetY, z),0,1,1,200);
      float x = r*sin(i);
      float y = r*cos(i);
      vertex(x, y);
    }
    endShape(CLOSE);
    popMatrix();
  }
  
  void move(){
    alphaVal-=2;
    z+=0.007;
    scaler+=0.01;
  }

}
