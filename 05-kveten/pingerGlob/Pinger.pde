
class Pinger implements Runnable {
  String subnet;
  float starttime;
  float endtime;


  Pinger(String _subnet) {
    subnet=""+_subnet;
  }

  void run2() {

    boolean reachable = false;
    try
    {
      InetAddress address = InetAddress.getByName(subnet);

      // Try to reach the specified address within the timeout
      // periode. If during this periode the address cannot be
      // reach then the method returns false.
      starttime = millis();
      reachable = address.isReachable(10000);
      endtime = millis();

      if (reachable)
      {
        hosts.add(new Host(subnet, reachable, endtime-starttime, hosts.size()));
        println(subnet);
      }
      // System.out.println("Is host reachable? " + reachable);
    } 
    catch (Exception e)
    {
      e.printStackTrace();
    }
  }
  
  void run(){
    String command = "nmap -sP "+subnet;
    try {     

      String line;
      Process p = Runtime.getRuntime().exec(command);
      BufferedReader input = new BufferedReader(new InputStreamReader(p.getInputStream()));
      while ( (line = input.readLine ()) != null) {
        if (line.indexOf("is up")>-1)
       {   
         String echoS = splitTokens(line," ()")[4];
         
         float echo = parseFloat(echoS.substring(0,echoS.length()-1));
         hosts.add(new Host(subnet, true, echo, hosts.size()));
         //host.output.add(splitTokens(line," ")[0]);
        println(line);
        
       }
      }
      //host.testing = false;
    }
    catch(Exception e) {
    } 
  }
}

