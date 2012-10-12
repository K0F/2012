class Cell{
  Point p;
  Subcell[] subcells = new Subcell[100];
  int nsubcells = 0;
  Polygon boundary;
  boolean consolidated = false;
  Cell(Point $p){
    p = $p;
  }
  void remove_subcell(Subcell $s){
    Subcell[] temp = new Subcell[100];
    arraycopy(subcells,temp);
    int ntemp = nsubcells;
    int nsubcells = 0;
    subcells = new Subcell[100];
    for(int i=0;i<ntemp;i++){
      if(temp[i]!=$s){
        subcells[nsubcells] = temp[i];
        subcells[nsubcells].c = this;
        nsubcells++;
      }
    }
  }
  void consolidate(){
    if(nsubcells<=1&&consolidated){ return; }
    Point[] temp1 = {};
    for(int i=0;i<nsubcells;i++){
      Point[] temp2 = (Point[]) subset(subcells[i].boundary.points,0,subcells[i].boundary.npoints);
      temp1 = (Point[]) concat(temp1,temp2);
    }
    Polygon pointset = new Polygon(temp1);
    boundary = pointset.get_convex_hull();
    nsubcells = 0;
    subcells = new Subcell[100];
    subcells[nsubcells] = new Subcell(boundary);
    subcells[nsubcells].c = this;
    nsubcells++;
    consolidated = true;
  }
  void render(){
    for(int i=0;i<nsubcells;i++){
      subcells[i].render();
    }
    p.render();
  }
}
