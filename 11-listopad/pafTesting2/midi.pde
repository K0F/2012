int pre[] = {
  0, 0, 0, 0, 0, 0, 0, 0, 
  0, 0, 0, 45, 0, 0, 0, 0, 
  64, 95, 70, 0, 0, 0, 0, 0, 
  0, 0, 127, 16, 100, 0, 65, 65,
};



void initMidi() {


  resetController();
}

void resetController() {

  for (int i = 0 ; i < pre.length;i++) {
    promidi.Controller tmp = new promidi.Controller(ctlMap[i], pre[i]);
    ctl[i] = pre[i];
    midiOut.sendController(tmp);
  }
}


void controllerIn(
promidi.Controller controller, 
int deviceNumber, 
int midiChannel
) {
  int num = controller.getNumber();
  int val = controller.getValue();


  int sel = 0;

seek:
  for (int i = 0 ; i < ctlMap.length;i++) {
    if (ctlMap[i]==num) {
      sel = i;
      break seek;
    }
  }
  println(sel+" "+val);

  ctl[sel] = val;
}

void programChange(
ProgramChange programChange, 
int deviceNumber, 
int midiChannel
) {
  int num = programChange.getNumber();
  println("program change"+num);
}

