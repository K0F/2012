
boolean render = false;

void setup(){
  size(1280,720,P2D);

  frameRate(100);
  noStroke();
}



void draw(){

  for(int i =0  ; i < height;i++){


    stroke( (sin(frameCount/((i+1.0)/300.0+10.0))+1.0)*(sin(frameCount/((height-i+10.0)/3007.7734+10.0))+1.0)*127 );
    line(0,i,width,i);
  }

  if(render){
    saveFrame("/home/kof/render/flickr/fr#####.png");
println(frameCount);
}





}
