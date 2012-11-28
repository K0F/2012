class Chunk {
  ArrayList packets;
  byte raw[];
  InnerSession session;


  Chunk(InnerSession _session) {
    session = _session;
    packets = new ArrayList();
  }
  
  
  void sortByTime(){
   Collections.sort(packets, new TimeComparator()); 
  }
  
  void dumpAll(){
    int counter = 0;
    for(int i = 0 ; i < packets.size();i++){
     InnerPacket p = (InnerPacket)packets.get(i);
     counter += p.data.length;
    }
    
    raw = new byte[counter];
    
    long number = 0;
    counter = 0;
    for(int i = 0 ; i < packets.size();i++){
     InnerPacket p = (InnerPacket)packets.get(i);
      for(int ii = 0 ; ii < p.data.length;ii++){
       number = p.seq;
       raw[counter] = p.data[ii];
       counter++;
      }
    }
    
    constructImage();
    
   // println("dumping "+packets.size()+" packets in one chunk");
    saveBytes("output/"+number+".raw",raw);
    
  }
  
  void constructImage(){
    IMAGES.add(GetFromJPEG(raw));
  }
}
