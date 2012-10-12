void buttons() {

  fill(#ffffff);

  if (mouseX > 20 &&
    mouseX < textWidth("clear all")+20 &&
    mouseY > height-20 &&
    mouseY < height-10) {
    fill(#ff0000);
    if (mousePressed) {
      g.clearAll();
    }
  }

  text("clear all", 20, height-10);
}

