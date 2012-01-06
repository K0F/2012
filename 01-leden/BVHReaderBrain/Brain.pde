
class Brain {
  int dim = 8;
  PVector matrix[][]; 
  float weight[][];
  int sc = 2;


  Brain(int _dim,int _sc) {
    dim = _dim;
    sc = _sc;
    
    matrix = new PVector[dim][dim];
    weight = new float[dim][dim];
    
    for (int y = 0 ; y < matrix.length;y++) {
      for (int x = 0 ; x < matrix[y].length;x++) {
        weight[x][y] = random(-1.,1.);
        matrix[x][y] = new PVector(
        random(-1.,1.)*10,
        random(-1.,1.)*10.,
        random(-1.,1.)*10.
        );
        
      }
    }
  }
  
  void step(){
    for (int y = 0 ; y < matrix.length;y++) {
      for (int x = 0 ; x < matrix[y].length;x++) {
         
         int sel = (int)random(dim);
        
         PVector r = new PVector(
         matrix[sel][sel].x,
         matrix[sel][sel].y,
         matrix[sel][sel].z
         );
         
         float a = matrix[x][y].mag();
         
         matrix[x][y].add(new PVector(
         r.x*weight[x][y],
         r.y*weight[x][y],
         r.z*weight[x][y])
         );
         
         
         
         //matrix[x][y].mult(0.99);
         matrix[x][y].normalize();
         
         
         float b = matrix[x][y].mag();
         
         
         if (a < b){
           matrix[x][y].add(matrix[(x+1)%dim][y]);
           matrix[x][y].normalize();
         }else{
           matrix[y][y].sub(matrix[x][(y+1)%dim]);
           matrix[y][y].normalize();
         }
      }
    } 
  }
  
  void draw(float _X,float _Y){
    step();
    
    for (int y = 0 ; y < matrix.length;y++) {
      for (int x = 0 ; x < matrix[y].length;x++) {
         fill(
         matrix[x][y].x*253.,
         matrix[x][y].x*255.,
         matrix[x][y].z*25.
         );
         noStroke();
         
         rect(x*sc+_X-sc*dim/2,y*sc+_Y-sc*dim/2,sc,sc);
       
      }
     
    } 
    
  }
}

