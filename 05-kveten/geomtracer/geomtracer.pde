void setup(){

  size(320,240,P2D);
  noiseSeed(19);
}



void draw(){
  background(0);
  int num = (int)((sin(frameCount/60.0)+2.01)*300.0);
  float f = 2.0f*PI/(float)num;
  float a = cos(f);
  float b = sin(f);
  float s = 0.0;
  float c = 100;
  float qc = 0;
  float qs = 0;


  float z = 10.0*noise(frameCount/300.0);

  pushMatrix();
  translate(width/2,height/2);

  for(int i = frameCount ; i < frameCount+200 ;i ++){

    float R = 255.0*noise((i+frameCount)/100.0,0,0);
    float G = 255.0*noise(0,(i+frameCount)/100.0,0);
    float B = 255.0*noise(0,0,(i+frameCount)/100.0);

    for( int n=0; n < num; n++ )
    {
      float ns = b*c + a*s;
      float nc = a*c - b*s;
      
      c += (nc-c) / z;
      s += (ns-s) / z;

      //qc *= ((c-nc)-qc)/(10.0);
      //qs *= ((s-ns)-qs)/(10.0);

    //  c += (nc-c)*qc;
    //  s += (ns-s)*qs;



      stroke(R,G,B,(s+c+frameCount+i)%25);
      point(c,s);
    }
  }
  popMatrix();
}
