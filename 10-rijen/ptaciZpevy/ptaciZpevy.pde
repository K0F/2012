ArrayList images;
String filenames[];
ImageLoader loader;

int imgno = 0;

void setup() {
  size(1280, 880, P2D); 

  filenames = loadFilenames(sketchPath+"/data/");

  images = new ArrayList();
  loader = new ImageLoader(filenames);
  Thread t = new Thread(loader);
  t.start();
}

void reset() {
  imgno = 0;
}

void dalsi() {

  imgno++;
  if (imgno>=images.size()-1)
    imgno = 0;
}


void draw() {
  background(255);

  if (images.size()>0) {

    PImage current = (PImage)images.get(imgno);
    image(current, 0, 0);

    if (frameCount%500==0)
      dalsi();
  }else{
    
   float percent = loader.getState()/(float)filenames.length;
   println(percent); 
  }
}

String[] loadFilenames(String path) {
  File folder = new File(path);
  FilenameFilter filenameFilter = new FilenameFilter() {
    public boolean accept(File dir, String name) {
      return name.toLowerCase().endsWith(".png"); // change this to any extension you want
    }
  };
  return folder.list(filenameFilter);
}

class ImageLoader implements Runnable {
  int cnt;
  String filenames[];

  ImageLoader(String _filenames[]) {

    filenames = _filenames;
  }

  void run() {
    cnt = 0;

    while (cnt <= 150) {
      images.add(loadImage(filenames[cnt]));
      cnt++;
    }
  }


  int getState() {
    return cnt;
  }
}

