import codeanticode.gsvideo.*;

GSCapture video;


int mem[][][];

void setup() {
  video = new GSCapture(this, 960, 544);


  size(video.width, video.height, P2D);


  mem = new int[height][width][height];

  video.play();

  background(0);
}

int dir = 1;
int pos = 1;

void draw() {

  //image(video, 0,0);




  int pos = frameCount%height;

  loadPixels();

  int idx= 0;

  for (int y = 0 ; y < height;y++) {
    for (int x = 0 ; x < width;x++) {
      idx = y*width+x;
      mem[pos][x][y] = video.pixels[idx];
    }
  }
  
  
  for (int y = 0 ; y < height;y++) {
    for (int x = 0 ; x < width;x++) {
      idx = y*width+x;
      pixels[idx] = mem[(y+pos)%height][x][y];
    }
  }
  
  


  stroke(0);
  strokeWeight(20);
  // noFill();
  // rect(0,0,width,height);
}


void captureEvent(GSCapture c) {
  c.read();
  c.loadPixels();
}

