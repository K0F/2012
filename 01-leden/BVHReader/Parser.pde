class Parser {

  boolean debug = true;

  String raw[];
  String filename;

  ArrayList nodes;
  ArrayList tree;
  
  
float x,y,z;
int level;

  Parser(String _filename) {
    filename = _filename;
    raw = loadStrings(filename);

    if (debug && raw!=null)
      println("mam file "+filename+" jedeme");

    parse();
  }


  void parse() {

   
    
    
    x=y=z=0;
    
    level = 0;
    
    boolean isEnd = false;
    
    tree = new ArrayList();
    tree.add(new Node());

    for (int i =0 ;i<raw.length;i++) {
      String [] tokens = splitTokens(raw[i], "\t ");
      if (tokens[0].equals("OFFSET")) {
        x += parseFloat(tokens[1]);
        y += parseFloat(tokens[2]);
        z += parseFloat(tokens[3]);
      }else if(tokens[0].equals("JOINT") || tokens[0].equals("End")){
       String nName = tokens[1]; 
       
       
       
       
      
        
        Node parent_ = getParent();
        
        
        
        
        
        
        tree.add(new Node(tree.size(),level,parent_,new PVector(x,y,z),nName));
        
        if(debug)
        println(nf(0,level)+"| "+nName+" > parent "+parent_.name+" "+parent_.pos.y);
        
        
        
        if(nName.equals("Site")){
         isEnd=true;
       }else{
          isEnd=false;
       }
        
      }else if(tokens[0].equals("{")){
       
        
        level++; 
       
       
      }else if(tokens[0].equals("}")){
       Node parent_ = getParent();
        if(isEnd){
        
        x=parent_.pos.x;
        y=parent_.pos.y;
        z=parent_.pos.z;
        }else{
        x=parent_.pos.x;
        y=parent_.pos.y;
        z=parent_.pos.z;
          
        }
        level--; 
      }
    }// end FOR
    
    
     nodes = new ArrayList();
    for(int i = 0 ; i < tree.size();i++){
     Node n = (Node)tree.get(i);
     nodes.add(n); 
    }
  }
  

  Node getParent(){
    
   
        
        
        int wh = level-1;
        int l = 0;
        int s = tree.size()-1;
        Node parent_ = (Node)tree.get(s);
        
        while(l != wh){
          parent_ = (Node)tree.get(s);
          s--;
          l = parent_.level;
          //println(s);
         
        }
       
     return parent_;       
  }
  
  
  
  int getParentIndex(){
    
   
        Node parent_ = (Node)tree.get(tree.size()-1);
        
        int wh = level-1;
        int l = 0;
        int s = tree.size()-1;
        
        while(l != wh){
          parent_ = (Node)tree.get(s);
          s--;
          l = parent_.level;
          //println(s);
         
        }
       
     return s;       
  }

  void draw() {

    pushMatrix();
    
    translate(width/2,height/2);
    
    rotateY(radians(frameCount));
    
    scale(17.);
    //scale(0,-1.,0);
    for (int i = 0 ; i< nodes.size();i++) {

      Node node = (Node)nodes.get(i);
      Node parent = node.parent;

      
      line(node.pos.x,node.pos.y,node.pos.z,
      parent.pos.x,parent.pos.y,parent.pos.z);

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
 
 Node(int _id,int _level,Node _parent,PVector _pos,String _name){
  id = id;
  level = _level;
  parent = _parent;
  name = _name;
  
  pos = (new PVector(_pos.x,_pos.y,_pos.z));//new PVector(_pos.x,)
  //pos = new PVector(0,0,0);
  //pos = new PVector(_pos.x+parentPos.x,_pos.y+parentPos.y,_pos.z+parentPos.z);
 }
 
 
 Node(int _id,int _level,PVector _pos, Node _parent){
  id = id;
  level = _level;
  pos = _pos;
  parent = _parent;
 }
 
 ArrayList getChildren(){
   return new ArrayList();
   
 }
 
  
}

