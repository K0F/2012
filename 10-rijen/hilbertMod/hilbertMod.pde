// Hilbert Curve Toy
// Combining the Hilbert space filling curve with modular arithmetic and binary arithmetic
// by Steven Kay, Oct 2011
// Acknowledgement: based algorithm for curve on http://www.compuphase.com/hilbert.htm
 
int x,y=0;
int MODULO=6; // modular base
int ALTERNATE=9; // alternate parameter. Only used for some formulae.
int FORMULA=1; // different formulae
int kadence = 3;
 int S = 9;
 float fadeout = 100;
 
ArrayList<int[]> positions;
 
void setup() {
  size(1024,768,P2D);
 // caption=loadFont("FromWhereYouAre-48.vlw");
//  textFont(caption,25.0f);
  
  positions=new ArrayList<int[]>();
  background(0);
  x=0;
  y=0;
  hilbert_level(7,2);
}
 

void reset(){
      MODULO=(int)random(1,100);
    ALTERNATE=(int)random(1,100);
    FORMULA=(int)random(0,5);
}
 
void draw() {
  noStroke();
  fill(0,fadeout);
  rect(0,0,width,height);
  
  
 if(frameCount%kadence==0)
   reset();
  
  //image(im,512,0);
  //text(""+MODULO,512+120,130);
  //text(""+ALTERNATE,512+120,200);
  String formula="";
  fill(255);
   
  float count=(float)(positions.size());
  for (int i=0;i<positions.size();i++) {
    boolean visible = false;
    //if (i%MODULO==0) fill(255);
    int base = (i^ALTERNATE)%MODULO;
    base*=MODULO;
    switch (FORMULA) {
      case(0):
        // default MODULO
        if (i%MODULO==0) visible = true;
        formula="MOD";
        break;
      case(1):
        // AND
        if ((i&ALTERNATE)%MODULO==0) visible = true;
        formula="AND";
        break;
      case(2):
        // XOR
        if ((i^ALTERNATE)%MODULO==0) visible = true;
        formula="XOR";
        break;
      case(3):
        // OR
        if ((i|ALTERNATE)%MODULO==0) visible = true;
        formula="OR";
        break;
      case(4):
        // OR2
        if ((i/ALTERNATE)%MODULO==0) visible = true;
        formula="DMOD";
        break;
      default:
        break;
    }
    int[] posns = positions.get(i);
    
    if(visible && posns[1] < height)
    rect(posns[0],posns[1],S,S);
  }
  fill(0);
  //text(formula,512+120,270);
  
  //blend(g,0,0,width,height,0,0,width,height,MULTIPLY);
}
 
 
void move(int dir) {
  switch (dir) {
    case 0:
      y=y-S;
      break;
    case 1:
      y=y+S;
      break;
    case 2:
      x=x-S;
      break;
    case 3:
      x=x+S;
    default:
      break;
  }
  positions.add(new int[]{x,y});
}
 
void hilbert_level(int level,int direction)
{
  if (level==1) {
    switch (direction) {
    case 2:
      move(3);      /* move() could draw a line in... */
      move(1);       /* ...the indicated direction */
      move(2);
      break;
    case 3:
      move(2);
      move(0);
      move(3);
      break;
    case 0:
      move(1);
      move(3);
      move(0);
      break;
    case 1:
      move(0);
      move(2);
      move(1);
      break;
    } /* switch */
  } else {
    switch (direction) {
    case 2:
      hilbert_level(level-1,0);
      move(3);
      hilbert_level(level-1,2);
      move(1);
      hilbert_level(level-1,2);
      move(2);
      hilbert_level(level-1,1);
      break;
    case 3:
      hilbert_level(level-1,1);
      move(2);
      hilbert_level(level-1,3);
      move(0);
      hilbert_level(level-1,3);
      move(3);
      hilbert_level(level-1,0);
      break;
    case 0:
      hilbert_level(level-1,2);
      move(1);
      hilbert_level(level-1,0);
      move(3);
      hilbert_level(level-1,0);
      move(0);
      hilbert_level(level-1,3);
      break;
    case 1:
      hilbert_level(level-1,3);
      move(0);
      hilbert_level(level-1,1);
      move(2);
      hilbert_level(level-1,1);
      move(1);
      hilbert_level(level-1,2);
      break;
    } /* switch */
  } /* if */
}

