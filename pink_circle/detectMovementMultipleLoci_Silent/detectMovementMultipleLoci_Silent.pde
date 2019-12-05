
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
    //presenceSum += diffR + diffG + diffB;
    presenceSum += diffR;
    
    //if (presenceSum > maxPresenceSum) {
    //  maxPresenceSum=presenceSum;
    //}
    
    if (presenceSum > 30) {
      accumPixels += 1;
    } else {
      accumPixels = 0;
    }
    
    if (accumPixels > 10) {
      triggered = true;
      callMethod = true;
      triggeredPixel=i-15;
    }

    presenceSum = 0;
  }
  
  arrayCopy(video.pixels, previousFrame);

  //println("maxPresenceSum", maxPresenceSum);

  triggeredX = triggeredPixel % video.width;
  triggeredY = triggeredPixel / video.width;
  
  //println("presenceSum: ", presenceSum);
  //println("triggeredPixel: ",triggeredPixel);
  //println("triggeredX: ", triggeredX);
  //println("triggeredY: ", triggeredY);
  
  //translate(triggeredX,triggeredY);
  if (triggered == true){
    if(callMethod==true){
      //playSound();
      callMethod=false;
    }
    shapes.add(new Shape(triggeredX, triggeredY));
    //if (frameCount>f){
    //  if(shapes.size()<shapesAmount){
    //    shapes.add(new Shape());
    //    f=frameCount+8;
    //    shapeCount++;
    //  }
    //}
  }
  
  for(int k=0;k<=shapes.size()-1;k++){
    shapes.get(k).create();
    shapes.get(k).move(); 
    if (shapes.get(k).alphaVal<0){
      shapes.remove(k);
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


void playSound() {
  for (int i=0; i < 3; i++) {  
      value[i]=int(random(255));
  }
  
  int random = int(random(22));
  
  println(random);
 
  switch(random){
  case 1:
    file[0].play(0.5, 1.0);
    break;

  case 2:
    file[1].play(0.5, 1.0);
    break;
  
  case 3:
    file[2].play(0.5, 1.0);
    break;
  
  case 4:
    file[3].play(0.5, 1.0);
    break;
  
  case 5:
    file[4].play(0.5, 1.0);
    break;
  
   case 6:
    file[0].play(1.0, 1.0);
    break;
   
   case 7:
    file[1].play(1.0, 1.0);
    break;

   case 8:
    file[2].play(1.0, 1.0);
    break;
    
   case 9:
    file[3].play(1.0, 1.0);
    break;
    
   case 10:
    file[4].play(1.0, 1.0);
    break;
    
   case 11:
    file[0].play(2.0, 1.0);
    break;
    
   case 12:
    file[1].play(2.0, 1.0);
    break;
   
   case 13:
    file[2].play(2.0, 1.0);
    break;    
   
   case 14:
    file[3].play(2.0, 1.0);
   break;
   
   case 15:
    file[4].play(2.0, 1.0);
   break; 
   
   case 16:
    file[0].play(3.0, 1.0);
    break;
    
   case 17:
    file[1].play(3.0, 1.0);
    break;
   
   case 18:
    file[2].play(3.0, 1.0);
    break;    
   
   case 19:
    file[3].play(3.0, 1.0);
   break;
   
   case 20:
    file[4].play(3.0, 1.0);
    break;
   
   case 21:
    file[0].play(4.0, 1.0);
    break;    
   
   case 22:
    file[1].play(4.0, 1.0);
   break;   
  }
}
