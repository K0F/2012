Bisector default_bisector;

class Voronoi{
  Cell[] cells = new Cell[1000];
  int ncells = 0;
  Polygon boundary;
  Voronoi(Point[] $points,Polygon $boundary){
    boundary = $boundary.get_convex_hull();
    Point p1 = new Point(-9999,-9999,0);
      Point p2 = new Point(-9999,-9998,0);
      default_bisector = new Bisector(p1,p2);
    for(int i=0;i<$points.length;i++){
      add_cell($points[i]);
    }
  }
  void add_cell(Point $p){
    for(int i=0;i<ncells;i++){
      if($p.get_distance_to(cells[i].p.x,cells[i].p.y,cells[i].p.z)<distance_tolerance){ return; }
    }
    Cell c = new Cell($p);
    cells[ncells] = c;
    ncells++;
    Cell[] cs = {c};
    if(ncells==1){
      Subcell s = new Subcell(boundary);
      s.c = c;
      c.subcells[0] = s;
      c.nsubcells++;
    }else{
      String[][] directions = new String[1000][100]; Polygon[][][] polygons = new Polygon[1000][100][2]; Subcell[][] subcells = new Subcell[1000][100]; Bisector[] bisectors = new Bisector[1000]; boolean skippers[] = new boolean[1000];
      for(int i=0;i<ncells-1;i++){
        Bisector b = new Bisector(cells[i].p,c.p);
        bisectors[i] = b;
        skippers[i] = true;
        for(int j=0;j<cells[i].nsubcells;j++){
          subcells[i][j] = cells[i].subcells[j];
          if(cells[i].subcells[j].boundary.is_splittable(b.l)){
            polygons[i][j] = cells[i].subcells[j].boundary.split(b.l);
            directions[i][j] = "split";
            skippers[i] = false;
          }else{
            directions[i][j] = "associate";
          }
        }
      }
      for(int i=0;i<ncells-1;i++){
        //if none of this cell's subcells are affected, skip it
        if(skippers[i]){ continue; }
        int nsubcells = cells[i].nsubcells;
        cells[i].nsubcells = 0;
        cells[i].consolidated = false;
        cs = new Cell[2];
        cs[0] = c; cs[1] = cells[i];
        for(int j=0;j<nsubcells;j++){
          if(directions[i][j]=="associate"){
            //associate subcells whose cells are affected but are not split
            subcells[i][j].associate(cs,bisectors[i],true);
          }else if(directions[i][j]=="split"){
            //replace split subcells
            cells[i].remove_subcell(subcells[i][j]);
            Subcell s1 = new Subcell(polygons[i][j][0]);
            s1.associate(cs,bisectors[i],false);
            Subcell s2 = new Subcell(polygons[i][j][1]);
            s2.associate(cs,bisectors[i],false);
          }
        }
      }
      for(int i=0;i<ncells;i++){
        cells[i].consolidate();
      }
    }
  }
  Cell get_containing_cell(float $x,float $y){
    Cell c = cells[0];
    for(int i=0;i<ncells;i++){
      for(int j=0;j<cells[i].nsubcells;j++){
        if(cells[i].subcells[j].boundary.is_coord_inside($x,$y,true)){ c = cells[i]; return c; }
      }
    }
    return c;
  }
  void render(){
    for(int i=0;i<ncells;i++){
      cells[i].render();
    }
  }
}
