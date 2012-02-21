Parser parser;
ArrayList caesars;
Viz viz;

void setup(){
  size(1280,720,P2D);

  textFont(createFont("Semplice Regular",8,false));
  textMode(SCREEN);


  parser = new Parser("caesars.csv",caesars);

  viz = new Viz(caesars);
}

void draw(){
  background(255);

  viz.draw();
}

class Viz{
  ArrayList entries;

  Viz(ArrayList _entries){
    entries = _entries;
  }

  void draw(){
    for (int i = 0 ; i < entries.size();i++){
      Person entry = (Person)entries.get(i);
      int b = entry.getBirth();
      int d = entry.getDeath();
      String name = entry.getName();

      fill(0);
      text(name,b+100,height-100);

    }
  }
}

class Parser{
  String raw[];
  String filename;
  ArrayList persons;

  Parser(String _filename, ArrayList _persons){
    persons = _persons;
    filename = _filename;
    parse();
  }

  void parse(){
    raw = loadStrings(filename);
    persons = new ArrayList();

    for (int i = 2 ; i< raw.length;i++){
      String ln = raw[i]+"";
      String parsed[] = splitTokens(ln,"\",");
      if(parsed.length>6)
        persons.add(new Person(parsed[1],parsed[2],parseInt(parsed[5]),parseInt(parsed[6])));
    }
  }
}

class Person{
  String name;
  String fullname;
  String era;
  int birth;
  int govStart;
  int govEnd;
  int death;
  String century;

  Person(String _name,String _fullname,int _birth,int _death){
    name = _name;
    birth = _birth;
    death = _death;
    fullname = _fullname;
  }

  int getBirth(){
    return birth;
  }

  int getDeath(){
    return death;
  }

  String getName(){
    return name;
  }

  String getFullname(){
    return fullname;
  }
}
