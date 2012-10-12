PFont font;
ArrayList nodes;

int focus = 0;

color nodes_foreground = color(220);
color nodes_background = color(11,11,11);
color background_color = color(0);


void setup(){

  size(640,480,P2D);

  font = loadFont("65Amagasaki-8.vlw");
  textFont(font);
  textMode(SCREEN);

  nodes = new ArrayList();
}

void draw(){

  background(background_color);

  for(int i  =0 ; i < nodes.size();i++){
    Node tmp = (Node)nodes.get(i);
    tmp.compute();
    tmp.draw();
  }

}

void mouseClicked(){

  Node tmp = new Node(mouseX,mouseY,nodes.size());
  nodes.add(tmp);
  focus = tmp.id;

}




class Node{
  PVector pos;
  ArrayList ins;
  ArrayList outs;
  ArrayList args;

  int id;

  String name;

  boolean opened = true;

  int carret;

  Node(float x, float y,int _id){
    pos = new PVector(x,y);
    id = _id;

    ins =  new ArrayList();
    outs =  new ArrayList();
    args =  new ArrayList();

    name = " ";

    carret = 0;
  }

  void setName(String _name){

    name=_name+"";

  }

  void compute(){


  }

  void draw(){


    stroke(nodes_foreground);
    fill(nodes_background);

    rect(pos.x-4,pos.y+2,textWidth(name)+8,-10);

    fill(nodes_foreground);
    text(name,pos.x,pos.y);

    if(opened)
      text("|");

  }
}

class Drat{
  Node parent,child;
  Outlet begin;
  Inlet end;

  



}

class Inlet{
  PVector pos;
  float snap_value = 10;

  boolean over(){
    return (dist(mouseX,mouseY,pos.x,pos.y)<snap_value);
  }
}

class Outlet extends Inlet{

  Outlet(){

    super();
  }


}
