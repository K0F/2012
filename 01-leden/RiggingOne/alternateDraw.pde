void drawModel() {

  try {

    PVector v = null, vt = null, vn = null;



    Material tmpMaterial = null;



    Segment tmpModelSegment;

    Face tmpModelElement;



    textureMode(NORMAL);



    // render all triangles

    for (int s = 0; s < model.getSegmentCount(); s++) {



      tmpModelSegment = model.getSegment(s);



      //tmpMaterial = model.getMaterial(tmpModelSegment.materialName);



      // if the material is not assigned for some

        // reason, it uses the default material setting

     




      for (int f = 0; f < tmpModelSegment.getFaceCount(); f++) 

      {

        tmpModelElement = (tmpModelSegment.getFace(f));



        if (tmpModelElement.getVertIndexCount() > 0) 

        {



          
          
          beginShape(QUAD); // specify render mode




            //  texture(original);
          


          for (int fp = 0; fp < tmpModelElement.getVertIndexCount(); fp++) {

            v = model.getVertex(tmpModelElement.getVertexIndex(fp));



            if (v != null) 

            {

              try {

                if (tmpModelElement.normalIndices.size() > 0) {

                  vn = model.getNormal(tmpModelElement.getNormalIndex(fp));

                  normal(vn.x, vn.y, vn.z);
                }





                  vt = model.getUV(tmpModelElement.getTextureIndex(fp));
                  
                  //strokeWeight(map(screenZ(v.x,v.y,v.z),0.78,0.98,1,5));
                  //stroke(0,80);
      
                  
                  
                 
                  vertex(v.x, v.y, v.z, vt.x, vt.y);
                
              } 
              catch (Exception e) {

                e.printStackTrace();
              }
            } 
            else

                vertex(v.x, v.y, v.z);
          }



          endShape();
          
          
        }
      }



      textureMode(IMAGE);
    }
  } 
  catch (Exception e) {

    e.printStackTrace();
  }
}

void ownDraw(){
 for (int i =0 ; i < model.getFaceCount();i++) {
   Face f = model.getFaceInSegment(0, i);
  
textureMode(NORMALIZED);
 beginShape();
 
// texture(original);
for (int ii = 0;ii<f.vertexIndices.size();ii++) {
      //tint(#FFCC00,200);
      
      
      PVector uv = new PVector(0,0,0);
      PVector normal = new PVector(0,0,0);
      PVector vert = new PVector(0,0,0);
      
      
      
     // try{
      
      vert = model.getVertex(f.vertexIndices.get(ii));
      uv = f.uvs.get(f.uvIndices.get(ii));
      
      
      
      normal = f.normals.get(f.normalIndices.get(ii));
     
      
      
      
      //}catch(Exception e){}
      
      
      //strokeWeight(map(screenZ(vert.x,vert.y,vert.z),0.85,1.1,1,80));
      //stroke(0,40);
      
      normal(normal.x,normal.y,normal.z);
      
      
      
      //if(brightness(original.pixels[(int)((uv.y*height)*width+(uv.x*width))])<200)
      vertex(vert.x,vert.y,vert.z,uv.x,uv.y);
      
      }
      
endShape();
      }
      
      
}

///////////////////////////////////////
 





