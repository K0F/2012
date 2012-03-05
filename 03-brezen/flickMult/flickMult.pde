
boolean render = true;

int frames[] = {2,3,5,8,13,21};
boolean states[] = new boolean[frames.length];
float h;
void setup(){
  size(1280,720,P2D);

  frameRate(50);
  h = height / (frames.length+0.0) ;
  noStroke();
}



void draw(){

  for(int i =0  ; i < frames.length;i++){

    if(frameCount%frames[i]==0)
      states[i] = true;
    else
      states[i] = false;
    
    if(states[i])
      fill(255);
    else
      fill(0);

    rect(0,i*h,width,h);
  }

  if(render){
    saveFrame("/home/kof/render/flickr/fr#####.png");
println(frameCount);
}





}
