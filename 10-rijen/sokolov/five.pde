void fiveGUI(){
  
  int y = ctlskip*2;

  cp5.addSlider("shake")
    .setRange(0, 255)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(five)
            ;
  y+=ctlskip;
  
  
  
  cp5.addSlider("glob_speed")
    .setRange(1, 255)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(five)
            ;
  y+=ctlskip;
  
  
  cp5.addSlider("avoidance_radius")
    .setRange(0, 255)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(five)
            ;
  y+=ctlskip;

  cp5.addSlider("learning_rate")
    .setRange(0, 255)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(five)
            ;
  y+=ctlskip;
  
  
  cp5.addSlider("attract_force")
    .setRange(100, 100000)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(five)
            ;
  y+=ctlskip;
  
  
  
  cp5.addSlider("follow_speed")
    .setRange(3, 255)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(five)
            ;
  y+=ctlskip;

  
}

////////////////////////////////
ArrayList nodes;

float shake = 10.0;


// number of entities //
int num = 75;

// number of nurons per entity //
int neurons_per_node = 20;

// number of random connections between *neurons* //
int neuron_conectivity = 50;

// length of tail to draw //
int tail_length = 200;

// affecting radius between entities //
float avoidance_radius = 100.;
// the rate neuronal system reacts.. lower = quicker//
float learning_rate = 50.;
// the ratio between learning positive / negative experience //
float ratio = 8.;

// the other entitie copies movement of other neighbors //
boolean nodes_are_assimilating  = false;

// global movability of entities //
float glob_speed = 3.0;

// global radius //
float R = 40.0;


boolean rec = false;

boolean attract = true;
float attract_force =5000.0;

PVector follow;
float follow_speed = 70.0;



PImage vineta;// = loadImage("vineta.png");
PImage grid;// = loadImage("grid.png");
boolean display_lines = true;

void setupFive() {
  noiseSeed(19);

  vineta = loadImage("vineta.png");
  grid = loadImage("grid.png");

  // fram = mkFram(30,30);



  follow = new PVector(width/2, height/2);

  nodes = new ArrayList();
  for (int i = 0 ; i < num;i++)
    nodes.add(new Node(i, neurons_per_node, neuron_conectivity));
}

void five() {
  smooth();
  background(0);

  pushMatrix();


  translate(width/2., height/2.);
  translate((noise(millis()/100.0, 0)-0.5)*shake, (noise(0, millis()/100.0)-0.5)*shake);

  for (int i = 0 ; i < num;i++) {

    Node n = (Node)nodes.get(i);

    follow.x += (n.pos.x - follow.x) / follow_speed;
    follow.y += (n.pos.y - follow.y) / follow_speed;
    pushMatrix();
    scale(noise((frameCount+i/10.0)/300.0));   


    translate(-follow.x, -follow.y);


    n.move();
    n.display();


    popMatrix();
  }
  popMatrix();



  //fastblur(g,(int)(noise(frameCount/300.0)*4.0+1));
  //tint(255,20);
  //image(g,0,0);


  pushMatrix();
  translate((noise(millis()/33.0, 0)-0.5)*shake/2.0, (noise(0, millis()/33.0)-0.5)*shake/2.0);
  image(grid, 0, 0);
  popMatrix();
}
class Node {
  ArrayList neurons;
  ArrayList connections;

  PVector pos;

  ArrayList tail;


  int id;
  int num;
  int connectivity;


  ///////////////////////////////////////
  Node(int _id, int _num, int _connectivity) {
    id = _id;
    num = _num;
    connectivity = _connectivity;


    tail = new ArrayList();


    pos = new PVector(random(width), random(height));

    neurons = new ArrayList();
    for (int i =0 ; i < num;i++)
      neurons.add(new Neuron(this, i));

    connections = new ArrayList();
    for (int i =0 ; i < connectivity;i++) {
      Neuron n1, n2;
      n1 = (Neuron)neurons.get((int)random(neurons.size()));
      n2 = (Neuron)neurons.get((int)random(neurons.size()));

      while (n1==n2) {
        n1 = (Neuron)neurons.get((int)random(neurons.size()));
        n2 = (Neuron)neurons.get((int)random(neurons.size()));
      }

      connections.add(new Connection(n1, n2));
    }
  }

