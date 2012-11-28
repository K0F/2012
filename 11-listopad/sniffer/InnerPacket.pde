class InnerPacket {
  ///////////////////////////////////////////////////////////
  String time;
  long seq;
  byte data[], header[];
  String src, dest;
  boolean jpegHead = false;
  ///////////////////////////////////////////////////////////

  InnerPacket(String _src, String _dest, long _seq, String _time, byte[] _header, byte[] _data) {

    src = _src;
    dest = _dest;
    time = _time;
    seq = _seq;
    data = new byte[_data.length];
    header = new byte[_header.length];



    for (int i = 0 ; i < header.length;i++) {
      header[i] = _header[i];
    }

    for (int i = 0 ; i < data.length;i++) {
      data[i] = _data[i];
    }
    
    
    jpegHead = hasJpegHeader();
  }

  ////////////////////////////////////////////////////////////

  boolean hasJpegHeader(){
    String output = "";
    try{
    output = new String(data, "US-ASCII");
    }catch(Exception e){ println("Error: wrong encoding selected!");}
    
    boolean isJpegPacket = (output.indexOf("image/jpeg")>-1)?true:false;


    if (isJpegPacket) {
     println("bang! has jpeg header");
     }

    return isJpegPacket;
  }
}

