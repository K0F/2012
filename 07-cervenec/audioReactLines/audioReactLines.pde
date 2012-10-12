import processing.opengl.*;
import javax.media.opengl.GL;
import ddf.minim.*;
import promidi.*;

int ctl[] = new int[64];

float rots[] = new float[1024];


float rotsX[] = new float[1024];
float rotsY[] = new float[1024];
float rotsZ[] = new float[1024];



MidiIO midiIO;

Minim minim;
AudioInput in;

PGraphicsOpenGL pgl; //need to use this to stop screen tearing
GL gl;
float avg = 0;

float al = 40;

void setup()
{
  size(1024, 768, OPENGL);
  pgl = (PGraphicsOpenGL) g; //processing graphics object
  gl = pgl.beginGL(); //begin opengl
  gl.setSwapInterval(1); //set vertical sync on
  pgl.endGL(); //end opengl
  
  frameRate(60);
  
  //colorMode(HSB);
  

  minim = new Minim(this);
  minim.debugOn();
  
  // get a line in from Minim, default bit depth is 16
  in = minim.getLineIn(Minim.STEREO, width);
  background(0);
  
  //get an instance of MidiIO
  midiIO = MidiIO.getInstance(this);
  println("printPorts of midiIO");
  
  //print a list of all available devices
  midiIO.printDevices();
  
  //open the first midi channel of the first device
  midiIO.openInput(0,0);
  
  preset();
}

///////////////

void controllerIn(promidi.Controller controller, int device, int channel){
  try{
  int num = controller.getNumber();
  int val = controller.getValue();
  
  ctl[num] = val;
  println(num);
  }catch(Exception e){
    
  }
  
}


/////////////////////////

void draw()
{
  //background(0);
  //stroke(255);
  
  int pos = frameCount%height;
  
  al = ctl[33]*2.0;
  
 
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    
    stroke((in.left.get(i)*ctl[34]*2),(in.right.get(i)*ctl[35]*2),0,al);
    line(i,0,i,height);
    
    
   avg += ((in.left.get(i)+in.right.get(i))*2000.0-avg)/30000.0;
}

pushMatrix();
translate(width/2,height/2);
rectMode(CENTER);
  for(int i = 0; i < in.bufferSize() - 1; i+=5)
  {
noFill();
stroke(255,ctl[22]);
rots[i] += (lerp(0,in.right.get(i),ctl[21]/2.0)-rots[i])/10.0;
rotate(radians(rots[i])*10);
rect(0,0,i,i);
  }
  
  popMatrix();
  


fill(ctl[46]*2,ctl[47]);
noStroke();
ellipse(width/2,height/2,400+avg,400+avg);


}


void stop()
{
  // always close Minim audio classes when you are done with them
  in.close();
  minim.stop();
  
  super.stop();
}