  ///////////////////////////////////////
  void move() {

    if (attract)
      for (int i =0  ; i < nodes.size();i++) {
        Node n  = (Node)nodes.get(i);
        if (n!=this) {
          pos.x += (n.pos.x-pos.x)/attract_force;
          pos.y += (n.pos.y-pos.y)/attract_force;
        }
      }

    for (int i =0  ; i < neurons.size();i++) {
      Neuron n  = (Neuron)neurons.get(i);

      PVector tmp = new PVector(n.pos.x, n.pos.y);

      tmp.normalize();


      tmp.mult(n.val*glob_speed);
      pos.add(tmp);
    }

    // border2();
  }

  ///////////////////////////////////////
  void border() {

    pos.x = constrain(pos.x, 0, width);
    pos.y = constrain(pos.y, 0, height);
  }
  void border2() {

    if (pos.x>width)pos.x = 0;
    if (pos.x<0)pos.x = width;


    if (pos.y>height)pos.y = 0;
    if (pos.y<0)pos.y = height;
  }



  //////////////////////////////////////
  void display() {

    pushMatrix();

    translate(pos.x, pos.y);

    for (int i = 0 ; i < connections.size();i++) {
      Connection c = (Connection)connections.get(i);
      c.display();
    }

    for (int i = 0 ; i < neurons.size();i++) {
      Neuron n = (Neuron)neurons.get(i);
      n.display();
    }


    avoid();

    popMatrix();

    if (tail.size()>1)
      for (int i = 1 ; i < tail.size();i++)
      {

        PVector segment1 = (PVector)tail.get(i-1);
        PVector segment2 = (PVector)tail.get(i);
        stroke(255, map(i, 0, tail.size(), 0, 127));
        float dd = dist(segment1.x, segment1.y, segment2.x, segment2.y);
        if (dd<width/2) {
          //strokeWeight(dd);
          line(segment1.x, segment1.y, segment2.x, segment2.y);
        }
        strokeWeight(1);
      }

    addTail();
  }
  ///////////////////////////////////////

  ///////////////////////////////////////
  void addTail() {
    if (tail.size()<tail_length)
      tail.add(new PVector(pos.x, pos.y));
    else
      tail.remove(0);
  }


  ///////////////////////////////////////
  void avoid() {
    for (int i = 0 ; i< nodes.size();i++) {
      Node other = (Node)nodes.get(i);
      if (this!=other) {
        float d = dist(pos.x, pos.y, other.pos.x, other.pos.y);
        if (d < avoidance_radius) {
          // weaken connection
          for (int q = 0;q<connections.size();q++) {

            Connection con = (Connection)connections.get(q);
            stroke(255, map(d, 0, avoidance_radius, 127, 0));
            line(con.one.pos.x, con.one.pos.y, con.two.pos.x, con.two.pos.y);
            con.w += (d/avoidance_radius*con.one.val*con.two.val-con.w)/learning_rate;
          }

          if (nodes_are_assimilating)
            for (int q = 0 ; q < neurons.size() ; q ++) {
              Neuron n = (Neuron)neurons.get(q);
              Neuron other_n = (Neuron)other.neurons.get(q);

              if (n!=other_n) {
                n.pos.x += (other_n.pos.x-n.pos.x) / learning_rate;
                n.pos.y += (other_n.pos.y-n.pos.y) / learning_rate;
              }
            }
        }
        else {
          // strangten connections
          for (int q = 0;q<connections.size();q++) {

            Connection con = (Connection)connections.get(q);
            con.w += (1.0-con.w)/(learning_rate*ratio);
          }
        }
      }
    }
  }
}

///////////////////////////////////////
class Neuron {
  Node parent;
  int id;
  PVector pos;
  float val;


