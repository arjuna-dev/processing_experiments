
import processing.sound.*;
SoundFile file;
FFT fft;
AudioIn in;
int numberOfBands = 512;
int windowWidth = 1050;
int barWidth = windowWidth/numberOfBands;
float[] spectrum = new float[numberOfBands];

import ddf.minim.*;
Minim minim;
AudioInput theMic;

void setup() {
  background(255, 255, 255);
  size(1050, 400);
  // Load a soundfile from the /data folder of the sketch and play it back
  file = new SoundFile(this, "/Users/i5/Documents/Processing/audio_videoCODE_jam/bach.mp3");
  file.play();

  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, numberOfBands);
  in = new AudioIn(this, 0);

  // start the Audio Input
  in.start();

  // patch the AudioIn
  fft.input(in);


  //minim
  minim = new Minim(this);
  minim.debugOn();

  // get a line in from Minim, default bit depth is 16
  theMic = minim.getLineIn(Minim.STEREO, 512);
}      

void draw() {

  fft.analyze(spectrum);
  fill(random(255), random(255), random(255), 5);
  noStroke();
  
  for (int i = 0; i < numberOfBands; i = i+barWidth) 
    {
      rect( i, height - spectrum[i]*height*4000, i, height);
      rect( width - i, 0, i, spectrum[i]*height*4000);
      rect( i, 0, i, spectrum[i]*height*4000);
      rect( width - i, height - spectrum[i]*height*4000, i, height);
    }
  
  
  strokeWeight(1);
  
  if (abs(theMic.left.get(10)*3000)>35) {
      for (int a = 0; a < 50 - 1; a++) 
      {      
        stroke(0);
        line(width/2+200, height, theMic.left.get(a)*3000 + width/2+200 , height/2);
        stroke(255);
        line(width/2-200, height, theMic.right.get(a)*3000 + width/2-200 , height/2);
      }     
    }
}

void stop()
{
  // always close Minim audio classes when you are done with them
  theMic.close();
  minim.stop();
  super.stop();
}
