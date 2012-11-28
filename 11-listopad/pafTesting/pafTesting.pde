import processing.opengl.*;

import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
//import ddf.minim.effects.*;
//import ddf.minim.ugens.*;

import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

PGraphics img;

int crop = 50;

float sc = 200.0;
int detail = 3;

PeasyCam cam;
ArrayList[] vals;

Minim minim;
FFT fft;

AudioInput in;

PFont font, font2;


String txt = "aaaaaaaaaa";

void setup() {
  size(1280, 720, P3D);
  cam = new PeasyCam(this, 700);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(1000);

  font = loadFont("53Seed-8.vlw");
  font2 = loadFont("AllerDisplay-92.vlw");

  textFont(font, 8);
  textMode(SCREEN);



  minim = new Minim(this);

  //  jingle = minim.loadFile("siteUnseen.mp3", 2048);
  //vals = new float[1025];
  //jingle.play();

  in = minim.getLineIn(Minim.STEREO, 512);
  in.mute();


  vals = new ArrayList[(int)in.sampleRate()];
  for (int i = 0 ;i < vals.length;i++)
    vals[i] = new ArrayList();

  fft = new FFT(in.bufferSize(), in.sampleRate());



  img = createGraphics(fft.specSize(), fft.specSize()/2, P2D);

  change();
  noCursor();


  background(0);
}


void change() {
  img.beginDraw();
  img.background(0);
  img.textFont(font2);
  //img.textAlign(CENTER, CENTER);
  img.textMode(SCREEN);
  img.fill(255);

  //for(int i = 0 ; i < 4;i++)

  int pos = (int)random(txt.length());

  txt = txt.substring(0, pos)+(char)( ((txt.charAt(pos)+1)%(60)+60))+txt.substring(pos+1, txt.length());
  img.text(txt, 0, 0,300,img.height);
  
  
  img.endDraw();
}

void pruhy(){
  float shift = noise(frameCount/1200.0)*200;
  
  img.beginDraw();
  img.background(0);
  for(float i = -shift ; i <img.width;i+=15){
   img.strokeWeight(5);
   img.stroke(255);
   img.line(i,0,i+shift,img.height); 
  }
  
  img.endDraw();
  
}



void stop()
{
  // always close Minim audio classes when you are done with them
  in.close();
  minim.stop();

  super.stop();
}

boolean sw = true;

void draw() {
  background(0);
  
  
  if(frameCount%50==0)
  sw = !sw;
  
  if(sw)
  change();
  else
  pruhy();

  // image(img,0,0);

  // now draw things that you want relative to the camera's position and orientation
 /* cam.beginHUD();
  fill(255);
  text("noiseStudy :: kof", width-80, height-10);
  cam.endHUD();
*/
  float maxX[] = new float[3];
  float maxY[] = new float[3];

  float minX[] = new float[3];
  float minY[] = new float[3];


  float maxZ[] = new float[3];
  float minZ[] = new float[3];


  int cnt = 0;

  // for (int Z = -150;Z<=150;Z+=150) {

  maxX[cnt] = -1000;
  maxY[cnt] = -1000;
  minX[cnt] = 1000;
  minY[cnt] = 1000;
  maxZ[cnt] = -1000;
  minZ[cnt] = 1000;


  fft.forward(in.mix);


  float tras = 10.0;
  float trasx = (noise(millis()/30.0, 0, 0)-0.5)*tras;
  float trasy = (noise(0, millis()/30.0, 0)-0.5)*tras;
  float trasz = (noise(0, 0, millis()/30.0)-0.5)*tras;

  translate(-vals[0].size()/2+trasx, (-fft.specSize()-crop)/2+trasy, trasz);

  int cntr = 0;
  for (int y = crop ; y < fft.specSize(); y += 2) {
    float z = 0;

    int pos = y;//(int)map(y, 0, height/2, 0, fft.specSize());
    float val = fft.getBand(pos);
    vals[cntr].add(val);

    int ycnt =0;

    for (int x = 0 ; x < vals[0].size(); x += 1) {



      float V = (Float)vals[cntr].get(ycnt);

      z += (pow(V, 0.9)*100.0-z)/50.0;

      z += (
      (noise((x+frameCount)/sc+height/2,
      (y+frameCount)/sc+height/2,
      (Z+frameCount/sc)/sc)-0.5)*500.0-z
      )/3.0;
      
        if (minZ[cnt]>z) {
          minZ[cnt] = z;
          minX[cnt] = screenX(x, y, z+Z);
          minY[cnt] = screenY(x, y, z+Z);
        }

        if (maxZ[cnt]<z) {
          maxZ[cnt] = z;
          maxX[cnt] = screenX(x, y, z+Z);
          maxY[cnt] = screenY(x, y, z+Z);
        }


      int pixmappos = cntr*img.width+(ycnt/2);
      color c  = img.pixels[pixmappos];
      float bright = brightness(c);
      if (bright>3) {


      



        stroke(lerpColor(#ffffff, #ffcc00, constrain(map(z, -50, 50, 0, 1), 0, 1)), constrain((z+150)/1.2, 0, 255));
        //stroke(img.pixels[pixmappos], constrain(map(z, -200, 200, 0, 255), 0, 255));
        
       
        float sy = 0;//sin(((x|y)*z)/3000.0)*10.0;
       // strokeWeight(10-abs(screenZ(x, y+sy, z+Z)*10.0));

       // if(screenZ(x, y+sy, z+Z)<100);
        line(x, y+sy, z+Z, x, y+sy, z+Z+0.5);
      }


      ycnt++;
    }
    cntr++;
  }

  for (int i = 0 ; i < vals.length;i++) {

    ArrayList tmp = vals[i];
    if (tmp.size()>fft.specSize()*2)
      tmp.remove(0);
  }

  cnt++;
  //}




  cam.beginHUD();
  
  fill(0);
  noStroke();
  
  //for(int i = 0 ;i < 10;i++)
  //rect(random(width),random(height),random(30,600),random(30,600));
  
  float d = 25.0;
  for (int i = 0 ; i < cnt;i++) {
    stroke(255, 50);
    noFill();
    ellipse(minX[i], minY[i], 10, 10);
    ellipse(maxX[i], maxY[i], 10, 10);
    fill(255);


    textAlign(RIGHT);
    line(minX[i], minY[i], minX[i]-d*5, minY[i]-d);
    text(minZ[i]+" min "+i, minX[i]-d*5, minY[i]-d);

    textAlign(LEFT);
    line(maxX[i], maxY[i], maxX[i]+d*5, maxY[i]-d);
    text(i+" max "+maxZ[i], maxX[i]+d*5, maxY[i]-d);
  }

  for (int i = 1 ; i < cnt;i++) {
    line(minX[i], minY[i], minX[i-1], minY[i-1]);
    line(maxX[i], maxY[i], maxX[i-1], maxY[i-1]);
  }
  cam.endHUD();
}

