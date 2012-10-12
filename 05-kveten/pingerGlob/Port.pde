class Port {

  Session session;
  Host host;
  String line;
  int id;
  float x, y;

  boolean session_running = false;

  String name;
  int port_num;

  Port(int _id, Host _host) {
    host = _host;
    id = _id;
    line = (String)host.output.get(id);
    //println(line);

    parseLine();
  }

  void parseLine() {

    String [] params = splitTokens(line, "/ ");
    port_num = parseInt(params[0]);
    name = params[3];
  }

  void draw() {

    y = host.y+id*10+2;
    x = host.x+50-4;


    if (over()) {
      fill(#70A724);
      if (mousePressed && !session_running) {
        session_running = true;
        Thread t = new Thread(new Session(host, this));
        t.start();
      }
    }
    else {
      fill(#294305);
    }
    noStroke();
    rect(x, y, textWidth(line)+8, -10);
  }

  boolean over() {
    if (mouseX>x && mouseX < x+textWidth(line)+8 && mouseY > y-10 && mouseY < y)
      return true;
    else
      return false;
  }
}

