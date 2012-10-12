void tri(){
  
  //background(0);
  //stroke(255);
  
  int pos = frameCount%height;
  
  al = ctl[phase][33]*2.0;
  
 
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    
    stroke((in.left.get(i)*ctl[phase][34]*2),(in.right.get(i)*ctl[phase][35]*2),0,al);
    line(0,i,width,i);
    
    
   avg += ((in.left.get(i)+in.right.get(i))*2000.0-avg)/30000.0;
}

pushMatrix();
translate(width/2,height/2);
rectMode(CENTER);
  for(int i = 0; i < in.bufferSize() - 1; i+=5)
  {
noFill();
stroke(255,ctl[phase][22]);
rots[i] += (lerp(0,in.right.get(i),ctl[phase][21]/2.0)-rots[i])/10.0;
rotate(radians(rots[i])*10);
rect(0,0,i,i);
  }
  rectMode(CORNER);
  popMatrix();
  


fill(ctl[phase][46]*2,ctl[phase][47]);
noStroke();
ellipse(width/2,height/2,400+avg,400+avg);

  
}
