class Data {
  String[] raw;
  ArrayList vals;
  String filename;

  Data(String _filename) {
    raw = loadStrings(_filename);
    parse();
  }

  void parse() {
    
    vals = new ArrayList();
    
    for (int i = 1 ; i < raw.length;i++) {
      String [] p = splitTokens(raw[i], ";");
      float[] cluster = new float[p.length];
      for(int q = 1 ;q<p.length-1;q++){
        cluster[q-1] = parseFloat(p[q]);
      }
      vals.add(cluster);
    }
    
    println(vals.size());
  }
}

