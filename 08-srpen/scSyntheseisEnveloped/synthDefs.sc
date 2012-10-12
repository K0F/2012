s=Server.local;
s.boot();


(
 SynthDef.new("sin", {arg out = 0, freq = 110, amp = 0.2,
   dur = 1;
   var sin, env_gen, env;

   env = Env.triangle(dur, amp);
   env_gen = EnvGen.kr(env);
   sin = SinOsc.ar(freq ,mul: env_gen);
   Out.ar(0, sin);
   Out.ar(1, sin);
   }).load(s);
 )
(
 SynthDef.new("saw", {arg out = 0, freq = 110, amp = 0.2,
   dur = 1;
   var sin, env_gen, env;

   env = Env.triangle(dur, amp);
   env_gen = EnvGen.kr(env);
   sin = Saw.ar(freq  , mul: env_gen);
   Out.ar(0, sin);
   Out.ar(1, sin);
   }).load(s);
 )

Synth.new("sin");
