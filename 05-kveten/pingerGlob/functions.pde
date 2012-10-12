
void pingAll() {
  Y=20;

  pingers = new ArrayList();
  hosts = new ArrayList();
  for (int i =0 ; i < pingers.size();i++) {
 Thread t = (Thread)pingers.get(i);
    t.stop();
      
  }
  

  for (int i = 1 ; i < 255;i++) {
    String addr = prefix+i;
    pingers.add(new Thread(new Pinger(addr)));
  }

  for (int i =0 ; i < pingers.size();i++) {
    Thread t = (Thread)pingers.get(i);
    t.start();
  }
}

void nmapTarget(Host h) {
  Thread t = new Thread(new Nmapper(h));
  t.start();
}


String getPrefix(String name) {

  String _prefix = "";
  try {
    try {
      NetworkInterface ni = NetworkInterface.getByName(name);

      Enumeration ia = ni.getInetAddresses();  

      while (ia.hasMoreElements ()) {
        InetAddress elem = (InetAddress)ia.nextElement();
        if (elem instanceof Inet4Address) {

          //String str = " hostname: "+ elem.getHostAddress();
          //println(str);
          String str = elem.getHostAddress();
          // println(str);

          _prefix = ""+str.substring(0, str.lastIndexOf(".")+1);
        }
      }
    }
    catch(Exception e) {
      println("error vole! "+e);
    }
  } 
  catch (NullPointerException e) {
    System.out.println("Retrieving Information from NetworkInterface failed");
  }

  return _prefix;
}

