class ToneInstrument implements Instrument
{ 
  Oscil toneOsc;
  ADSR adsr;
  AudioOutput out;
  Damp  damp;
  ToneInstrument( String note, float amplitude, Waveform wave, AudioOutput output )
  {
    
    out = output;
    
    float frequency = Frequency.ofPitch( note ).asHz();
    
    toneOsc = new Oscil( frequency, amplitude, wave );
    adsr = new ADSR( 1.0, 0.01, 0.01, 1.0, 0.1 );
    damp = new Damp( random(0.0001,10.0), random(0.001,20.0) );
    
    
     toneOsc.patch( adsr ).patch(damp);
    
  }
  
 
  void noteOn( float dur )
  {
    
    adsr.noteOn();
    damp.setDampTimeFromDuration( dur );
    damp.activate();
    adsr.patch( out );
  }
  
  void noteOff()
  {
    
    adsr.noteOff();
   
    damp.unpatchAfterDamp( out );
    adsr.unpatchAfterRelease( out );
  }
}
