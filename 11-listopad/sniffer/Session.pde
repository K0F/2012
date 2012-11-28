class InnerSession {
  PacketFuser fuser;
  ArrayList packets;
  String src, dest;
  byte alldata[];

  InnerSession(String _src, String _dest) {
    packets = new ArrayList();
    src=_src;
    dest=_dest;
    fuser = new PacketFuser(this);
  }

  void limit() {
    if (packets.size()>PACKETS_PER_SESSION)
      packets.remove(0);
  }

  void collect() {
    
    
  fuser.createChunks();
  fuser.sortByTime();
  fuser.dumpChunks();

/*
    String dataset = "";
    for (int i = 0 ; i < packets.size();i++) {
      InnerPacket p = (InnerPacket)packets.get(i);
      if (p.jpegHead){
           IMAGES.add(GetFromJPEG(p.data));
 
      }
    }

    int start = dataset.indexOf("1");

    if (start>-1) {


      int allLen = 0;
      for (int i = start+390 ; i < packets.size();i++) {
        InnerPacket p = (InnerPacket)packets.get(i);
        allLen += p.data.length;
      }

      int cntr = 0;
      alldata = new byte[allLen];
      for (int i = start+390 ; i < packets.size();i++) {
        InnerPacket p = (InnerPacket)packets.get(i);
        for (int ii = 0 ; ii < p.data.length;ii++) {
          alldata[cntr] = p.data[ii];
          cntr++;
        }
      }
    }
*/
  
  }

  void ordnung() {
    Collections.sort(packets, new SeqComparator());
  }

  void check() {
    println(src+" -> "+dest+" : ");
    for (int i = 0 ; i < packets.size();i++) {
      InnerPacket p = (InnerPacket)packets.get(i);
      if(p.jpegHead)
      print("J");
      print(p.seq+" ");
    }
    println();
    println("-------------------------");
  }
}

