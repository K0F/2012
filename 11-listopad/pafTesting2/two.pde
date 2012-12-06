void two() {
  //background(0);
  
    tras(ctl[24]);
    
if(dumbie)
  dumb.update();

  //if (frameCount%50==0)
    //sw = !sw;
    
  // pruhy();

  // image(img,0,0);

  // now draw things that you want relative to the camera's position and orientation
  /* cam.beginHUD();
   fill(255);
   text("noiseStudy :: kof", width-80, height-10);
   cam.endHUD();
   
   float maxX[] = new float[3];
   float maxY[] = new float[3];
   
   float minX[] = new float[3];
   float minY[] = new float[3];
   
   
   float maxZ[] = new float[3];
   float minZ[] = new float[3];
   
   int cnt = 0;
   
   maxX[cnt] = -1000;
   maxY[cnt] = -1000;
   minX[cnt] = 1000;
   minY[cnt] = 1000;
   maxZ[cnt] = -1000;
   minZ[cnt] = 1000;
   
   */
  //fft.forward(in.mix);


  translate(-vals[0].size()/2,-in.bufferSize()/2,0);
  
  sc += (map(ctl[11],0,127,1000,1)-sc)/100.0;

  


  int cntr = 0;
  int ycnt = 0;
  for (int y = crop ; y < in.bufferSize(); y += detail) {
    float z = 0;

    int pos = y;//(int)map(y, 0, height/2, 0, fft.specSize());
    float val = in.left.get(cntr)*500.0;//fft.getBand(pos);
    vals[cntr].add(val);

    ycnt =0;

    for (int x = 0 ; x < vals[0].size(); x += detail) {
      float V = (Float)vals[cntr].get(ycnt);

      z += (V*ctl[8]/6.0-z)/((in.left.get(cntr)+1.5)*(128-ctl[9])*4.0);//(pow(V, 0.9)*100.0-z)/50.0;

      z += (
      (noise((x+frameCount)/sc+height/2, 
      (y+frameCount)/sc+height/2, 
      (Z+frameCount/sc)/sc)-0.5)*(ctl[10]*8.0)-z
        /10.0);

      /*

       if (minZ[cnt]>z) {
       minZ[cnt] = z;
       minX[cnt] = screenX(x, y, z+Z);
       minY[cnt] = screenY(x, y, z+Z);
       }
       
       if (maxZ[cnt]<z) {
       maxZ[cnt] = z;
       maxX[cnt] = screenX(x, y, z+Z);
       maxY[cnt] = screenY(x, y, z+Z);
       }
       */


      int pixmappos = (cntr%H)*W+(ycnt%W);
      color c  = img.pixels[pixmappos];
      float bright = brightness(c);
      if (bright>10) {

        //stroke(lerpColor(#ffffff, #fffddd, constrain(map(z, -50, 50, 0, 1), 0, 1)), constrain((z+150)/1.2, 0, 255));
        stroke(bright, constrain(map(z, -1000, 1000, 0, 255), 0, ctl[1]*2.0*noise((z+Z) / (127-ctl[16]) )));

       // float sy = sin(((x|y)*z)/(127-ctl[12]+1.0)*120.0)*ctl[13];
        //strokeWeight(10-abs(screenZ(x, y+sy, z+Z)*10.0));

        // if(screenZ(x, y+sy, z+Z)<100);
        line(x, y+sy, z+Z, x, y+sy, z+Z+ctl[17]/10.0+1);
      }
      ycnt++;
    }
    cntr++;
  }
  

  for (int i = 0 ; i < vals.length;i++) {
    ArrayList tmp = vals[i];
    if (tmp.size()>W*detail-1)
      tmp.remove(0);
  }

  plot();
  //back();
  
  
  cam.beginHUD();
  noStroke();
  pushStyle();
  rectMode(CORNER);
  fill(0,ctl[19]*2.0);
  rect(0,0,width,height);
  popStyle();
  
  tint(255,ctl[18]*2.0);
  image(g,0,-4);
  cam.endHUD();
  
  } 

