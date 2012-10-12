


void ctyri() {

  pushStyle();

  for (int i = 0; i < height; i++)
  {

    stroke(((in.left.get(i)+in.right.get(i))*ctl[phase][34]*4));
    line(0, i, width, i);


    avg += ((in.left.get(i)+in.right.get(i))*2000.0-avg)/30000.0;
  }

  //////////////////////////////////////////


  translate((noise(frameCount, 0)-0.5)*tras, 
  (noise(0, frameCount)-0.5)*tras);

  chill --;


  if (millis()%(int)mezi<50 && chill<0) {

    fill(random(255), random(255), random(255), ctl[phase][33]*2);
    noStroke();




    pushMatrix();
    translate(width/2, height/2);
    //ellipse(width/2,height/2,400,400);
    shaper.draw();

    shaper.gen();
    popMatrix();
  }
  else {
    shaper.gen();
  } 
  popStyle();
}

class Shaper {
  int sides;

  ArrayList vec;

  Shaper(int _sides) {
    sides=_sides;
    gen();
  }


  void gen() {

    sides = ctl[phase][7];

    vec = new ArrayList();

    for (int i = 0 ; i < sides;i++) {
      vec.add(new PVector(
      (noise(i+(millis()/1000.0), 0)-0.5)*width, 
      (noise(0, i+(millis()/1000.0))-0.5)*height)
        );
    }
  }


  void draw() {



    beginShape();
    for (int i =1 ; i < vec.size();i++) {
      PVector tmp = (PVector)vec.get(i);

      vertex(tmp.x, tmp.y);
    }




    endShape(CLOSE);

    stroke(255, ctl[phase][35]*2);
    strokeWeight(ctl[phase][46]);

    for (int i =1 ; i < vec.size();i++) {
      PVector tmp2 = (PVector)vec.get(i-1);

      PVector tmp = (PVector)vec.get(i);

      dline(tmp.x,tmp.y,tmp2.x,tmp2.y,10.0);

    }
  }
}

