class Triangle{
  
Shape sh;
  
  int x;
  float noisecalator;
  float noiseval;
  float figNumber;
  float speed;
  float squeak;
  float numberOfFigs;
  float rndmy;
  //void[] shapes = {new Shape(), 150, 30 }; 
  
  Triangle(float speedInput){
    x = 0;
    noisecalator = random(5)*0.001;
    noiseval = 0;
    figNumber = random(3, 10);
    speed = speedInput;
    squeak = random(1000);
    numberOfFigs  = random(6, 21);
    rndmy = int(random(3));
  }
  
  void create(){
    fill(noise(noiseval)*100, 80, 100, 80);
    for (float c=-TWO_PI; c<TWO_PI; c+=TWO_PI/numberOfFigs) {
      pushMatrix();
      rotate(c+squeak);
      
      if (rndmy==0){
        sh = new Shape(x);
        sh.makeCircle();
      } else if (rndmy==1) {
        sh = new Shape(x);
        sh.makeTriangle();
      } else {
        sh = new Shape(x);
        sh.makeInvertedTriangle();
      }
      popMatrix();
      }
  }
 
  void move(){
    x+=speed;
  }
  
  void colorize(){
    noiseval = noiseval + noisecalator;
  }

}
