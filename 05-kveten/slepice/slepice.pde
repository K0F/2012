PShape slepice, casti[];
int offx[] = {
  0, 0, -20, 0, -180
};
int offy[] = {
  0, 40, 40, 0, -63
};

void setup() {

  size(600, 700);
  slepice=loadShape("slepice.svg");

  casti = new PShape[slepice.getChildCount()];

  for (int i = 0 ; i < slepice.getChildCount();i++) {
    casti[i] = slepice.getChild(i);
    casti[i].disableStyle();
  }
}


void draw() {

  // offx[4] = -mouseX;
  // offy[4] = -mouseY;

  println(mouseX+", "+mouseY);

  background(0);

  fill(255);

  pushMatrix();

  translate(width/2, height/2);
  //pushMatrix();

  for (int i =0 ; i < casti.length;i++) {
    // println(i);
    //
    casti[i].resetMatrix();
    casti[i].rotate(sin(frameCount/30.0)*PI);

    //casti[i].translate(offx[i],offy[i]);

    //casti[i].rotate(sin(frameCount/30.0/i)*PI);


    casti[i].draw(g);
    //popMatrix();
  } 

  popMatrix();
}

