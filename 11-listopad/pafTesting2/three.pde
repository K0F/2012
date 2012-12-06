
float[][] vls;
int nn = 10;



void three() {
  
  cam.beginHUD();
  
  tras(ctl[24]);
  
  noStroke();
  fill(0,30);
  rect(0,0,width,height);

  for ( int i = 0; i < in.bufferSize() - 1; i++ ) {
    // find the x position of each buffer value
    float x1  =  map( i, 0, in.bufferSize(), 0, width );
    float x2  =  map( i+1, 0, in.bufferSize(), 0, width );


    for (int j = 2 ; j < nn;j++) {

      if (j==2) {
        pushMatrix();
        
        translate(map(i, 0, in.bufferSize(), 0, width), height/2);
        //rotate(radians(frameCount*8.0));
        
        for (int z = 200 ; z < 10000;z+=2000) {

        vls[j][i] += ((in.left.get(i)*noise((i+j+frameCount)/(128-ctl[8]))*z)-vls[j][i]/(128-ctl[9]))/(float)(j+800.1+2.0);

        translate(j/30.0, vls[j][i]);
        rotate(i/(in.bufferSize()+0.0)+frameCount/30.0);


        stroke(255,ctl[1]*2);//noise(0, (frameCount+i+j+z)/200.0)*255, 35, 255, 15);
        //  stroke( 255, 15);

        line(0, 0,1,0);
      }
        popMatrix();
        
      }
    }
  }
  
  cam.endHUD();
}

/*

 
 
 // draw the waveforms
 for ( int i = 0; i < in.bufferSize() - 1; i++ ){
 // find the x position of each buffer value
 float x1  =  map( i, 0, in.bufferSize(), 0, width );
 float x2  =  map( i+1, 0, in.bufferSize(), 0, width );
 // draw a line from one buffer position to the next for both channels
 
 
 int cnt = 0;
 
 for (int j = 2 ; j < nn;j++) {
 
 if (j==2) {
 resetMatrix();
 
 translate(map(i, 0, in.bufferSize(), 0, width), height/2);
 //rotate(radians(frameCount*8.0));
 }
 
 
 for (int z = 200 ; z < 10000;z+=2000) {
 
 vls[j][i] += ((in.left.get(i)*noise((i+j+frameCount)/30.0)*z)-vls[j][i])/(float)(j+800.1+2.0);
 
 translate(j/30.0, vls[j][i]);
 rotate(i/(int.bufferSize()+0.0));
 
 
 stroke(noise(0, (frameCount+i+j+z)/200.0)*255, 35, 255, 15);
 //  stroke( 255, 15);
 
 point(0, 0);
 }
 
 
 }
 }
 */
