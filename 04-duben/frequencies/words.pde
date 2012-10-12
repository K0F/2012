class Dictionary {

  ArrayList database;
  ArrayList actual;
  String commons[];

  Dictionary() {

    commons = loadStrings("1-5000.txt");

    database = new ArrayList();

    for (int i =0 ; i < commons.length;i++)
      database.add(commons[i]);
  }

  public void add(String s) {
    database.add(s);
  }

  public int search(char [] chars) {
    String input = "";

    int result = 0;

    for (int i = 0 ; i < chars.length;i++) {
      input+=chars[i];
    }

    actual = new ArrayList();

    for (int i = 0 ; i < database.size();i++) {
      String tmp = (String)database.get(i)+"";
      int where = input.indexOf(" "+tmp+" ");
      if (where > 0) {
        result+=(tmp.length()*tmp.length()*tmp.length()); 
        actual.add(new Word(tmp, where));
      }
      
      /*
      String reverse = new StringBuffer(tmp).
reverse().toString();
      
      where = input.indexOf(reverse);
      if (where > 0) {
        result+=(tmp.length()*tmp.length()); 
        actual.add(new Word(tmp, where));
      }
      */
      
    }

    return result;
  }
}


class Word {
  String word;
  int where;

  Word(String _word, int _where) {
    word = _word;
    where = _where;
  }
}

  

