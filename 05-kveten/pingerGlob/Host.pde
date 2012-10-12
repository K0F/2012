
class Host {
  ArrayList ports;
  String addr = "";
  boolean isUp = false;
  float echo;
  ArrayList output;
  int x, y;

  int id;

  boolean testing = false;

  String sign;
  float w, h;

  Host(String _addr, boolean _isUp, float _echo, int _id) {
    addr=_addr;
    isUp=_isUp;
    echo = _echo;
    id = _id;



    sign = addr;
    w = textWidth(sign)+4;
    h = 12.0;

    x = X;
    y = Y;

    Y+=12;

    output = new ArrayList();
    ports = new ArrayList();

    if (AUTO_SCAN) {
      nmapTarget(this);
      testing = true;
    }
  }

  void draw() {

    String sign = addr;


    if (output.size()>0) {

      fill(127);

      h = output.size()*10+15;


      fill(0);
      rect(x-4, y-12, width-10, h);

      textAlign(LEFT);
      for (int out = 0;out<output.size();out++) {
        
        Port port = (Port)ports.get(out);
        port.draw();
        
        fill(#ffffff);
        
        String line = (String)output.get(out);
        text(line, x+50, y+out*10);
        
      }
    }


    if (testing)
      fill(#ff2222, 127*(sin(frameCount/5.0)+1.0));
    else
      if (over()) {
        fill(#aa1100);

        if (mousePressed && !testing) {
          nmapTarget(this);
          testing = true;
        }
      }
      else {
        fill(0);
      }
    stroke(#ffcc00);
    rect(x-2, y+2, w, -12); 

    fill(#ffcc00); 

    textAlign(LEFT);
    text(sign, x, y);
    textAlign(RIGHT);
    text(round(echo*1000.0)/1000.0+"s", width-10, y);


    checkOverlaps();
  }

  boolean over() {
    if (mouseX>x && mouseX<x+w && mouseY<y && mouseY > y-10 )
      return true;
    else
      return false;
  }

  void checkOverlaps() {

    for (int i = 0 ; i < hosts.size();i++) {
      Host tmp = (Host)hosts.get(i);
      if (tmp!=this && tmp.y < y) {
        if (y > tmp.y && y < tmp.y+tmp.h+2) {
          y +=10;
        }
      }
    }
  }
}

