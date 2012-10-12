
GLModel createPlane(float _w,float _h){
  GLModel model;

ArrayList vertices = new ArrayList();
  ArrayList normals = new ArrayList();  
  ArrayList texcoords = new ArrayList();  
  
  
  
  vertices.add(new PVector(_w/2.0, -_h/2.0, 0));
  vertices.add(new PVector(-_w/2.0, -_h/2.0, 0));
  
  vertices.add(new PVector(_w/2.0, _h/2.0, 0));
  vertices.add(new PVector(-_w/2.0, _h/2.0, 0));
  
  
  model = new GLModel(this, vertices.size(), QUAD_STRIP, GLModel.STATIC);
  model.updateVertices(vertices);
  
      //   normals.add(new PVector(nx, ny, nz));         
       //  texcoords.add(new PVector(u, v));
         
         return model; 
  
}
