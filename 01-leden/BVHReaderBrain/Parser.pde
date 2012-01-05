/////////////////////////////////
//                             //
//    BVHParser by kof 2012    //
//                             //
/////////////////////////////////


class Parser {

  boolean leaveTrail = true;
  boolean debug = false;

  String raw[];
  String filename;

  ArrayList nodes;
  ArrayList tree;

  int depth = 0;
  int dLimit = 1800;
  float sx = 0,sy =0,sz = 0;


  float x, y, z, ox, oy, oz;
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
      }
      else if (tokens[0].equals("JOINT") || tokens[0].equals("End")) {
        String nName = tokens[1]; 






        Node parent_ = getParent();






        tree.add(new Node(tree.size(), level, parent_, new PVector(x, y, z), new PVector(ox, oy, oz), nName));

        if (debug)
          println(nf(0, level)+"| "+nName+" > parent "+parent_.name+" "+parent_.pos.y);



        if (nName.equals("Site")) {
          isEnd=true;
        }
        else {
          isEnd=false;
        }
      }
      else if (tokens[0].equals("{")) {


        level++;
      }
      else if (tokens[0].equals("}")) {
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
    for (int i = 0 ; i < tree.size();i++) {
      Node n = (Node)tree.get(i);
      nodes.add(n);
    }
  }


  Node getParent() {




    int wh = level-1;
    int l = 0;
    int s = tree.size()-1;
    Node parent_ = (Node)tree.get(s);

    while (l != wh) {
      parent_ = (Node)tree.get(s);
      s--;
      l = parent_.level;
      //println(s);
    }

    return parent_;
  }



  int getParentIndex() {


    Node parent_ = (Node)tree.get(tree.size()-1);

    int wh = level-1;
    int l = 0;
    int s = tree.size()-1;

    while (l != wh) {
      parent_ = (Node)tree.get(s);
      s--;
      l = parent_.level;
      //println(s);
    }

    return s;
  }

  ///////////////////////////////////////////////////

  void drawHieratical() {
    pushMatrix();

    // RECORDED MODIFICATIONS //
    translate(width/2, height/2);
    //rotateY(radians(frameCount));
    scale(20.);

    Node root = (Node)nodes.get(0);
    depth = 0;
    recurseTree(root);


    popMatrix();
  }


  ///////////////////////////////////////////////////
  // draw skeleton recursively
  void recurseTree(Node in) {
    depth++;

    pushMatrix();

    ArrayList ch = in.getChildren();
    for (int i = 0;i<ch.size();i++) {
      Node one = (Node)ch.get(i);
      //


      translate(one.offset.x, -one.offset.y, one.offset.z);


      ///////// ANIMATION HAPPENS HERE ///////////
      if (depth>=0) {
        int sel = i+depth;
        sx += (brain.matrix[sel%brain.dim][(i)%brain.dim].x*1001.0-one.rot.x)/(noise(frameCount/300.0+(depth+i))*80.0);
        sy += (brain.matrix[sel%brain.dim][(i)%brain.dim].y*1002.0-one.rot.y)/(noise(frameCount/310.0+(depth+i)*1000)*80.0);
        sz += (brain.matrix[sel%brain.dim][(i)%brain.dim].z*1003.0-one.rot.z)/(noise(frameCount/300.0+(depth+i)*2000)*80.0);
        brain.matrix[sel%brain.dim][(depth^i)%brain.dim].add(new PVector(sx,sy,sz));
        brain.matrix[sel%brain.dim][(depth^i)%brain.dim].normalize();
        
      one.rot.x += (sx-one.rot.x)/70.0;
      one.rot.y += (sy-one.rot.y)/50.0;
      one.rot.z += (sz-one.rot.z)/70.0;
      
      sx = constrain(sx,-35,0);
      sy = constrain(sy,-40/depth,0);
      sz = constrain(sz,-7,7);
      
      }
      

      //one.rot.y = (0);

      one.pos = new PVector(modelX(0, 0, 0), modelY(0, 0, 0), modelZ(0, 0, 0));

      rotateX(radians(one.rot.x));
      rotateY(radians(one.rot.y));
      rotateZ(radians(one.rot.z));


      box(1.0);  


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


      line(node.pos.x, node.pos.y, node.pos.z, 
      parent.pos.x, parent.pos.y, parent.pos.z);

      pushMatrix();

      translate(node.pos.x, node.pos.y, node.pos.z);

      node.trail.add(new PVector(node.pos.x, node.pos.y, node.pos.z));
      if (node.trail.size()>200)
        node.trail.remove(0);




      pushStyle();
      fill(0, 45);

      float X = screenX(0, 0, 0);
      float Y = screenY(0, 0, 0);
      text("<---"+node.name, X+10, Y+4);
      
      


      popStyle();

      box(0.3);

      popMatrix();



      if (leaveTrail) {
        pushStyle();

        beginShape();
        noFill();
        for (int q = 3 ; q < node.trail.size();q+=1) {

          strokeWeight(map(q, 0, node.trail.size(), 10, 1));
          stroke(0, map(q, 0, node.trail.size(), 0, 10));

          PVector t1 = (PVector)node.trail.get(q);


          vertex(t1.x, t1.y, t1.z);
        }
        endShape();
        popStyle();
      }
    }


    popMatrix();
  }

  ///////////////////////////////////////////////////
}

