// Simple sniffer by kof 12
// run it as system administrator (root)


import java.net.*;
import java.io.*;
import jpcap.JpcapCaptor;
import jpcap.JpcapSender;
import jpcap.NetworkInterface;
import jpcap.NetworkInterfaceAddress;
import jpcap.packet.*;

import java.awt.Toolkit;

int PACKETS_PER_SESSION = 1000;
int MAX_PACKET_SIZE = 65535;

ArrayList sessions;
ArrayList IMAGES;

JpcapCaptor captor;
NetworkInterface[] list;
String str, info;
int x;

int cnt = 0;

int device = 1;


void setup() {

  size(1024, 768, P2D);

  IMAGES = new ArrayList();
  sessions = new ArrayList();

  textFont(loadFont("65Amagasaki-8.vlw"));
  textMode(SCREEN);


  /* first fetch available interfaces to listen on */
  list = JpcapCaptor.getDeviceList();
  System.out.println("Available interfaces: ");

  for (int i = 0 ; i < list.length;i++) {
    println(i);
    for (byte b : list[i].mac_address) {
      print(Integer.toHexString(b&0xff) + ":");
    }
    println();
  }

  System.out.println("-------------------------\n");
  //Integer.parseInt(getInput("Choose interface (0,1..): "));
  System.out.println("Listening on interface -> "+list[device].description);
  System.out.println("-------------------------\n");


  try {
    captor=JpcapCaptor.openDevice(list[device], MAX_PACKET_SIZE, false, 20);
    /* listen for TCP/IP only */
    captor.setFilter("ip and tcp src port 80", true); // src port 80
  }
  catch(IOException ioe) { 
    ioe.printStackTrace();
  }

  background(0);
}

void draw() {

  background(0);


  try {

    TCPPacket info = (TCPPacket)captor.getPacket();
    if (info != null) {
      ///////////////////////////////////
      byte h[] = info.header;
      byte d[] = info.data;
      String usec = info.sec+" "+info.usec;
      long seq = info.sequence;
      String src = splitTokens(info.toString(), "/-> ")[1];
      String dest = splitTokens(info.toString(), "/-> ")[2];
      /////////////////////////////////////////////////////////////

      boolean isNewSession = false;
      int which = 0;

anysession:
      for (int i = 0 ; i < sessions.size();i++) {
        InnerSession s = (InnerSession)sessions.get(i);
        if (s.src.equals(src) && s.dest.equals(dest)) {
          isNewSession = true;
          which = i;
          break anysession;
        }
      }

      /////////////////////////////////////////////////////////////

      if (isNewSession) {
        InnerSession tmp = (InnerSession)sessions.get(which);
        tmp.packets.add(new InnerPacket(src, dest, seq, usec, h, d));
      }
      else {
        sessions.add(new InnerSession(src, dest));
        InnerSession tmp = (InnerSession)sessions.get(sessions.size()-1);
        tmp.packets.add(new InnerPacket(src, dest, seq, usec, h, d));
        tmp.ordnung();
      }

      /////////////////////////////////////////////////////////////
      /*
      for (int i = 0 ; i < d.length;i++) {
       stroke((int)(d[i]+127), 40);
       point(cnt%width, cnt/width);
       
       //feed.add(d[i]);
       cnt++;
       }
       
       */
      ////////////////////////////////////////////////////////////////
    }//end if NULL
  }
  catch(Exception e) {
    ;
  }


  //////////////////////////  DRAW //////////////////////////////////////////////////////////////
  
  
  try{
  for (int i = 0 ; i < IMAGES.size();i++) {
    PImage img = (PImage)IMAGES.get(i);
    image(img,0,0);
  }
  }catch(Exception e){;}
  

  for (int i = 0 ; i < sessions.size();i++) {

    fill(127, 255, 34);
    InnerSession tmp = (InnerSession)sessions.get(i);
    tmp.limit();

    text(tmp.src+" -> "+tmp.dest, 10, i*10+10);
    for (int p = 0 ; p < tmp.packets.size();p++) {
      InnerPacket ip = (InnerPacket)tmp.packets.get(p);
      //fill( !ip.jpegHead ? color(255) : color(255, 0, 0) );
      if (!ip.jpegHead)
        text(".");
      else
        text("|");
    }
  }

  if (sessions.size()>height/10)
    sessions.remove(0);

  if (cnt>width*height)
    cnt = 0;
}



String getInput(String q) {
  String input = "";
  System.out.print(q);
  BufferedReader bufferedreader = new BufferedReader(new InputStreamReader(System.in));
  try {
    input = bufferedreader.readLine();
  }
  catch(IOException ioexception) {
  }
  return input;
}


String getPacketText(Packet pack) {
  int i=0, j=0;
  byte[] bytes=new byte[pack.header.length + pack.data.length];

  System.arraycopy(pack.header, 0, bytes, 0, pack.header.length);
  System.arraycopy(pack.data, 0, bytes, pack.header.length, pack.data.length);
  StringBuffer buffer = new StringBuffer();

  for (i=0; i<bytes.length;) {
    for (j=0;j<8 && i<bytes.length;j++,i++) {
      String d = Integer.toHexString((int)(bytes [i] &0xff));
      buffer.append((d.length() == 1 ? "0" + d:d ) + " ");

      if (bytes[i]<32 || bytes[i]>126) 
        bytes[i] = 46;
    }
  }
  return new String(bytes, i - j, j);
}

void keyPressed() {

  for (int i = 0 ;i < sessions.size();i++) {
    InnerSession s = (InnerSession)sessions.get(i);
    s.ordnung();
    s.check();
    s.collect();
    
  }
}

