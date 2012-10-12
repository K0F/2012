class Session implements Runnable {
  Host host;
  Port port;

  Session(Host _host, Port _port) {
    host = _host;
    port = _port;
  }

  void run() {
    String command = "terminator -x nc -vv -i59 "+host.addr+" "+port.port_num;

    try {     
//InvokeScript.execute(command);
      String line;
      Process p = Runtime.getRuntime().exec(command);
      BufferedReader input = new BufferedReader(new InputStreamReader(p.getInputStream()));
p.waitFor();
      while ( (line = input.readLine ()) != null) {
      println("reply: "+line);
      }
      //}

    delay(2000);
     
    }
    catch(Exception e) {
    }
    
     port.session_running = false;
  }
}

