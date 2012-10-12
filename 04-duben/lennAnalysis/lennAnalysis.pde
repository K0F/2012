PImage lenna;
PImage lennaBW;

float 
H[],S[],V[],
R[],G[],B[],
X[],Y[],Z[];

void setup() {
  lenna = loadImage("l_hires.jpg");
  lenna.loadPixels();
  

  H = new float[lenna.pixels.length];
  S = new float[lenna.pixels.length];
  V = new float[lenna.pixels.length];
  R = new float[lenna.pixels.length];
  G = new float[lenna.pixels.length];
  B = new float[lenna.pixels.length];


  X = new float[lenna.pixels.length];

  Y = new float[lenna.pixels.length];

  Z = new float[lenna.pixels.length];

  size(200, 200, P2D);
  
  int seed = (int)random(200000);
  noiseSeed(170990);
  println(seed);
}


void draw() {

 // filter(POSTERIZE,5);
  fastblur(g,(int)(noise(frameCount/50.0)*20.0));
  
  loadPixels();
  
  int X = (int)(noise(frameCount/300.0,0)*noise(frameCount/10000.0,0)*lenna.width*2);
  int Y = (int)(noise(0,frameCount/900.0)*noise(frameCount/12000.0,0)*lenna.height*2);
  
  for (int y = 0 ; y < height;y++) {
    for (int x = 0 ; x < width;x++) {

      int i = y*width+x;

      int i2 = (Y+y)*lenna.width+(X+x);

      H[i] += (hue(lenna.pixels[i2]+pixels[i])-H[i])/3.0;
      S[i] += (saturation(lenna.pixels[i2])-S[i])/9.3;
      V[i] += (brightness(lenna.pixels[i2]+pixels[i])-V[i])/180.4;
      
    
      
         float sigma = 255-InvSqrt(H[i]*H[i]+S[i]*S[i]+V[i]*V[i]);
      
      /*
      R[i] += red(lenna.pixels[i])/30.0;
      G[i] += green(lenna.pixels[i])/30.0;
      B[i] += blue(lenna.pixels[i])/30.3;

      float sigma = InvSqrt(H[i]*H[i]+S[i]*S[i]+V[i]*V[i]); 
      float sigma2 = InvSqrt(R[i]*R[i]+G[i]*G[i]+B[i]*B[i]);

      X[i] += (InvSqrt(H[i]*H[i]+S[i]*S[i]))/10.0;
      Y[i] += (InvSqrt(S[i]*S[i]+V[i]*V[i]))/2.0;
      Z[i] += (InvSqrt(H[i]*H[i]+V[i]*V[i]))/12.0;
      
      float theta = InvSqrt(X[i]+X[i]*Y[i]*Y[i]+Z[i]*Z[i]);
      
      
*/
      stroke(
     sigma,
      
      noise(frameCount/60.0)*40.7);
      point(x, y);
    }
  }
  
  
  //PImage tmp = lenna;
  //PImage maska = g;
  //tmp.mask(maska);
  
  //lenna.mask(tmp);
  //image(tmp,sin(frameCount/6.0)*20.0,0);
  
  //image(tmp,0,0);
 // blend(lenna,X,Y,width,height,0,0,width,height,LIGHTEST);
  blend(lenna,X,Y,width,height,0,0,width,height,OVERLAY);
  //filter(GRAY);
  
  //blend(g,X,Y,width,height,0,0,width,height,BLEND);
  
  //saveFrame("/home/kof/render/lenna/fram#####.png");
}

