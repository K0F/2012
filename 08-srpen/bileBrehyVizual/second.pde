

void dva(){
 
  //fastblur(g,1);
  if (ctl[phase][7]>10)
    blend(g, 0, 0, width, height, 0, 0, width, height, (int)(ctl[phase][7]/8.0));

  noStroke();
  if (frameCount%((128-ctl[phase][35])*20)==0)
    for (int i =0 ; i<width;i+=30) {
      stroke(255, ctl[phase][22]);
      //rect(i,height-30,8,8);
      line(i-5, height-10, i+6, height-10);
      line(i, height-15, i, height-5);
    }

  ///////////////////////////////////


  if (frameCount%(128-ctl[phase][35])==0)
    shift=1;
  else
    shift =0 ;

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
      stroke(lerpColor(#473B0B, #ffffff, constrain(norm(vals[i], 0, 1024), 0, 1)), vals[i]/8.0*map(ctl[phase][46], 0, 127, 0, 8));
      vals[i] += (fft.getBand(i)*i*(ctl[phase][33]/32.0) - vals[i])/(127-ctl[phase][34]+1.0);
      t = (radians(map(i+frameCount/50.0+q, 0, fft.specSize()/4.0, 0, 360)));
      vertex(sin(t)*vals[i], cos(t)*vals[i]);
      cx+=(sin(t)*vals[i]-cx)/1000.0;
      cy+=(cos(t)*vals[i]-cy)/1000.0;
    }

    endShape(CLOSE);

    stroke(255, ctl[phase][39]);
    point(0, 150);
    point(0, -150);
    point(150, 0);
    point(-150, 0);



    popMatrix();
  }


  if (boosh)
    if (frameCount%(ctl[phase][27]+1)==0)
      filter(INVERT);

  if (millis()%1000<200 && once) {
    textAlign(RIGHT);
    textFont(tiny);
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
}
