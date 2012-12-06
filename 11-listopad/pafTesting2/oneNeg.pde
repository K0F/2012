void oneB() {
  background(0);
  dumb.update();

tras(ctl[24]);
  translate(-vals[0].size()/2,-in.bufferSize()/2,0);
  
  sc += (map(ctl[11],0,127,1000,1)-sc)/100.0;

  
    ddz += (ctl[10]-ddz)/50.0;

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
      (Z+frameCount/sc)/sc)-0.5)*(ddz*8.0)-z
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
        stroke(bright, constrain(map(z-(127-ctl[1]), -ctl[16]*5.0, ctl[16]*5.0, 0, 255), 0, 255));

        float sy = 0;//sin(((x|y)*z)/3000.0)*10.0;
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
pruhy();
  //plot();
  //back();
  
  
  
  
  } 

