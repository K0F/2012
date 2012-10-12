float speed[];
PVector pos[],lpos[];
PVector spos[],lspos[];

PImage back,back2;

int num = 60;
float amount = 5;

void setup(){

back = loadImage("corpse.jpg");
back2 = loadImage("corpse2.jpg");

  size(back.width,back.height,P2D);
  pos = new PVector[num];
  lpos = new PVector[num];
  spos = new PVector[num];
  lspos = new PVector[num];


  speed= new float[num];
  for(int i = 0 ; i < num;i++){
    pos[i] = new PVector(0,0);
    lpos[i] = new PVector(0,0);
    spos[i] = new PVector(0,0);
    lspos[i] = new PVector(0,0);


    speed[i] = random(20,300);
  }

 // colorMode(HSB);

}


void draw(){
  // shakeit
  translate(
      (noise(frameCount/80.0,0)-0.5)*40.0+(noise(frameCount/2.0,0)-0.5)*2.0,
      (noise(0,frameCount/80.0)-0.5)*40.0+(noise(0,frameCount/2.0)-0.5)*2.0
      );
  
  fastblur(g,round(random(1,3)));
  tint(255,random(13,200));

  if(frameCount%240<12)
    image(back2,0,0);
  else
    image(back,0,0);

  for(int nn = 0 ; nn < num; nn+=1){



    float mod = nn*200.0;

    translate(width/2,height/2);
    scale(0.95+noise(mod+frameCount/300.0)/10.0);
    translate(-width/2,-height/2);


    //speed[nn] = noise((frameCount)/3000.0+mod)*200.0+20.0;

    speed[nn] = constrain(speed[nn],100,800);

    lpos[nn] = new PVector(pos[nn].x,pos[nn].y);
    lspos[nn] = new PVector(spos[nn].x,spos[nn].y);

    noFill();
    //point(pos[nn].x,pos[nn].y);

    pos[nn] = new PVector(noise((frameCount)/speed[nn]+mod,0)*width,noise(0,(frameCount)/speed[nn]+mod)*height);
    spos[nn] = new PVector(sin(frameCount/speed[nn]+mod)*width/2+width/2,height/2);

    //  float theta = atan2(lpos.y-pos.y,lpos.x-pos.x);
    // pushMatrix();
    //translate(lpos.x,lpos.y);
    //rotate(theta);
    float d = dist(pos[nn].x,pos[nn].y,lpos[nn].x,lpos[nn].y);
    stroke(255);


    beginShape();
    //vertex(pos[nn].x,pos[nn].y);
    float x,y;
    for(float i = 0 ; i < 1.0 ; i+=0.2){
      x = noise((frameCount-i)/speed[nn]+mod,0)*width;
      y = noise(0,(frameCount-i)/speed[nn]+mod)*height;
      stroke(0,127-(d*11.5));//,map(i,0,d,127,0));
      vertex(x+spos[nn].x/10.0,y);
    }
    //vertex(lpos[nn].x,lpos[nn].y);
    endShape();
    //popMatrix();

  }

  resetMatrix();
  noFill();
  strokeWeight(20);
  stroke(0);
  rect(0,0,width,height);

  strokeWeight(1);

  saveFrame("render/ze#####.png");


}
