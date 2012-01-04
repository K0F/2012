class Parser {

  boolean debug = true;

  String raw[];
  String filename;

  ArrayList nodes;

  Parser(String _filename) {
    filename = _filename;
    raw = loadStrings(filename);

    if (debug && raw!=null)
      println("mam file "+filename+" jedeme");

    parse();
  }


  void parse() {

    nodes = new ArrayList();
    
    float x,y,z;
    x=y=z=0;
    
    int level = 0;
    
    Node proxyParent = new Node();

    for (int i =0 ;i<raw.length;i++) {
      String [] tokens = splitTokens(raw[i], "\t ");
      if (tokens[0].equals("OFFSET")) {
        x = parseFloat(tokens[1]);
        y = parseFloat(tokens[2]);
        z = parseFloat(tokens[3]);
        
        if(nodes.size()==0){
         nodes.add(proxyParent);
        }
        
        nodes.add(new Node(nodes.size(),level,proxyParent,new PVector(x,y,z)));
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
    for (int i = 0 ; i< nodes.size();i++) {

      Node node = (Node)nodes.get(i);

      pushMatrix();

      translate(node.pos.x, node.pos.y, node.pos.z);
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
 String name;
 
 Node(){
  this(0,0,"root");
  pos = new PVector(0,0,0);
 } 
 
 Node(int _id,int _level,String _name){
  id = id;
  level = _level;
  name = _name;
  parent = this;
 }
 
 Node(int _id,int _level,Node _parent,PVector _pos){
  id = id;
  level = _level;
  parent = _parent;
  pos = _pos;
 }
 
 
 Node(int _id,int _level,PVector _pos, Node _parent){
  id = id;
  level = _level;
  pos = _pos;
  parent = _parent;
 }
 
  
}

