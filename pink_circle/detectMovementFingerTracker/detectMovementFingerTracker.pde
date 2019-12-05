
ArrayList <Shape> shapes = new ArrayList <Shape>();
int f = 0;
int shapeCount = 0;
int shapesAmount  = 10;
boolean callMethod = true;
int[] previousFrame;
int numPixels;
int presenceSum;
int accumPixels = 0;
boolean triggered = false;
int triggeredPixel;
int triggeredX;
int triggeredY;
float maxPresenceSum=0;


import processing.sound.*;
import processing.video.*;
Capture video;

AudioDevice device;
SoundFile[] file;

// Define the number of samples 
int numsounds = 5;

int value[] = {0,0,0};

void setup(){
  size(640,480);
  noFill();
  frameRate(30);
  // This the default video input, see the GettingStartedCapture 
  // example if it creates an error
  video = new Capture(this, width, height);
  
  // Start capturing the images from the camera
  video.start();  
  numPixels = video.width * video.height;
  previousFrame = new int[numPixels];
  loadPixels();
  
  // Create a Sound renderer and an array of empty soundfiles
  device = new AudioDevice(this, 48000, 32);
  file = new SoundFile[numsounds];
  
  // Load 5 soundfiles from a folder in a for loop. By naming the files 1., 2., 3., n.aif it is easy to iterate
  // through the folder and load all files in one line of code.
  for (int i = 0; i < numsounds; i++){
    file[i] = new SoundFile(this, (i+1) + ".aif");
  }
}

void draw(){
  //background(31);
  if (video.available()) {
  video.read();
  }
  image(video, 0, 0, width, height);
  video.loadPixels();
  presenceSum = 0;
  for (int i=0;i<numPixels;i++){
    color currColor = video.pixels[i];
    color prevColor = previousFrame[i];
    //int range = 20;
    
    // Extract the red, green, and blue components of the current pixel's color
    float currR = red(currColor);
    float currG = green(currColor);
    float currB = blue(currColor);
    // Extract the red, green, and blue components of the background pixel's color
    float prevR = red(prevColor);
    float prevG = green(prevColor);
    float prevB = blue(prevColor);
    // Compute the difference of the red, green, and blue values
    float diffR = abs(currR - prevR);
    float diffG = abs(currG - prevG);
    float diffB = abs(currB - prevB);
    // Add these differences to the running tally
    presenceSum += diffR + diffG + diffB;
    
    //if (presenceSum > maxPresenceSum) {
    //  maxPresenceSum=presenceSum;
    //}
    
    if (presenceSum > 90) {
      accumPixels += 1;
    } else {
      accumPixels = 0;
    }
    
    if (accumPixels > 30) {
      triggered = true;
      callMethod = true;
      triggeredPixel=i-15;
    }
    
    //if (presenceSum > 90) {
    //  triggered = true;
    //  triggeredPixel=i;
    //}
    presenceSum = 0;
  }
  
  arrayCopy(video.pixels, previousFrame);

  println("maxPresenceSum", maxPresenceSum);

  triggeredX = triggeredPixel % video.width;
  triggeredY = triggeredPixel / video.width;
  
  //println("presenceSum: ", presenceSum);
  println("triggeredPixel: ",triggeredPixel);
  println("triggeredX: ", triggeredX);
  println("triggeredY: ", triggeredY);
  
  translate(triggeredX,triggeredY);
  if (triggered == true){
    if(callMethod==true){
      playSound();
      callMethod=false;
    }
    if (frameCount>f){
      if(shapes.size()<shapesAmount){
        shapes.add(new Shape());
        f=frameCount+8;
        shapeCount++;
      }
    }
  }
  
  for(int k=0;k<=shapes.size()-1;k++){
    shapes.get(k).create();
    shapes.get(k).move(); 
    if (shapes.get(k).alphaVal<0){
      shapes.remove(k);
      hasMouseClicked=false;
    }
  }  
  triggered = false;
}


boolean hasMouseClicked = false;
void mouseClicked(){
  hasMouseClicked=true;
  callMethod=true;
}

/*
This example shows how to make a simple sampler and sequencer with the Sound library. In this
sketch 5 different short samples are loaded and played back at different pitches, in this
case 5 different octaves. The sequencer triggers and event every 200-1000 mSecs randomly.
Each time a sound is played a colored rect with a random color is displayed.
*/


void playSound(){
  file[3].play(1.0, 0.1);
}

void keyPressed() {
  for (int i=0; i < 3; i++) {  
      value[i]=int(random(255));
  }
 
  switch(key){
  case 'a':
    file[0].play(0.5, 1.0);
    break;

  case 's':
    file[1].play(0.5, 1.0);
    break;
  
  case 'd':
    file[2].play(0.5, 1.0);
    break;
  
  case 'f':
    file[3].play(0.5, 1.0);
    break;
  
  case 'g':
    file[4].play(0.5, 1.0);
    break;
  
   case 'h':
    file[0].play(1.0, 1.0);
    break;
   
   case 'j':
    file[1].play(1.0, 1.0);
    break;

   case 'k':
    file[2].play(1.0, 1.0);
    break;
    
   case 'l':
    file[3].play(1.0, 1.0);
    break;
    
   case 'ö':
    file[4].play(1.0, 1.0);
    break;
    
   case 'ä':
    file[0].play(2.0, 1.0);
    break;
    
   case 'q':
    file[1].play(2.0, 1.0);
    break;
   
   case 'w':
    file[2].play(2.0, 1.0);
    break;    
   
   case 'e':
    file[3].play(2.0, 1.0);
   break;
   
   case 'r':
    file[4].play(2.0, 1.0);
   break; 
   
   case 't':
    file[0].play(3.0, 1.0);
    break;
    
   case 'z':
    file[1].play(3.0, 1.0);
    break;
   
   case 'u':
    file[2].play(3.0, 1.0);
    break;    
   
   case 'i':
    file[3].play(3.0, 1.0);
   break;
   
   case 'o':
    file[4].play(3.0, 1.0);
    break;
   
   case 'p':
    file[0].play(4.0, 1.0);
    break;    
   
   case 'ü':
    file[1].play(4.0, 1.0);
   break;   
  }
}
