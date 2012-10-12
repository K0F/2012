/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/60528*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/2235*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
Tree tree = new Tree();

void setup() {
  size(500, 500, P2D);
  colorMode(RGB, 255);
  background(0);
  smooth();
}

void draw() {
  if (keyPressed) {
    if (key == ' ') {
      background(0);
    }
  }
}
void mousePressed() {

  noStroke();
  beginShape();
  fill(#C2DBFC,40);
  vertex(0, 0);
  vertex(width, 0);
fill(#F2F8FF,40);
  vertex(width, height);
  vertex(0, height);
  endShape();
  //fill(0, 30);
  stroke(255, 40);
  //rect(0, 0, width, height);
  tree = new Tree(mouseX, height, height-mouseY, 5);
  tree.render();
}

