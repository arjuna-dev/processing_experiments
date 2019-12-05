import processing.video.*;
color white = color(255,255,255);
color red = color(255,0,0,20);
color blue = color(21,21,250);
color thePixel;
int x = 0;
int y = 0;
int z = 0;

Capture cam;

void setup() {
  size(1280, 480);

  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();     
  }      
}

void draw() {
  background(31);
  if (cam.available() == true) {
    cam.read();
  }

  image(cam, 0, 0);
  
  loadPixels();
  
  for(int i=0; i<width*height;i++){
    thePixel = pixels[width*mouseY+mouseX];
  }
  
  for(int i=0; i<width*height;i++){
    if((red(pixels[i])<red(thePixel)+25&&red(pixels[i])>red(thePixel)-25)&&
    (blue(pixels[i])<blue(thePixel)+25&&blue(pixels[i])>blue(thePixel)-25)&&
    (green(pixels[i])<green(thePixel)+25&&green(pixels[i])>green(thePixel)-25)){
    x++;
    noStroke();
    colorMode(HSB);
    //pixels[i]=red;
    //color it = color (x,100,100);
    pixels[i]=red;
    }
      
  }

  updatePixels();

  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
}
