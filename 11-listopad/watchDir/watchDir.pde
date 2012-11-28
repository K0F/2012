
String PATH = "/home/kof/sniff/out";
Observer ob;

boolean GOT_NEW = false;

float x, y;

PImage img;

void setup() {
  size(1024, 768, P2D);
  frameRate(25);
  imageMode(CENTER);


  Runnable runnable = new Observer(PATH);
  Thread seek = new Thread(runnable);
  seek.start();

  background(0);
}

void draw() {

  if (img!=null && GOT_NEW) {
    //img.filter(GRAY);
    tint(255,120);
    image(img, x, y);
  }
  
  fill(lerpColor(#ff0000,#ffffff,(sin(frameCount/10.0)+1.0)/2.0 ));
  noStroke();
  rect(width-10,10,4,4);
}


class Observer implements Runnable {
  String path;
  ArrayList files;

  Observer(String _path) {
    files = new ArrayList();
    path = _path;
  }

  void run() {

    while (true) {

      GOT_NEW = false;

      File dir = new File(path);
      File listDir[] = dir.listFiles();
      for (int i = 0; i < listDir.length; i++) {
        if (!listDir[i].isDirectory()) {

          boolean has = false;
          for (int q = 0 ; q < files.size();q++) {
            String tmp = (String)files.get(q);
            if (tmp.equals(listDir[i].getName()))
              has = true;
          }

          if (!has) {
            files.add(listDir[i].getName());
            img = loadImage(PATH+"/"+listDir[i].getName());
            x = random(img.width/2,width-img.width/2);
            y = random(img.height/2,height-img.height/2);
            GOT_NEW = true;
            println("got file: "+listDir[i].getName());


            try {
              Thread.sleep(100);
            }
            catch(Exception e) {
              ;
            }
          }
        }
      }
      
      
      
      try {
        Thread.sleep(100);
      }
      catch(Exception e) {
        ;
      }
      
    }//while
  }//run
}

