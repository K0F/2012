int num = 500;
ArrayList solvers;
ArrayList console;


float approx = 30.8;
float speed = 10.5;
int border = 150;
float [][] graph;

void setup() {
  size(1280, 720, P2D);

  textFont(loadFont("53Seed-8.vlw"));
  textMode(SCREEN);

  graph = new float[num][width];


  console = new ArrayList();
  solvers = new ArrayList();
  for (int i = 0 ; i < num ;i ++)
    solvers.add(new Solver(i, new PVector(random(border, width-border), random(border, height-border))));
}

float high, low;
float slow, shigh;

void draw() {
  background(0);

  // translate(width/2,height/2);



  high = -10000000;
  low = 10000000;

  for (int i = 0 ; i < solvers.size();i++)
  {
    Solver tmp = (Solver)solvers.get(i);
    if (tmp.result>high)
      high = tmp.result;

    if (tmp.result<low)
      low = tmp.result;
  }


  slow+=(low-slow)/30.0;
  shigh+=(high-shigh)/30.0;

  for (int n =0  ; n < num;n+=2) {


    Solver last = (Solver)solvers.get(n);
    graph[n][width-1] = last.result;


    stroke(255, 15);
    for (int i = width-2  ; i > 0;i--) {
      graph[n][i] += (graph[n][i+1]-graph[n][i])/3.0;
      float val = map(graph[n][i], low, shigh, border, height-border);
      float val2 = map(graph[n][i+1], low, shigh, border, height-border);

      if (abs(graph[n][i])>0.0001)
        line(i, val, i+1, val2);
    }
  }
  for (int i = 0 ; i < solvers.size();i++)
  {
    Solver tmp = (Solver)solvers.get(i);
    tmp.draw();
  }

  fill(255,120);

  for(int i =0 ;i < console.size();i++){
    String line = (String)console.get(i);
    text(line,20,i*8+20);
  }

  if(console.size()>height/7){
    console.remove(0);
  }


}

////////////////////////////////////////
////    SOLVER       ///////////////////
////////////////////////////////////////

class Solver {
  PVector pos;
  int state = 0;
  float base = 1;

  int id;

  int closest;

  float result;

  Solver(int _id, PVector _pos) {
    id = _id;
    pos = new PVector(_pos.x, _pos.y);
    base = (int)random(1,3);
    state = (int)random(4);
  }

  void move() {
    Solver neig = (Solver)solvers.get(closest);
    pos.sub(new PVector((neig.pos.x-pos.x)/speed, (neig.pos.y-pos.y)/speed));

    border();
  }

  void border() {

    if (pos.x>width-border)pos.x = width-border;
    if (pos.x<border)pos.x=border;

    if (pos.y>height-border)pos.y = height-border;
    if (pos.y<border)pos.y=border;
  }


  void draw() {

    move();

    closest = getClosest();
    Solver neig = (Solver)solvers.get(closest);

    if (id==0) {
      result = 1.0;
      fill(#ff0000);
      stroke(#ff0000);
    }
    else if (id == solvers.size()-1) {

      fill(#00ff00);
      stroke(#00ff00); 

      result += (compute(neig.result)-result)/approx;
    }
    else {

      float b = map(result, low, high, 0, 1);

      fill(lerpColor(#ffcc00,#ff0000,b),60);
      stroke(lerpColor(#ffcc00,#ff0000,b),90);

      result += (compute(neig.result)-result)/approx;
    }
    
    if (id == solvers.size()-1){
     Solver fst = (Solver)solvers.get(1);
      console.add(fst.result+" --> "+result);

    }

    line(pos.x, pos.y, neig.pos.x, neig.pos.y);


    switch(state) {
      case 0:
        text("+ " + base+"\n("+result+")", pos.x, pos.y);
        break;
      case 1:
        text("- " + base+"\n("+result+")", pos.x, pos.y);
        break;
      case 2:
        text("* " + base+"\n("+result+")", pos.x, pos.y);
        break;
      case 3:
        text("/ " + base+"\n("+result+")", pos.x, pos.y);
        break;
    }
  }

  int getClosest() {
    int _id = this.id;
    float d = width*height;
    float dmem = width*height;

    for (int i = 0 ; i < solvers.size();i++) {
      Solver tmp = (Solver)solvers.get(i);
      Solver cl = (Solver)solvers.get(tmp.closest);

      if (tmp!=this && cl!=this) {
        d = dist(pos.x, pos.y, tmp.pos.x, tmp.pos.y);
        if (d<dmem) {
          dmem = d;
          _id = tmp.id;
        }
      }
    }

    return _id;
  }

  float compute(float inlet) {
    float result;
    switch(state) {
      case 0:
        result = inlet + base;
        break;
      case 1:
        result = inlet - base;
        break;
      case 2:
        result = inlet * base;
        break;
      case 3:
        result = inlet % (int)base;
        break;
      default:
        result = base;
    }
    return result;
  }
}

