class Shaper{
 int sides;

  ArrayList vec;

Shaper(int _sides){
 sides=_sides;
 gen();
 
}


void gen(){
  
  sides = ctl[7];
  
 vec = new ArrayList();
 
 for(int i = 0 ; i < sides;i++){
     vec.add(new PVector(
     (noise(i+(millis()/1000.0),0)-0.5)*width,
     (noise(0,i+(millis()/1000.0))-0.5)*height)
     );
   
 }
  
}


void draw(){
  
  beginShape();
  for(int i =0 ; i < vec.size();i++){
   PVector tmp = (PVector)vec.get(i);
  
  vertex(tmp.x,tmp.y); 
  }
  endShape();
  
  
}
  
  
}
