class DumbSender {
  int [] intervals;

  NetAddress myRemoteLocation;


  DumbSender() {
    intervals = new int[6];
    for (int i = 0 ; i < 6;i++) {
      intervals[i] = (int)random(20, 100);
    }
    myRemoteLocation = new NetAddress("127.0.0.1", 12000);
  }

  void update() {
    for (int i = 0 ; i < 6;i++) {
      if (frameCount%intervals[i]==0) {
        sendSignal(i);
      }
    }
  }

  void sendSignal(int _num) {
    OscMessage n  = new OscMessage("/bang");
    //println(_num);
    n.add(_num+1); 
    n.add(noise((frameCount+_num)/30.0));
    oscP5.send(n, myRemoteLocation);
  }
}

