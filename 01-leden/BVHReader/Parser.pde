class Parser {

  boolean debug = true;

  String raw[];
  String filename;

  ArrayList body;

  Parser(String _filename) {
    filename = _filename;
    raw = loadStrings(filename);

    if (debug && raw!=null)
      println("mam file "+filename+" jedeme");

    parse();
  }


  void parse() {

    body = new ArrayList();
    
    float x,y,z;
    x=y=z=0;
    
    int level = 0;

    for (int i =0 ;i<raw.length;i++) {
      String [] tokens = splitTokens(raw[i], "\t ");
      if (tokens[0].equals("OFFSET")) {
        x = parseFloat(tokens[1]);
        y = parseFloat(tokens[2]);
        z = parseFloat(tokens[3]);
        
        if(nodes.size()==0){
         nodes.add(new Node(0,level)); 
        }
        
        body.add(new PVector(x, y, z));
      }else if(tokens[0].equals("{")){
       level++; 
      }else if(tokens[0].equals("}")){
       level--; 
      }
    }// end FOR
  }

  void draw() {

    pushMatrix();
    
    translate(width/2,height/2);
    
    rotateX(radians(frameCount));
    
    scale(30.);
    for (int i = 0 ; i< body.size();i++) {

      PVector bod = (PVector)body.get(i);

      pushMatrix();

      translate(bod.x, bod.y, bod.z);
      box(0.1);

      popMatrix();
    }


    popMatrix();
  }
}

class Node{
 PVector pos;
 PVector rot;
 Node parent;
 ArrayList childs;
 int id,level;
 
 Node(){
  this(0,0);
 } 
 
 Node(int _id,int _level){
  id = id;
  level = _level;
  parent = this;
 }
 
 Node(int _id,int _level,PVecotr _pos){
  id = id;
  level = _level;
  parent = this;
  pos = _pos;
 }
 
 
 Node(int _id,int _level,PVecotr _pos, Node _parent){
  id = id;
  level = _level;
  parent = this;
  pos = _pos;
  parent = _parent;
 }
 
 Node(int _id,int _level,PVecotr _pos, Node _parent,ArrayList _childs){
  id = id;
  level = _level;
  parent = this;
  pos = _pos;
  parent = _parent;
  childs = _childs.get();
 }
  
}

