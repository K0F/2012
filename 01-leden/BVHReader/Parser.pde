class Parser {

  boolean debug = true;

  String raw[];
  String filename;

  ArrayList nodes;
  ArrayList tree;
  
  int depth = 0;
  int dLimit = 1800;
  
  
float x,y,z,ox,oy,oz;
int level;

  Parser(String _filename) {
    filename = _filename;
    raw = loadStrings(filename);

    if (debug && raw!=null)
      println("mam file "+filename+" jedeme");

    parse();
  }


  void parse() {

   
    
    
    ox=oy=oz=x=y=z=0;
    
    level = 0;
    
    boolean isEnd = false;
    
    tree = new ArrayList();
    tree.add(new Node());

    for (int i =0 ;i<raw.length;i++) {
      String [] tokens = splitTokens(raw[i], "\t ");
      if (tokens[0].equals("OFFSET")) {
        ox = parseFloat(tokens[1]);
        oy = parseFloat(tokens[2]);
        oz = parseFloat(tokens[3]);
        
        x += ox;
        y += oy;
        z += oz;
      }else if(tokens[0].equals("JOINT") || tokens[0].equals("End")){
       String nName = tokens[1]; 
       
       
       
       
      
        
        Node parent_ = getParent();
        
        
        
        
        
        
        tree.add(new Node(tree.size(),level,parent_,new PVector(x,y,z),new PVector(ox,oy,oz),nName));
        
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
        //if(isEnd){
        
        x=parent_.pos.x;
        y=parent_.pos.y;
        z=parent_.pos.z;
        //}else{
        //x=parent_.pos.x;
        //y=parent_.pos.y;
        //z=parent_.pos.z;
          
        //}
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
  
  ///////////////////////////////////////////////////
  
  void drawHieratical(){
    pushMatrix();
    translate(width/2,height/2);
    //rotateY(radians(frameCount));
    scale(20.);
    
    Node root = (Node)nodes.get(0);
     depth = 0;
    recurseTree(root);
    
    
    popMatrix();
    
  }
  
  
  ///////////////////////////////////////////////////
  // draw skeleton recursively
  void recurseTree(Node in){
    depth++;
  
    pushMatrix();
    
    ArrayList ch = in.getChildren();
    for(int i = 0;i<ch.size();i++){
     Node one = (Node)ch.get(i);
     //
     
     
     translate(one.offset.x,-one.offset.y,one.offset.z);
     
     
     if(depth>1){
     one.rot.x = (cos(frameCount/(33.0+depth)+1)*(-15.));
     one.rot.y = ((sin(frameCount/41.0))*15.);
     //one.rot.z = (atan(frameCount/40.0)*-10.);
     }
     
     //one.rot.y = (0);
     
     one.pos = new PVector(modelX(0,0,0),modelY(0,0,0),modelZ(0,0,0));
     
     rotateX(radians(one.rot.x));
     rotateY(radians(one.rot.y));
     rotateZ(radians(one.rot.z));
     
     
     box(0.53);  
  
 
     recurseTree(one);
     
     
     //
    }
    popMatrix();
  
  }
  
  
  ///////////////////////////////////////////////////

  void draw() {

    pushMatrix();
    
   // translate(-width/2,-height/2);
    
    //rotateY(radians(frameCount));
    
    //scale(17.);
    //scale(0,-1.,0);
    
    for (int i = 2 ; i< nodes.size();i++) {

      Node node = (Node)nodes.get(i);
      Node parent = node.parent;

      
      line(node.pos.x,node.pos.y,node.pos.z,
      parent.pos.x,parent.pos.y,parent.pos.z);

      pushMatrix();

      translate(node.pos.x, node.pos.y, node.pos.z);
      
      box(0.3);

      popMatrix();
    }


    popMatrix();
  }
  
  ///////////////////////////////////////////////////
}

