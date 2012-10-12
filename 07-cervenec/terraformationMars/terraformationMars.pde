
Planet mars;

void setup(){

  size(512,480,P3D);

  textureMode(IMAGE);
  mars = new Planet("trans.png",400);
}

void draw(){

  background(0);

  mars.render();

}

class Planet{
  float R;
  PImage map;
  PVector p[][];

  int NUM_ROWS, NUM_LINES;

  Planet(String _path,float _R){
    map = loadImage(_path);

    R=_R;

    NUM_ROWS = 80;
    NUM_LINES = 80;

    p = new PVector[NUM_ROWS][NUM_LINES]; 
    prepareGeometry();
  }

  void prepareGeometry(){
    for(int i=0; i<NUM_ROWS; i++){

      float u = (float)i/(NUM_ROWS-1);
      float theta = u*TWO_PI;
      for(int j=0; j<NUM_LINES; j++){
        float v = (float)j/(NUM_LINES-1);
        float phi = PI*v;

        float x = cos(theta) * sin(phi) * R;
        float y = sin(theta) * sin(phi) * R;
        float z = cos(phi) * R;

        p[i][j] = new PVector(x, y, z);
      } 
    }
  }

  void render(){
    
    //lights();

directionalLight(255, 255, 255, -1, 0, -1);


    pushMatrix();
    translate(width/2,height/2);
    rotateX(radians(90));
    rotateX(radians(frameCount*2.33));
    rotateZ(radians(-frameCount*3.33));

    noStroke();




int cnt = 0;
    beginShape(TRIANGLE_STRIP);
    for(int i = 0 ; i < NUM_ROWS;i++){
      int next = (i+1)%NUM_ROWS;
      float u = (float)i/(NUM_ROWS-1);
      float uNext = (float)next/(NUM_ROWS-1);

      for(int j = 0 ; j < NUM_LINES;j++){


        float v = (float)j/(NUM_LINES-1);
        float df = noise((v)+frameCount/300.0);

        PVector tmp = p[i][j];
        PVector nextTmp = p[next][j];
        //point(tmp.x,tmp.y,tmp.z);

        tint(noise((u+v+frameCount)/30.0,0,0)*255,noise(0,(u+v+frameCount)/30.0,0)*255,noise(0,0,(u+v+frameCount)/30.0)*255,255*noise((v+u+cnt)/3000.0+frameCount/300.0));
        texture(map);


        cnt++;

        vertex(tmp.x*df,tmp.y*df,tmp.z*df,u*map.width*df,v*map.height);
        vertex(nextTmp.x*df,nextTmp.y*df,nextTmp.z*df,uNext*map.width*df,v*map.height);


      }
    }

    endShape();


    popMatrix();

  }

}
