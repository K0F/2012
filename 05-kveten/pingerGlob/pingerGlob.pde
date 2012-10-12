/////////////////////////////////////
// Lan ping utility by kof, 2012   //
/////////////////////////////////////

String iface = "wlan0";
String prefix;

boolean QUIET = true;
boolean AUTO_SCAN = true;

int X = 10;
int Y = 20;

ArrayList pingers;
ArrayList hosts;

void init() {
  frame.removeNotify();
  frame.setUndecorated(true); 
  super.init();
}

void setup() {
  size(360, 880, P2D);
  textFont(loadFont("SempliceRegular-8.vlw"));
  textMode(SCREEN);
  frameRate(30);

  frame.setLocation(0, 24);

  prefix = getPrefix(iface);
  pingAll();
}


void draw() {
  background(0);


  for (int i =0 ; i < hosts.size();i++) {
    Host h = (Host)hosts.get(i);
    h.draw();
  }
  //  println(hosts.size());
}


