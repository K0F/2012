int num = 260;
ArrayList bots;
PFont font;
int X, Y;

float graph[][];

int sx = 14;
int sy = 14;


void setup() {
  size(600, 440, P2D);

  graph = new float[width][num];

  X = sx;
  Y = sy;
  font = loadFont("53Maya-8.vlw");
  textFont(font);
  textMode(SCREEN);

  bots = new ArrayList();

  for (int i  = 0 ; i< num;i++)
    bots.add(new Bot(i));

  for (int ii  = 0 ; ii< num;ii++)
    for (int i  = 0 ; i< width;i++)
      graph[i][ii]=0;
}


void draw() {
  background(255);

  for (int i = 0; i< bots.size();i++) {
    Bot b = (Bot)bots.get(i);
    b.draw();

    for (int q =0 ; q < 8;q++) {
      stroke( color((b.getHex().charAt(q)=='1')?0:255) );
      point(b.id%7+width-100+q*8, b.id/7+height-50);

      stroke(0, 50);
      if ((b.getHex().charAt(q)=='1'))
        point(b.id%7+width-100-8, b.id/7+height-50);
    }
  }


stroke(0,10);
  for (int ii  = 1 ; ii< num;ii++) {
    for (int i  = 1 ; i< width;i++) {
      line(i, height-graph[i][ii],i-1, height-graph[i-1][ii]);
      graph[i-1][ii]=graph[i][ii];
    }

    graph[width-1][ii]+= (sum(ii)-graph[width-1][ii])/3.0;
    graph[width-1][ii]+= (graph[width-1][ii-1]-graph[width-1][ii])/1.02;
    
  }



  fill(0);
  text(binary(sum())+" "+sum(), width/2, height-20);
}

int sum() {
  float sum = 0;
  for (int i = 0; i< bots.size();i++) {
    Bot b = (Bot)bots.get(i);
    sum += b.code / (0.0+bots.size());
  }

  //  sum /= (0.0+bots.size());

  return (int)(sum);
}

int sum(int ktera) {

  Bot b = (Bot)bots.get(ktera);


  return b.code;
}


class Bot {
  int code;
  int sc = 5;
  int x, y;
  int id;

  Bot(int _id) {
    id = _id;
    code = 1;//(int)random(0, 255);
    x = X;
    y = Y;

    X += 44;

    if (X>width-50) {
      Y += sy;
      X = sx;
    }
    else {
      y = Y;
    }
  }

  void draw() {
    stroke(0);
    String h = getHex();

    fill(0);
    text(h+" "+code, x, y);

    for (int i = 7 ;i>=0;i--) {
      switch(h.charAt(i)) {
      case '0':
        fill(255); 
        break;
      case '1':
        fill(0);
        break;
      }
      rect(i*sc+x, y+1, sc, sc);
    }

    if (frameCount%(id+1)==0)
      add();
  }


  void add() {

    if (id==0) {
      code+=1;
      code = code%255;
    }
    else {

      Bot pre = (Bot)bots.get((id+1)%bots.size());
      Bot first = (Bot)bots.get(0);
      Bot second = (Bot)bots.get(first.code);

      code = second.code ^ first.code;//(int)(((sin(frameCount/10.0+id/10.0)+1.01)/2.0)*10);//(int)(dist(mouseX, mouseY, x, y)/30.0);//(int)((pre.code-code)/2.0);
      //code += pre.code;
      code = code%255;
    }
  }


  String getHex() {
    int offset = 8-binary(code).length();
    String nulls = "";

    for (int i = 0 ; i < offset;i++) {
      nulls+="0";
    }

    return nulls+binary(code);
  }

  int getNumber() {
    return code;
  }
}

