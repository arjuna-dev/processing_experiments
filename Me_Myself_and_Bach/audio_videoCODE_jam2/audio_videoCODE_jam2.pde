
import processing.sound.*;
SoundFile file;
FFT fft;
AudioIn in;
int bands = 512;
float[] spectrum = new float[bands];

import ddf.minim.*;
Minim minim;
AudioInput theMic;

void setup() {
  background(255, 255, 255);
  size(1050, 400);


  noStroke();
  // Load a soundfile from the /data folder of the sketch and play it back
  file = new SoundFile(this, "/Users/i5/Documents/Processing/audio_videoCODE_jam/bach.mp3");
  file.play();

  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);

  // start the Audio Input
  in.start();

  // patch the AudioIn
  fft.input(file);

  minim = new Minim(this);
  minim.debugOn();

  // get a line in from Minim, default bit depth is 16
  theMic = minim.getLineIn(Minim.STEREO, 512);
}      

void draw() {
  background(255);
  fft.analyze(spectrum);
  noStroke();
  fill(random(255), random(255), random(255), 30);
  for (int i = 0; i < bands; i = i+10) {
    //int x = (i + frameCount); // % width ;
    // The result of the FFT is normalized
    //rect( x, height - spectrum[i]*height*200 , x, height);
    rect( i, height - spectrum[i]*height*300, i, height);
    rect( width - i, 0, i, spectrum[i]*height*300);
    rect( i, 0, i, spectrum[i]*height*300);
    rect( width - i, height - spectrum[i]*height*300, i, height);
  }
  stroke(0);
  for (int a = 0; a < theMic.bufferSize() - 1; a++)
  {

    line(width/2, height/2, theMic.left.get(a)*5000 + width/2, theMic.left.get(a+1)*5000 + height/2);
    line(width/2, height/2, theMic.right.get(a)*5000 + width/2, theMic.right.get(a+1)*5000 + height/2);
  }
}

void stop()
{
  // always close Minim audio classes when you are done with them
  theMic.close();
  minim.stop();
  super.stop();
}
