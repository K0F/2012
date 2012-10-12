class Instrument {
  String pattern;
  String synthDef;
  Synth synth;
  int id;
  PVector pos;
  float amp;
  float freq;
  float dur;

  Instrument(int _id, String _synthDef, String _pattern) {
    id = _id;
    
    String args[] = splitTokens(_pattern,"=>!");
    
    
    synthDef = args[0];
    pattern = args[1];
    dur = parseInt(args[2]);
    

    
    synth = new Synth(synthDef);
    pos = new PVector(10, id*10+20);
  }

  void trigger() {
    if (pattern.charAt(time%pattern.length())>='a' &&
      pattern.charAt(time%pattern.length()) <= 'z' &&
      first) {
      freq = ((int)pattern.charAt(time%pattern.length()))-96;
      float harmonics = tuning[(int)freq-1] * baseFreq;//(pow(3.0, (freq)/12.0+1.0 )) * baseFreq + baseFreq;
      
      
      
     println(freq+ " >> "+ harmonics);
      
      
      
      synth.set("freq", harmonics);
      synth.set("amp",random(3,10)*0.002);
      synth.set("dur",random(dur/20.0,dur/10.0));
      
      synth.create();
      synth.free();
      
    }
  }
  
  void free(){
   synth.free(); 
  }

  void draw() {
    fill(#ff0000);
    noStroke();
    float t = (time%pattern.length())*6+pos.x+(synthDef.length()+2)*6;
    rect(t, pos.y-9, 6, 10);

    fill(#ffcc00);
    text(synthDef+"=>"+pattern+"!"+(int)dur, pos.x, pos.y);
  }
}

