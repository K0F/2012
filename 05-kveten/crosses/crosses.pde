
void setup(){
 size(14222,8000,P2D); 
  background(255);
  stroke(0);
}

void draw(){
  
  
  for(int y = 150 ; y < height-150;y+=200){
  for(int x = 150 ; x < width-150;x+=200){
  
line(x-25,y,x+25,y);
line(x,y-25,x,y+25);
  }
  }
  save("frame.png");
  exit();
  
}


