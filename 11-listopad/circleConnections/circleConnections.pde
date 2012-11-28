//////////////////////////////////
/// CIRCULAR CREATURE by kof 12 //
//////////////////////////////////


ArrayList pnts;
int num = 50;

float tras = 5.0;
float tras_rychlost = 10.0;

float R = 200;

void setup(){
  size(720,720,P2D);
  colorMode(HSB);

  pnts = new ArrayList();

  for(int i = 0 ; i < num ; i++){

    float x = cos(map(i,0,num,-PI,PI))*R+width/2;
    float y = sin(map(i,0,num,-PI,PI))*R+height/2;


    pnts.add(new Pnt(x,y));

  }


  for(int i = 0 ; i < pnts.size() ; i++){
    Pnt p = (Pnt)pnts.get(i);
    p.checkOthers();
  }

}


//////////////////////////////////
void draw(){

  background(0);

  for(int i = 0 ; i < 10;i++){
    translate((noise((frameCount+i)/tras_rychlost,0)-0.5)*tras, (noise(0,(frameCount+i)/10.0)-0.5)*tras_rychlost);
  }

  for(int i = 0 ; i < pnts.size() ; i++){
    Pnt tmp = (Pnt)pnts.get(i);
    tmp.draw();
  }
}



//////////////////////////////////
class Pnt{
  PVector pos,orig,orig2;
  ArrayList others;
  int shift = 0;

  //////////////////////////////////
  Pnt(float _x,float _y){

    orig2 = new PVector(_x,_y);
    pos = new PVector(_x,_y);
    orig = new PVector(_x,_y);

    others = new ArrayList();
  }

  //////////////////////////////////
  void checkOthers(){
    others = new ArrayList();

    for(int i = 0 ; i < pnts.size() ; i++){
      Pnt tmp = (Pnt)pnts.get(i);
      if(tmp!=this){
        boolean established = tmp.others.contains(this);

        if(!established){
          others.add(tmp);
        }
      }//if
    }//for
  }//checkOthers

  //////////////////////////////////
  void draw(){
    move();

    for(int i = 0 ; i < others.size() ; i++){
      Pnt other = (Pnt)others.get(i);
      if(other!=this){
        stroke(
            lerpColor(
              color(noise(frameCount/33.33,0)*255,127,200),
              color(noise(0,frameCount/330.33)*255,127,200),
              norm(atan2(other.pos.y-pos.y,other.pos.x-pos.x),-PI,PI)),
            constrain(map(dist(other.pos.x,other.pos.y,pos.x,pos.y),0,width,30,0),0,255));

        line(pos.x,pos.y,other.pos.x,other.pos.y);

      }
    }
  }

  //////////////////////////////////
  void move(){

    Pnt next = (Pnt)pnts.get((pnts.indexOf(this)+shift)%pnts.size());
    orig.x += (next.orig2.x-orig.x)/2.1;
    orig.y += (next.orig2.y-orig.y)/2.1;

    if(dist(orig.x,orig.y,next.orig2.x,next.orig2.y)<1){
      shift++;
      if(shift==pnts.indexOf(this))
        shift++;
    }

    for(int i = 0 ; i < pnts.size() ; i++){
      Pnt other = (Pnt)pnts.get(i);
      if(other!=this){
        pos.x -= (other.pos.x-pos.x) / (noise( (frameCount*cos(millis()*0.001+pnts.indexOf(this)))/100.0 )*800.0);
        pos.y -= (other.pos.y-pos.y) / (noise( (frameCount*sin(millis()*0.001+pnts.indexOf(this)))/100.0 )*800.0);

      }
    }

    pos.x += (lerp(orig.x,width/2,noise((frameCount+pnts.indexOf(this))/40.0))-pos.x)/2.0;
    pos.y += (lerp(orig.y,width/2,noise((frameCount+pnts.indexOf(this))/40.0))-pos.y)/2.0;

    pos.x = constrain(pos.x,0,width);
    pos.y = constrain(pos.y,0,height);
  }

}
//////////////////////////////////
