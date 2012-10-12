
import supercollider.*;
import oscP5.*;

ArrayList instruments;

float baseFreq = 1.0 ;//523.25/4.0;


float tuning[] = {55,61.735,65.406,73.416,82.407,87.307,97.999,110,123.471,130.813,146.832,
164.814,174.614,195.998,220,233.082,246.942,261.626,293.665,329.628,349.228,391.995,440.0,493.883,523.251,587.33,};

String synthD = "sin";

int tick = 15;
int time = 0;
int al = 0;

boolean first = false;

String input = "";

void setup() {
  size(800, 400, P2D); 
  textFont(loadFont("Monospaced.plain-10.vlw"));
textMode(SCREEN);
  frameRate(60);

  instruments = new ArrayList();
}

void draw() {
  timer();
  background(0);


  fill(255);
  text(input, 10, 20+instruments.size()*10);
  
  fill(al);
  rect(input.length()*6+10,20+instruments.size()*10-9,6,10);
    

grid();


  for (int i = 0;i<instruments.size();i++) {
    Instrument tmp = (Instrument)instruments.get(i);
    tmp.trigger();
    tmp.draw();
  }
  
  panel();
}

void panel(){
 int cnt = 0;
  for(char c = 'a';c<='z';c++){
    if(cnt%2==0)
    fill(255);
    else
    fill(#ffcc00);
    
    cnt++;
   text(c,cnt*8,height-10);
  }
  
  
  text("tempo => "+(60.0/(tick+0.0))*60,width-100,height-10);
  
  if(first)
  al = 220;
  
  if(al>0)
  al-=20;
  
  fill(#ffcc00,al);
  rect(width-110,height-15,5,5);
  
}

void grid(){
  stroke(255,90);
  
 for(int i = 10+5*6;i<width;i+=(4*6)){
  line(i,10,i,instruments.size()*10+20);
 }

noStroke(); 
}

void timer() {

  first = false;

  if (frameCount%tick==0) {
    time++;
    first =  true;
  }
}





void keyPressed() {
  if (key>='a'&&key<='z'||key==' '||key=='>'||key=='='||key=='!'||(key>='0'&&key<='9')) {
    input+=key+"";
  }
  else if (keyCode==ENTER) {
    addInstrument();
  }else if(keyCode==BACKSPACE){
   if(input.length()>0)
    input =  input.substring(0,input.length()-1);
    
  }else if(keyCode==DELETE){
    if(instruments.size()-1>0);
   instruments.remove(instruments.size()-1); 
  }else if(keyCode==UP){
   tick--;
   tick=constrain(tick,1,200); 
  }else if(keyCode==DOWN){
   tick++;
  tick=constrain(tick,1,200); 
  }
}

void addInstrument() {

  instruments.add(new Instrument(instruments.size(), synthD, input));
  input = "";
}

void exit() {
for (int i = 0;i<instruments.size();i++) {
    Instrument tmp = (Instrument)instruments.get(i);
    tmp.free();
}
  super.exit();
}

