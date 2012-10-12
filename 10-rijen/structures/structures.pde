void setup() {
  size(1280, 720, P2D);
  frameRate(50);
  
  noiseSeed(7);
}


void draw() {

  loadPixels();

  float X = width/2;//noise(frameCount/3000.0, 0)*width;
  float Y = height/2;//noise(0, frameCount/3000.0)*height;

  for (int i = 0 ; i < pixels.length;i++) {
    pixels[i] += (lerpColor(pixels[i], color(random(2.0)), dist(X, Y, i%width, i/(float)width)/1000.0)-pixels[i])/300.0;
  }

  //filter(GRAY);
  // filter(OPAQUE);
  blend(g, 0, 0, width, height, -1, -1, width, height, MULTIPLY);
  //blend(g,0,0,width,height,0,0,width-1,height-1,ADD);
  fastblur(g, 2);



  //filter(POSTERIZE, 3);

  pushMatrix();
  translate(X, Y);
  rotate(frameCount/300000.0);
  translate(-X, -Y);
  tint(-1, 10000);
  g.filter(GRAY);
  //fastblur(g,2);
  image(g, 1, -1);//noise(frameCount/2000.0,0)/30.0,noise(0,frameCount/2000.0)/30.0);

  popMatrix();


  for (int i = 0 ; i < pixels.length;i++) {
    pixels[i] = color(255-brightness(pixels[i]));//(lerpColor(pixels[i], color(random(2.0)), dist(X, Y, i%width, i/(float)width)/100.0)-pixels[i])/300.0;
  }

  for (int y = 0 ; y < height;y++) {
    for (int x = width/2 ; x < width;x++) {
      int idx= y*width+x;
      int idx2= y*width+(width-x);
      pixels[idx] = pixels[idx2];
    }
  }
  
  //fastblur(g,3);
  //filter(THRESHOLD,0.5);


  saveFrame("/home/kof/render/someStructures/fr#####.tga");
}

