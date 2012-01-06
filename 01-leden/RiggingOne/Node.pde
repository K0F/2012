
class Node {
  PVector pos;
  PVector offset;
  PVector rot;
  Node parent;
  ArrayList childs;
  int id, level;
  String name;


  ArrayList trail;

  Node() {
    this(0, 0, "root");
    pos = new PVector(0, 0, 0);
    offset = new PVector(0, 0, 0);
    rot = new PVector(0, 0, 0);
    trail = new ArrayList();
  }
  
  
  

  Node(int _id, int _level, String _name) {
    id = id;
    level = _level;
    name = _name;

    childs = new ArrayList();

    parent = this;
  }

  Node(int _id, int _level, Node _parent, PVector _pos, PVector _offset, String _name) {
    id = id;
    level = _level;
    parent = _parent;
    name = _name;


    offset = new PVector(_offset.x, _offset.y, _offset.z);
    pos = (new PVector(_pos.x, _pos.y, _pos.z));
    rot = new PVector(0, 0, 0);

    childs = new ArrayList();
    parent.addChild(this);

    trail = new ArrayList();
  }


  Node(int _id, int _level, PVector _pos, Node _parent) {
    id = id;
    level = _level;
    pos = _pos;
    parent = _parent;
  }

  void addChild(Node n) {
    childs.add(n);
  }

  ArrayList getChildren() {
    return childs;
  }
}

