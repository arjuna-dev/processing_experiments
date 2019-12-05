import processing.sound.*;
SoundFile file;

//fft stuff
FFT fft;
AudioIn in;
int bands = 512;
float[] spectrum = new float[bands];

//normal stuff
ArrayList <Triangle> triangles = new ArrayList <Triangle>();
int f = 0;
int j = 0;
int freq = 9;
int numberOfShapes = 100;
int speed = 1;
float hm = 0;

float maxVal = 0;
float newVal = 0;

//Setup
void setup() {
  size(600, 600);
  background(31);
  noStroke();
  colorMode(HSB, 100);

  // Load a soundfile from the /data folder of the sketch and play it back
  file = new SoundFile(this, "sample.mp3");
  file.play();

  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);

  //Give input
  fft.input(file);

}

void draw() {
  fft.analyze(spectrum);

  background(noise(hm+=0.001)*100, 80, 100, 80);
  translate(width/2, height/2);

  //Add triangle if low frequency has enough amplitude
  if (spectrum[1]>0.30) {
    triangles.add(new Triangle(speed));
  }

  for (int k=0; k<triangles.size(); k++) {
    triangles.get(k).create();
    triangles.get(k).move();
    triangles.get(k).colorize();
  }

  //Delete old objects (out of bounds)
  for (int i=0; i<triangles.size()-1; i++) {
    if (triangles.get(i).x>width/2+100) {
      triangles.remove(i);      
    }
  }
  
  //Frequency visualizer sample
  //translate(-width/2, -height/2);
  //int selectedBands = bands/20; 
  //int barSize = width/selectedBands;
  //for (int h=0; h<selectedBands; h++) {
  //  fill(31);
  //  rect(h*barSize, height-spectrum[h]*300,h*barSize+barSize, height);
  //}
  
  //Frequency visualizer mic
  //translate(-width/2, -height/2);
  //int selectedBands = bands/1; 
  //int barSize = width/selectedBands;
  //for (int h=0; h<selectedBands; h++) {
  //  fill(31,31,31,81);
  //  rect(h*barSize, height-theMic.left.get(h)*300,h*barSize+barSize, height);
  //}
}