  ///////////////////////////////////////
  Neuron(Node _parent, int _id) {
    parent = parent;
    id = _id;
    val = random(0, 100) / 100.0;
    pos = new PVector(random(-10, 10), random(-10, 10));
  }

  ///////////////////////////////////////
  void display() {
    stroke(255, val*255);
    point(pos.x, pos.y);
  }
}

///////////////////////////////////////
class Connection {
  float w;
  Neuron one, two;
  float pulse = 0;

  float diff;
  ///////////////////////////////////////
  Connection(Neuron _one, Neuron _two) {
    one = _one;
    two = _two;
    w = random(0, 100) / 100.0;
    diff = random(-100, 100);
  }

  ///////////////////////////////////////
  void display() {

    if (display_lines) {
      stroke(255, w*25);
      line(one.pos.x, one.pos.y, two.pos.x, two.pos.y);
    }

    update();
  }

  ///////////////////////////////////////
  void update() {
    pulse = noise((diff+frameCount)/(one.id+two.id+40.0))*1.5;


    one.pos.x = cos(pulse*3.)*R*w;
    one.pos.y = sin(pulse*3.)*R*w;


    two.pos.x = sin(pulse*3.)*R*w;
    two.pos.y = cos(pulse*3.)*R*w;


    one.val += (two.val*w-one.val)/((pulse+2.0)*3.0);
  }
}

void fastblur(PGraphics img, int radius) {

  if (radius<1) {
    return;
  }
  int w=img.width;
  int h=img.height;
  int wm=w-1;
  int hm=h-1;
  int wh=w*h;
  int div=radius+radius+1;
  int r[]=new int[wh];
  int g[]=new int[wh];
  int b[]=new int[wh];
  int rsum, gsum, bsum, x, y, i, p, p1, p2, yp, yi, yw;
  int vmin[] = new int[max(w, h)];
  int vmax[] = new int[max(w, h)];
  int[] pix=img.pixels;
  int dv[]=new int[256*div];
  for (i=0;i<256*div;i++) {
    dv[i]=(i/div);
  }

  yw=yi=0;

  for (y=0;y<h;y++) {
    rsum=gsum=bsum=0;
    for (i=-radius;i<=radius;i++) {
      p=pix[yi+min(wm, max(i, 0))];
      rsum+=(p & 0xff0000)>>16;
      gsum+=(p & 0x00ff00)>>8;
      bsum+= p & 0x0000ff;
    }
    for (x=0;x<w;x++) {

      r[yi]=dv[rsum];
      g[yi]=dv[gsum];
      b[yi]=dv[bsum];

      if (y==0) {
        vmin[x]=min(x+radius+1, wm);
        vmax[x]=max(x-radius, 0);
      }
      p1=pix[yw+vmin[x]];
      p2=pix[yw+vmax[x]];

      rsum+=((p1 & 0xff0000)-(p2 & 0xff0000))>>16;
      gsum+=((p1 & 0x00ff00)-(p2 & 0x00ff00))>>8;
      bsum+= (p1 & 0x0000ff)-(p2 & 0x0000ff);
      yi++;
    }
    yw+=w;
  }

  for (x=0;x<w;x++) {
    rsum=gsum=bsum=0;
    yp=-radius*w;
    for (i=-radius;i<=radius;i++) {
      yi=max(0, yp)+x;
      rsum+=r[yi];
      gsum+=g[yi];
      bsum+=b[yi];
      yp+=w;
    }
    yi=x;
    for (y=0;y<h;y++) {
      pix[yi]=0xff000000 | (dv[rsum]<<16) | (dv[gsum]<<8) | dv[bsum];
      if (x==0) {
        vmin[y]=min(y+radius+1, hm)*w;
        vmax[y]=max(y-radius, 0)*w;
      }
      p1=x+vmin[y];
      p2=x+vmax[y];

      rsum+=r[p1]-r[p2];
      gsum+=g[p1]-g[p2];
      bsum+=b[p1]-b[p2];

      yi+=w;
    }
  }
}


