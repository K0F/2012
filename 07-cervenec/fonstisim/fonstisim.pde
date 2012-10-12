PFont fonty[];
int size = 160;

boolean render = false;

String txt = "permanent change";

void setup(){

  size(1280,720);
  fonty = new PFont[PFont.list().length];

  //textMode(SCREEN);

  smooth();
  textAlign(CENTER);

  for(int i = 0 ; i < fonty.length;i++){
    fonty[i] = createFont(PFont.list()[i],size);
  }
  background(0);

}


void draw(){
  fill(0,130);
  rect(0,0,width,height);

  fill(255,random(10,230));
  textFont(fonty[frameCount%fonty.length]);

  float w = textWidth(txt);

  float siz = 50000/w;

  
  textFont(fonty[frameCount%fonty.length],siz);


  text(txt,width/2,height/2+siz/3.0);


  blend(g,0,0,width,height,0,0,width,height,OVERLAY);

if(render)
  saveFrame("/home/kof/render/theChangeFont/fr#####.png");
}
