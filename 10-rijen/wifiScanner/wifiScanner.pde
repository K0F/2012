
float SPEED = 300.0;

String raw[];
ArrayList <AccessPoint> ap;
ArrayList essids,signals;



void setup(){

  size(1600,900,P2D);

  textFont(loadFont("65Amagasaki-8.vlw"));
  textMode(SCREEN);

  textAlign(RIGHT);

  colorMode(HSB);

  ap = new ArrayList();
  essids = new ArrayList();
  signals = new ArrayList();

  reload();

}

void reload(){

  raw = loadStrings("scan.txt");

  if(raw.length>0)
    parse();

}

void parse(){

  essids = new ArrayList();
  signals = new ArrayList();

  for(int i = 0 ; i < raw.length; i++){


    if(raw[i].indexOf("ESSID")>-1){
      String essidln = raw[i];
      String[] vars = splitTokens(essidln,":\"\t ");
      essids.add(vars[1]);
    }
    if(raw[i].indexOf("Quality")>-1){
      String essidln = raw[i];
      String[] vars = splitTokens(essidln,"= /");
      float perc = 100.0*(parseInt(vars[1])/(float)parseInt(vars[2]));
      signals.add(perc);
    }


  }

  castObjects();

}

void castObjects(){

  for(int i = 0 ; i < essids.size();i++){
    String name = (String)essids.get(i);
    float signal = (Float)signals.get(i);


    boolean isonlist = false;
    for(int q =  0 ; q < ap.size();q++){
      AccessPoint tmp = (AccessPoint)ap.get(q);
      if(tmp.name.equals(name)){
        isonlist = true;
        tmp.setSignal(signal);
      }
    }

    if(!isonlist)
      ap.add(new AccessPoint(name,signal));



  } 

}



void draw(){


  background(0);

  if(frameCount%50==0){
    reload();
  }


  fill(255);


  for(int i = 0 ; i < ap.size();i++){

    AccessPoint tmp  = (AccessPoint)ap.get(i);

    tmp.update();
    tmp.plot();
  }



}

class AccessPoint{

  String name;
  float signal,ssignal;
  ArrayList graph;
  color c; 


  AccessPoint(String _name,float _signal){
    name = _name;

    ssignal = signal = _signal;
    c = color(random(255),200,255);
    graph = new ArrayList();
  }

  void setSignal(float _signal){
    signal = _signal;
  }

  void update(){
    ssignal += (signal-ssignal)/SPEED;
    graph.add(ssignal);
    if(graph.size()>width)
      graph.remove(0);
  }

  void plot(){
    beginShape();
    stroke(c);
    noFill();

    float lastval = 0;
    for(int i = 0; i < graph.size();i++){
      float val = (Float)graph.get(i);
      float mapped = map(val,0,100,height,0);
      vertex(i,mapped);
      lastval = mapped;
    }
    endShape();


    fill(c);
    text(name,graph.size(),lastval);

  }


}


