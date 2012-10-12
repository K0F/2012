

Scanner s1;

PGraphics pre;
String txt = "";

void setup(){

  size(700,700,P2D);

  s1 = new Scanner(width/2,height/2,7.5);

  background(0);
//smooth();
  pre = createGraphics(width,height,P3D);


  pre.beginDraw();
  pre.textFont(createFont("Verdana",32));
  pre.background(0);
  pre.fill(255);
  pre.textAlign(CENTER,CENTER);
  pre.text("test word",width/2,height/2);

  pre.endDraw();

}

void redraw(){

  txt = "";
  for (int i =0 ;  i < 200;i++){
    if(i%30==0){
      txt+="\n";
    }
    txt += ""+(char)random(65,90);
  }

  pre.beginDraw();
  pre.background(0);
  pre.text(txt,width/2,height/2);
  pre.endDraw();

/* pre.beginDraw();
  pre.background(0);
  pre.stroke(255);
  pre.strokeWeight(3);
  pre.noFill();
  pre.translate(width/2,height/2);
  pre.rotateX(frameCount/300.0);
  pre.rotateY(frameCount/200.0);
  pre.rotateZ(frameCount/100.0);

  pre.box(320);
  pre.endDraw();
*/
 // fastblur(pre,(int)random(3,12));

}


void draw(){


  if(frameCount%100==0){
    redraw();
  }

  noStroke();
  fill(255,15);
  rect(0,0,width,height);

  s1.draw();
}

class Scanner{

  float x,y;
  float angle;
  float step = 3.1244;


  Scanner(float _x,float _y,float _step){

    step = _step;
    x=_x;
    y=_y;


  }

  void draw(){

    pushMatrix();
    translate(x,y);


    for(float i =0;i<step;i+=0.1){
      strokeWeight(1);//map(i,0,step,4,1));
      pushMatrix();
      rotate(radians(angle-i));


      for(int w = 0;w<width/2;w++){

        int X = (int)screenX(w,0);
        int Y = (int)screenY(w,0);

        stroke(0,map(i,0,step,1,40));

        if(X<width && Y < height)
          if(brightness(pre.pixels[Y*pre.width+X])>25){
            point(w,0);
          }
      }
      popMatrix();
    }

    popMatrix();

    step = map(mouseX,0,width,4.95,206);
    angle += step;
  }
}
