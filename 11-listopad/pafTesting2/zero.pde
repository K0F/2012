float fades[];
float rotates[];
float sxx = 0;

void zeroSetup() {
  fades = new float[6];
  rotates = new float[6];
}

void zero() {

  int cntr = 0;
  for (int y = crop ; y < in.bufferSize(); y += detail) {
    float val = in.left.get(cntr)*500.0;//fft.getBand(pos);
    vals[cntr].add(val);
    cntr++;
  }
  
  for (int i = 0 ; i < vals.length;i++) {
    ArrayList tmp = vals[i];
    if (tmp.size()>W*detail-1)
      tmp.remove(0);
  }


  cam.beginHUD();

  background(0);
  noStroke();

  tras(ctl[24]);

  dumb.update();




  float w = width;
  float X = 0;

  pushStyle();
  rectMode(CENTER);


  for (int i = 0 ; i < fades.length;i++) {
    X = map(i, 0, 5, 200, w-200);



    fill(ctl[1]*2, fades[i]);
    sxx+=(ctl[4]-sxx)/300.0;
    rect(lerp(X, width/2, map(sxx, 0, 127, 1, 0)), height/2 + lerp(sin((frameCount / 128-ctl[2]) + i )  * (ctl[3] * 2.0), 0, map(sxx, 0, 127, 1, 0) ), 100 + noise(i)*5.0, height-400);
    fades[i] -= 25;

    fades[i] = constrain(fades[i], 0, 255);
  }
  popStyle();

  cam.endHUD();
}

