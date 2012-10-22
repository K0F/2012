
void fourGUI() {
  int y = ctlskip*2;

  cp5.addSlider("sensitivity")
    .setRange(0, 10  )
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(four)
            ;
  y+=ctlskip;
}



//float trasa = 3.0;
//boolean invert = false;
float sensitivity = 10.0;



void setupFour() {
 // minim = new Minim(this);
 // in = minim.getLineIn(Minim.STEREO, 1024);


  //pgl = (PGraphicsOpenGL) g; //processing graphics object
  //gl = pgl.beginGL(); //begin opengl
  //gl.setSwapInterval(1); //set vertical sync on
  //pgl.endGL(); //end opengl
}

void four() {

noSmooth();
  // r = sin(frameCount/30.0)*600.0;

  // background(invert?0:255);


  //translate((noise(frameCount/3.0, 0)-0.5)*trasa, (noise(0, frameCount/3.0)-0.5)*trasa );



  noStroke();

  int fst = 0;
  for (int i = 0; i < 1024; i++)
  {
    if (in.right.get(i)>0.4)
      fst = i;
  }

  for (int i = 0; i < 1024; i++)
  {

    stroke(map(in.right.get(i), 0.01, sensitivity, 0, 255), 255);

    line(0, i-fst, width, i-fst);
  }
}


void stop()
{
  // always close Minim audio classes when you are done with them
  in.close();
  minim.stop();

  super.stop();
}

