
float reaktivita = 1.0;

int shift = 0;
float vl[] = new float[1025];
float cx, cy;


int mcntr = 0,minut=0;
boolean once = true;


boolean boosh = false;


void four(){
  
  
  cam.beginHUD();
  
  //fastblur(g,1);
  if (ctl[7]>10)
    blend(g, 0, 0, width, height, 0, 0, width, height, (int)(ctl[7]/8.0));

  noStroke();
  if (frameCount%((128-ctl[26])*20)==0)
    for (int i =0 ; i<width;i+=30) {
      stroke(255, ctl[22]);
      //rect(i,height-30,8,8);
      line(i-5, height-10, i+6, height-10);
      line(i, height-15, i, height-5);
    }

  ///////////////////////////////////


  if (frameCount%(2)==0)
    shift = 1;
  else
    shift = 0 ;

  image(g, 0, -shift);
  fill(0, 13);

  pushStyle();
  noFill();
  stroke(0);
  strokeWeight(10);
  rect(0, 0, width, height);
  popStyle();



  fft.forward(in.mix);
  for (float q = 0;q<width;q+=width/4) {

    pushMatrix();
    translate(q+width/8, height);
    //translate(q+cx*10.0, height-10.0-cy*10.0);
    rotate(cos(q+frameCount/1500.0)*4.0);

    float t = 0;
    beginShape();  

    for (int i = 5; i < fft.specSize()/4.0; i++)
    {
      stroke(lerpColor(#473B0B, #ffffff, constrain(norm(vl[i], 0, 127), 0, 0.99)), vl[i]/8.0*map(ctl[2], 0, 127, 0, 8));
      vl[i] += (fft.getBand(i)*i*(reaktivita/32.0) - vl[i])/(127-ctl[29]+1.0);
      t = (radians(map(i+frameCount/50.0+q, 0, fft.specSize()/4.0, 0, 360)));
      vertex(sin(t)*vl[i], cos(t)*vl[i]);
      cx+=(sin(t)*vl[i]-cx)/1000.0;
      cy+=(cos(t)*vl[i]-cy)/1000.0;
    }

    endShape(CLOSE);

    stroke(255, ctl[30]);
    point(0, 150);
    point(0, -150);
    point(150, 0);
    point(-150, 0);



    popMatrix();
  }


  if (boosh)
    if (frameCount%(ctl[27]+1)==0)
      filter(INVERT);

  if (millis()%1000<200 && once) {
    textAlign(RIGHT);
    fill(255);
    
    mcntr++;
    
    if(mcntr%60==0)
    {minut++;
    mcntr=0;
    }
    if (minut==0)
      text(round(millis()/1000)+"s", width-10, height-7);
    else
      text(minut+"m "+(round(millis()/1000)%60)+"s", width-10, height-7);


    stroke(#ff0000, 127);
    line(0, height-8, width, height-8);
    once = false;
  }

  if (frameCount%100==0)
    once = true; 
  
  
  
  
  cam.endHUD();
  
  
  
  
  
  
}
