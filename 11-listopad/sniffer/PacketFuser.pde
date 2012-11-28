class PacketFuser {
  ArrayList packets, chunks;

  InnerSession session;
  ArrayList jpegIds;

  PacketFuser(InnerSession _session) {
    session = _session;
    packets = session.packets;
    chunks = new ArrayList();
  }

  void createChunks() {
    for (int i = 0 ; i < packets.size();i++) {
      InnerPacket p = (InnerPacket)packets.get(i);
      if (p.jpegHead) {

        // create chunk with packets
        chunks.add(new Chunk(session));
        Chunk last = (Chunk)chunks.get(chunks.size()-1);
        last.packets.add(p);


        for (int ii = 0 ; ii <packets.size();ii++) {
          InnerPacket pp = (InnerPacket)packets.get(ii);

          if (i!=ii && p.seq == pp.seq) {
            last = (Chunk)chunks.get(chunks.size()-1);
            last.packets.add(pp);
          }
        }
      }
    }
    println(chunks.size()+" of chunks created");
  }

  void sortByTime() {
    for (int i = 0 ; i < chunks.size();i++) {
      Chunk chunk =  (Chunk)chunks.get(i);
      chunk.sortByTime();
    }
  }
  
  void dumpChunks() {
    for (int i = 0 ; i < chunks.size();i++) {
      Chunk chunk =  (Chunk)chunks.get(i);
      chunk.dumpAll();
    }
  }
}

