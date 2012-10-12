class Neuron {
  ArrayList ins;
  ArrayList weights;
  float val, nextVal;
  Layer parent;
  int id;
  float rate = RATE;
  float w;


  Neuron(int _id, ArrayList _ins, Layer _parent) {
    id = _id;
    parent = _parent;
    ins = _ins;
    println(id+" has "+ins.size()+" connections");
    reset();
  }

  void reset() {
    weights = new ArrayList();
    for (int i = 0 ; i < ins.size();i++)
      weights.add(random(0.0, 1.0));

    val = random(0, 1.0);
  }

  void precount() {
    nextVal = sum();
  }

  void step() {
    rate = RATE;
    val += (nextVal-val)/rate;
  }

  float sum() {
    float _sum = 0;

    for (int i =1 ; i < ins.size();i++) {
      Neuron n = (Neuron)ins.get(i);
      w = (Float)weights.get(i);
      _sum += n.val*w;
    }

    _sum /= (float)ins.size();
    return _sum;
  }
  
  void backProp(float err){
    for (int i =1 ; i < ins.size();i++) {
      w += ((Float)weights.get(i)-w)/FLEXI;
      w = constrain(w,0.000001,0.999999);
      weights.set(i, (err+random(-STOCHAISM,STOCHAISM)-w)/FLEXI);
    }
  }
}

