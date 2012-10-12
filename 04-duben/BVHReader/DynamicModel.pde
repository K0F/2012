class DynModel {
  ParticleSystem sys;
  ArrayList nodes;
  ArrayList particles;
  ArrayList springs;


  DynModel(ArrayList _nodes) {
    nodes = _nodes;
    sys = new ParticleSystem( 1000, 3 );
    makeParticles();
    makeConnections();
  } 


  void makeParticles() {

    particles = new ArrayList();

    for (int i = 0 ; i < nodes.size();i++) {
      Node n = (Node)nodes.get(i);
      particles.add( sys.makeParticle(100.5, n.pos.x, n.pos.y, n.pos.z)  );
    }
  }

  void makeConnections() {

    springs = new ArrayList();
    for (int i = 0 ; i < nodes.size();i++) {
      Particle p = (Particle)particles.get(i);
      Node n = (Node)nodes.get(i);
      Particle parent = (Particle)particles.get(n.parent.id);

      springs.add(sys.makeSpring(
      p, parent, 30.0, 0.0001, 
      dist(p.position().x(), p.position().y(), p.position().z(), 
      parent.position().x(), parent.position().y(), parent.position().z()) ));
    }
  }

  void tick() {
    
    for (int i = 0 ; i < nodes.size();i++) {
     Particle p = (Particle)particles.get(i);
     Node n = (Node)nodes.get(i);
     
     p.position().set(
     lerp(n.pos.x,p.position().x(),0.5),
     lerp(n.pos.y,p.position().y(),0.5),
     lerp(n.pos.z,p.position().z(),0.5));
     
     }

    sys.tick(0.4); 

    for (int i = 0 ; i < nodes.size();i++) {
      Particle p = (Particle)particles.get(i);
      Node n = (Node)nodes.get(i);



      border(p);
      n.pos.x = p.position().x();
      n.pos.y = p.position().y();
      n.pos.z = p.position().z();

    }



    // parser.setNodes(nodes);
  }

  void border(Particle p) {
    if (p.position().y()>500)
      p.velocity().set(0, 0, 0);
  }

  void draw() {


    for (int i = 0 ; i < nodes.size();i++) {
      Particle p = (Particle)particles.get(i);
      Node n = (Node)nodes.get(i);

      n.pos.x = p.position().x();
      n.pos.y = p.position().y();
      n.pos.z = p.position().z();

      pushMatrix();
      translate(n.pos.x, n.pos.y, n.pos.z);
      fill(0);
      box(2);
      popMatrix();
    }
  }
}

