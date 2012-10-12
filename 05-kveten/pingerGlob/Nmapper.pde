class Nmapper implements Runnable {
  String address;
  String command = "nmap -P0";
  ArrayList output;
  Host host;

  Nmapper(String _address) {
    address = _address;
    command += " "+address;
    output = new ArrayList();
  }

  Nmapper(Host h) {
    host = h;
    address = host.addr;
    command += " "+address;
  }

  void run() {
    host.output = new ArrayList();

    try {     

      String line;
      Process p = Runtime.getRuntime().exec(command);
      BufferedReader input = new BufferedReader(new InputStreamReader(p.getInputStream()));
      int cnt = 0;
      while ( (line = input.readLine ()) != null) {
       if(QUIET){
        if(line.indexOf("shown")==-1){
         
       //   ||
       // line.indexOf("closed")>-1 ||
       // line.indexOf("filtered")>-1) &&
        
        if (line.indexOf("open")>-1){
          host.output.add(line);
          host.ports.add(new Port(cnt,host));
          cnt++; 
        }
        }
       }else{
          host.output.add(line);
         
       }
        //System.out.println(line);
      }
      host.testing = false;
    }
    catch(Exception e) {
    }
  }
}

