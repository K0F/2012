/**
* Logaritmic dynamics by kof, 2012
*/


ArrayList pnts, orig,mem;

PVector pos;

float diagonal;

void setup() {

  size(512, 512, P2D);

  pnts = new ArrayList();
  orig = new ArrayList();
  mem = new ArrayList();
  
  diagonal = sqrt(width*width+height*height);


  for (int i = 0 ; i < width*height;i+=3) {
    pnts.add(new PVector(i%width, i/width)); 
    orig.add(new PVector(i%width, i/width));
    mem.add(new PVector(i%width, i/width));
  }
  
  textFont(loadFont("SempliceRegular-8.vlw"));
  textMode(SCREEN);
  
  noStroke();

  fill(255);
}

void draw() {

  background(0);
  
  float viscosity = noise(frameCount/200.0)*100.0;


for(int z  = 0 ;z<2;z++){

  float X = (noise(frameCount/40.0+z*5.0, 0)*width);
  float Y =  (noise(0, frameCount/40.0+z*5.0)*width);
  
  if(z==0)
  text("A",X+24,Y-6);
  if(z==1)
  text("B",X+24,Y-6);
  
  stroke(255,120);
  line(X,Y,X+20,Y-10);
  


  for (int i =0 ; i < pnts.size();i++) {
    PVector pos = (PVector)pnts.get(i);
    PVector org = (PVector)orig.get(i);
    PVector memo = (PVector)mem.get(i);
    
    
    float d = dist(X, Y, pos.x, pos.y)+1.0;
    float d2 = dist(org.x, org.y, pos.x, pos.y)+1.0;
    float d3 = map(dist(memo.x,memo.y,pos.x,pos.y),0,5,0,40);
    
    
    stroke(lerpColor(#FFCC00, #00CCFF, 1-d3/40.0), ((sin(frameCount/(d3+d2)/20.0)+1.0)*90));

    pos.x -= (X-pos.x)/((log(d/80.1+1.01)*(7.8)));
    pos.y -= (Y-pos.y)/((log(d/80.1+1.01)*(7.8)));



    pos.x += (org.x-pos.x)/(5000.0/d2);
    pos.y += (org.y-pos.y)/(5000.0/d2);

    pos.x += (X-pos.x)/((log(d/100.0+1.01)*(10.0)));
    pos.y += (Y-pos.y)/((log(d/100.0+1.01)*(10.0)));
    


  if(z==1)
    {point(pos.x, pos.y);
    
memo.x = pos.x;
    memo.y = pos.y;
    
    
    }
  }
  
}  
}

