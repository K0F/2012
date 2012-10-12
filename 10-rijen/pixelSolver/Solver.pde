class Solver {
  ArrayList layers;
  int[] setup;
  int cycle;

  PVector pos;
  int res  = 10;
  int S = 3;

  float MN, MX, mmn, mmx;

  float error = 1;

  Solver(int [] _setup) {
    setup = new int[_setup.length];
    for (int i = 0; i < setup.length;i++) {
      setup[i] = _setup[i];
    }

    pos = new PVector(10, 10+height/2);

    cycle = 0;

    layers = new ArrayList();

    for (int i = 0 ; i< setup.length;i++)
      layers.add(new Layer(setup[i], i, this));
  }


  // display network diagram



  void plot() {

    //for(int z = 0; z < 5;z++)
    learn();
    rectMode(CENTER);

    mmn = 1000000000;
    mmx = -1000000000;

    for (int l = 1 ; l <layers.size();l++) {
      Layer current = (Layer)layers.get(l);
      for (int n = 0;n<current.neurons.size();n++) {
        Neuron currentN = (Neuron)current.neurons.get(n);
        if (mmn>currentN.val)mmn = currentN.val;
        if (mmx<currentN.val)mmx = currentN.val;
      }
    }

    for (int l = 0 ; l <layers.size();l++) {
      Layer current = (Layer)layers.get(l);

      for (int n = 0;n<current.neurons.size();n++) {
        Neuron currentN = (Neuron)current.neurons.get(n);
        for (int n2 = 0;n2<currentN.ins.size();n2++) {
          float W = (Float)currentN.weights.get(n2);
          stroke(255, W*127+20);
          line(n*res+pos.x, l*res+pos.y, n2*res+pos.x, (l-1)*res+pos.y);
        }  
        noStroke();
        fill(255, map(currentN.val, mmn/2., mmx*2., 0, 255));
        rect(n*res+pos.x, l*res+pos.y, S, S);
      }
    }
    rectMode(CORNER);
  }


  void learn() {

    Layer base = (Layer)layers.get(0);
    Neuron X = (Neuron)base.neurons.get(0);
    Neuron Y = (Neuron)base.neurons.get(1);
    Neuron CYC = (Neuron)base.neurons.get(2);
    Neuron CYC2 = (Neuron)base.neurons.get(3);


    MN = 100000000.0;
    MX = -10000000.0;

    int startx, endx, starty, endy, increment;

    switch(frameCount%4) {

    case 0:

      for (int y = 0 ; y< dim;y++) {
        for (int x = 0 ; x< dim;x++) {


          X.val = norm(x, 0, dim);
          Y.val = norm(y, 0, dim);



          CYC.val = 1;
          CYC2.val = 0;//target[x][y]?1:0;

          for (int i = 1 ; i < layers.size();i++) {
            Layer l = (Layer)layers.get(i);
            for (int n = 0 ; n < l.neurons.size();n++) {
              Neuron neu = (Neuron)l.neurons.get(n);
              neu.precount();
            }
          }


          for (int i =  1; i < layers.size();i++) {
            Layer l = (Layer)layers.get(i);
            for (int n = 0 ; n < l.neurons.size();n++) {
              Neuron neu = (Neuron)l.neurons.get(n);
              neu.step();
            }
          }

          Layer last = (Layer)layers.get(layers.size()-1);
          Neuron out = (Neuron)last.neurons.get(0);



          /////////////// back prop


          float pole = grid[x][y]?1.0:0.0;

          float err = pole-out.val;

          for (int i =  1; i < layers.size();i++) {
            Layer l = (Layer)layers.get(i);
            for (int n = 0 ; n < l.neurons.size();n++) {
              Neuron neu = (Neuron)l.neurons.get(n);
              neu.backProp(err);
            }
          }


          if (MN>out.val)MN=out.val;
          if (MX<out.val)MX=out.val;

          vals[x][y] += (out.val-vals[x][y])/SM;
        }//end x
      }//end y

      break;
    case 1:

      for (int x = 0 ; x< dim;x++) {
        for (int y = 0 ; y< dim;y++) {


          X.val = norm(x, 0, dim);
          Y.val = norm(y, 0, dim);



          CYC.val = 1;
          CYC2.val = 0;//target[x][y]?1:0;

          for (int i = 1 ; i < layers.size();i++) {
            Layer l = (Layer)layers.get(i);
            for (int n = 0 ; n < l.neurons.size();n++) {
              Neuron neu = (Neuron)l.neurons.get(n);
              neu.precount();
            }
          }


          for (int i =  1; i < layers.size();i++) {
            Layer l = (Layer)layers.get(i);
            for (int n = 0 ; n < l.neurons.size();n++) {
              Neuron neu = (Neuron)l.neurons.get(n);
              neu.step();
            }
          }

          Layer last = (Layer)layers.get(layers.size()-1);
          Neuron out = (Neuron)last.neurons.get(0);


          /////////////// back prop


          float pole = grid[x][y]?1.0:0.0;

          float err = pole-out.val;

          for (int i =  1; i < layers.size();i++) {
            Layer l = (Layer)layers.get(i);
            for (int n = 0 ; n < l.neurons.size();n++) {
              Neuron neu = (Neuron)l.neurons.get(n);
              neu.backProp(err);
            }
          }


          if (MN>out.val)MN=out.val;
          if (MX<out.val)MX=out.val;

          vals[x][y] += (out.val-vals[x][y])/SM;
        }//end x
      }//end y

      break;

    case 2:

      for (int x = dim-1 ; x>= 0;x--) {
        for (int y = dim-1 ; y>= 0;y--) {


          X.val = norm(x, 0, dim/10);
          Y.val = norm(y, 0, dim/10);



          CYC.val = 1;
          CYC2.val = 0;//target[x][y]?1:0;

          for (int i = 1 ; i < layers.size();i++) {
            Layer l = (Layer)layers.get(i);
            for (int n = 0 ; n < l.neurons.size();n++) {
              Neuron neu = (Neuron)l.neurons.get(n);
              neu.precount();
            }
          }


          for (int i =  1; i < layers.size();i++) {
            Layer l = (Layer)layers.get(i);
            for (int n = 0 ; n < l.neurons.size();n++) {
              Neuron neu = (Neuron)l.neurons.get(n);
              neu.step();
            }
          }

          Layer last = (Layer)layers.get(layers.size()-1);
          Neuron out = (Neuron)last.neurons.get(0);


          /////////////// back prop


          float pole = grid[x][y]?1.0:0.0;

          float err = pole-out.val;

          for (int i =  1; i < layers.size();i++) {
            Layer l = (Layer)layers.get(i);
            for (int n = 0 ; n < l.neurons.size();n++) {
              Neuron neu = (Neuron)l.neurons.get(n);
              neu.backProp(err);
            }
          }


          if (MN>out.val)MN=out.val;
          if (MX<out.val)MX=out.val;

          vals[x][y] += (out.val-vals[x][y])/SM;
        }//end x
      }//end y

      break;

    case 3:
      for (int y = dim-1 ; y>= 0;y--) {

        for (int x = dim-1 ; x>= 0;x--) {


          X.val = norm(x, 0, dim);
          Y.val = norm(y, 0, dim);



          CYC.val = 1;
          CYC2.val = 0;//target[x][y]?1:0;

          for (int i = 1 ; i < layers.size();i++) {
            Layer l = (Layer)layers.get(i);
            for (int n = 0 ; n < l.neurons.size();n++) {
              Neuron neu = (Neuron)l.neurons.get(n);
              neu.precount();
            }
          }


          for (int i =  1; i < layers.size();i++) {
            Layer l = (Layer)layers.get(i);
            for (int n = 0 ; n < l.neurons.size();n++) {
              Neuron neu = (Neuron)l.neurons.get(n);
              neu.step();
            }
          }

          Layer last = (Layer)layers.get(layers.size()-1);
          Neuron out = (Neuron)last.neurons.get(0);


          /////////////// back prop


          float pole = grid[x][y]?1.0:0.0;

          float err = pole-out.val;

          for (int i =  1; i < layers.size();i++) {
            Layer l = (Layer)layers.get(i);
            for (int n = 0 ; n < l.neurons.size();n++) {
              Neuron neu = (Neuron)l.neurons.get(n);
              neu.backProp(err);
            }
          }


          if (MN>out.val)MN=out.val;
          if (MX<out.val)MX=out.val;

          vals[x][y] += (out.val-vals[x][y])/SM;
        }//end x
      }//end y

      break;
    }

    noStroke();


    for (int y = 0;y<dim;y++) {
      for (int x = 0;x<dim;x++) {
        fill(255, map(vals[x][y], MN, MX, 0, 255));

        float xx = x*siz+width/2;
        float yy = y*siz;

        rect(xx, yy, siz, siz);
      }
    }
  }
}

