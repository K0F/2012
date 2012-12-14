/*
 *  Isometric Contour Lines, kof 12
 */


float sc = 10.0;
float X = 0;

int detail = 1;
float res = 0.8;

void setup() {
  size(1280, 720, P3D);
  smooth();
  noiseSeed(19);
  colorMode(HSB,1024);
  ortho();
}

//
void draw() {

  sc = noise(frameCount/4000.0)*52.0;//12;//((mouseY/10.0+5.0)-sc)/4.1;
  X += (mouseX-X)/3.0;
  background(0);

  pushMatrix();

  translate(width, height);
  //scale(0.75);
  rotateX(frameCount/300.0);
  rotateY(frameCount/888.6);
  rotateZ(frameCount/666.6);

  for(int Z = -200;Z<200;Z+=detail){
    for (int y = -200; y < 200;y+=detail) {
      for (int x = -200; x < 200;x+=detail) {

        float z = (-0.5+noise((x+200)/300.0+frameCount/300.0, (y+200)/300.0+frameCount/200.0,(Z+200+frameCount)/500.0))*300.0+100.0;

        //stroke(map(z, 0, 100, 15, 255));

        if ((z+200)%(sc)<res) {
          
          /*
          if (x==-200 || x==199||y==-200||y==199) {
            stroke(255, 5);
            line(x, y, 0, x, y, z);
          }
          */

          /*
          stroke(
              lerpColor(
                lerpColor(
                  color(0,255,255),color(127,255,255),atan2(y,x))
                  ,color(255,255,255),atan2(z,x))
                ,25);
                */
          stroke(1024,25);
          //strokeWeight(2.0-(z+200)%(sc));
          line(x, y, z+Z,x,y,z+Z+3);
        }
      }
    }
  }

  popMatrix();

  saveFrame("/home/kof/render/isPlastic/fr#####.tga");
}

