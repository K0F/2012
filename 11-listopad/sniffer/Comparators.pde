class SeqComparator implements Comparator {

  int compare(Object o1, Object o2) {
    long _seq1 = ((InnerPacket)o1).seq;
    long _seq2 = ((InnerPacket)o2).seq;

    return _seq1 == _seq2 ? 0 : (_seq1 > _seq2) ? 1 : -1;
  }
}


class TimeComparator implements Comparator {

  int compare(Object o1, Object o2) {
    String t1 = ((InnerPacket)o1).time;
    String t2 = ((InnerPacket)o2).time;
    
    long t1a = (long)parseFloat(splitTokens(t1," ")[0]);
    long t1b = (long)parseFloat(splitTokens(t1," ")[1]);
    
    long t2a = (long)parseFloat(splitTokens(t2," ")[0]);
    long t2b = (long)parseFloat(splitTokens(t2," ")[1]);
    
    long a = (long)(t1a + 0.00000001 * t1b);
    long b = (long)(t2a + 0.00000001 * t2b);

    return a == b ? 0 : (a > b) ? 1 : -1;
  }
}


