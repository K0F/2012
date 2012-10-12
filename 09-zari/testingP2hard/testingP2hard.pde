/*
kof timestamp:
 Fri Sep 21 23:41:46 CEST 2012
  
  
  
 ,dPYb,                  ,dPYb,
 IP'`Yb                  IP'`Yb
 I8  8I                  I8  8I
 I8  8bgg,               I8  8'
 I8 dP" "8    ,ggggg,    I8 dP
 I8d8bggP"   dP"  "Y8ggg I8dP
 I8P' "Yb,  i8'    ,8I   I8P
 ,d8    `Yb,,d8,   ,d8'  ,d8b,_
 88P      Y8P"Y8888P"    PI8"8888
 I8 `8,
 I8  `8,
 I8   8I
 I8   8I
 I8, ,8'
 "Y8P'
 */
 
 
 
/////////////////////// RESOLUTION
 
float res = 3;
HashMap pnts;
 
/////////////////////// BASIC VARS
 
float X, Y, pX, pY;
 
/////////////////////// SETUP
 
void setup() {
 
  size(444, 333,P2D);
 
  colorMode(HSB);
 
  pnts = new HashMap();
 
  int cnt = 0;
 
  for (float y = 0;y<height;y+=res)
    for (float x = 0;x<width;x+=res) {
      pnts.put(cnt, new Pnt(new PVector(x, y)));
      cnt++;
    }
}
 
/////////////////////// DRAW
 
 
void draw() {
  /////////////////////// SLOW FADE
  fill(0, 200);
  noStroke();
  rect(0, 0, width, height);
 
  /////////////////////// CAMERA SHAKE
  translate((noise(frameCount/2.0, 0)-0.5)*10, (noise(0, frameCount/2.0)-0.5)*10);
 
  pX = X;
  pY = Y;
 
  X = mouseX;//noise(frameCount/30.0,0)*width;
  Y = mouseY;//noise(0,frameCount/30.0)*height;
 
 
  for (int i =0 ; i < pnts.size();i++) {
    Pnt tmp = (Pnt)pnts.get(i);
 
    tmp.update();
  }
 
  for (int i =0 ; i < pnts.size();i++) {
    Pnt tmp = (Pnt)pnts.get(i);
 
    tmp.draw();
  }
 
 
  /////////////////////// PIX EFFECTS
 //fastblur(g, 2);
 // blend(g, 0, 0, width, height, 0, 0, width, height, ADD);
  
 
 }
 
/////////////////////// CLASS DEFINITION
 
class Pnt {
  PVector bpos, pos, vel, acc, forward, back;
  float d;
 
  Pnt(PVector _pos) {
    bpos = new PVector(_pos.x, _pos.y);
    pos = new PVector(_pos.x, _pos.y);
 
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }
 
  void draw() {
 
    stroke(lerpColor(color(vel.mag()*22+120, 5, 255), #ffcc00, norm(atan2(vel.y-acc.y, vel.x-vel.x), -PI, PI)), 200-d);
    if (d<200 && vel.mag()<30.0) {
      //strokeWeight(constrain(vel.mag()/20.0,1.1,2));
      point(pos.x, pos.y);
    }
  }
 
  /////////////////////// DYNAMICS MOVEMENT DESCRIPTION
  void update() {
    d = dist(bpos.x, bpos.y, X, Y);
    forward = new PVector(X-bpos.x, Y-bpos.y);
    acc.add(forward);
 
    float sp = dist(X, Y, pX, pY);
    acc.mult(30.123/(d+sp));
 
    back = new PVector(bpos.x-pos.x, bpos.y-pos.y);
    acc.add(back);
    acc.mult(1/(d+0.00001));
    vel.add(acc);
    pos.add(vel);
 
    vel.mult(0.99-1/(d+1.001));
    acc.limit(100.0);
    vel.limit(100.0);
  }
}
 
 
/////////////////////// MODIFY AS YOU NEED!

/////////////////////// WONDERFULLY FAST BLUR TECHNIQUE BY QUASIMONDO
 
void fastblur(PGraphics img,int radius){
 
  if (radius<1){
    return;
  }
  int w=img.width;
  int h=img.height;
  int wm=w-1;
  int hm=h-1;
  int wh=w*h;
  int div=radius+radius+1;
  int r[]=new int[wh];
  int g[]=new int[wh];
  int b[]=new int[wh];
  int rsum,gsum,bsum,x,y,i,p,p1,p2,yp,yi,yw;
  int vmin[] = new int[max(w,h)];
  int vmax[] = new int[max(w,h)];
  int[] pix=img.pixels;
  int dv[]=new int[256*div];
  for (i=0;i<256*div;i++){
     dv[i]=(i/div);
  }
   
  yw=yi=0;
  
  for (y=0;y<h;y++){
    rsum=gsum=bsum=0;
    for(i=-radius;i<=radius;i++){
      p=pix[yi+min(wm,max(i,0))];
      rsum+=(p & 0xff0000)>>16;
      gsum+=(p & 0x00ff00)>>8;
      bsum+= p & 0x0000ff;
   }
    for (x=0;x<w;x++){
     
      r[yi]=dv[rsum];
      g[yi]=dv[gsum];
      b[yi]=dv[bsum];
 
      if(y==0){
        vmin[x]=min(x+radius+1,wm);
        vmax[x]=max(x-radius,0);
       }
       p1=pix[yw+vmin[x]];
       p2=pix[yw+vmax[x]];
 
      rsum+=((p1 & 0xff0000)-(p2 & 0xff0000))>>16;
      gsum+=((p1 & 0x00ff00)-(p2 & 0x00ff00))>>8;
      bsum+= (p1 & 0x0000ff)-(p2 & 0x0000ff);
      yi++;
    }
    yw+=w;
  }
   
  for (x=0;x<w;x++){
    rsum=gsum=bsum=0;
    yp=-radius*w;
    for(i=-radius;i<=radius;i++){
      yi=max(0,yp)+x;
      rsum+=r[yi];
      gsum+=g[yi];
      bsum+=b[yi];
      yp+=w;
    }
    yi=x;
    for (y=0;y<h;y++){
      pix[yi]=0xff000000 | (dv[rsum]<<16) | (dv[gsum]<<8) | dv[bsum];
      if(x==0){
        vmin[y]=min(y+radius+1,hm)*w;
        vmax[y]=max(y-radius,0)*w;
      }
      p1=x+vmin[y];
      p2=x+vmax[y];
 
      rsum+=r[p1]-r[p2];
      gsum+=g[p1]-g[p2];
      bsum+=b[p1]-b[p2];
 
      yi+=w;
    }
  }
 
}

