//------ VECTOR ------//
class Vector{
  int n;
  float vx,vy,vz,m;
  Vector(float $vx,float $vy,float $vz){
    n = global.nvectors;
    global.vectors[global.nvectors++] = this;
    vx = $vx;
    vy = $vy;
    vz = $vz;
    m = get_magnitude();
  }
  Vector(Point $p){
    n = global.nvectors;
    global.vectors[global.nvectors++] = this;
    vx = $p.x;
    vy = $p.y;
    vz = $p.z;
    m = get_magnitude();
  }
  float get_magnitude(){
    return mag(vx,vy,vz);
  }
  void unitize(){
    m = get_magnitude();
    if(m==0){ return; }
    vx = vx/m; vy = vy/m; vz = vz/m;
  }
  void add(Vector $v){
    vx += $v.vx; vy += $v.vy; vz += $v.vz;
  }
  void subtract(Vector $v){
    vx -= $v.vx; vy -= $v.vy; vz -= $v.vz;
  }
  void scale(float $s){
    vx *= $s; vy *= $s; vz *= $s;
  }
  void echo(int $indent){
    String indent = "";
    while(indent.length()<$indent){
      indent += "  ";
    }
    println(indent+"---- VECTOR #"+n+" ----");
    println(indent+"vx: "+vx);
    println(indent+"vy: "+vy);
    println(indent+"vz: "+vz);
  }
  void render(Point $p){
    beginShape();
    vertex($p.x,$p.y,$p.z);
    vertex($p.x+vx,$p.y+vy,$p.z+vz);
    endShape();
  }
}

float dot_product(Vector $v1,Vector $v2){
  return ($v1.vx*$v2.vx)+($v1.vy*$v2.vy)+($v1.vz*$v2.vz);
}
float dot_product_1p(Vector $v1,Point $p2){
  return ($v1.vx*$p2.x)+($v1.vy*$p2.y)+($v1.vz*$p2.z);
}
float dot_product_2p(Point $p1,Point $p2){
  return ($p1.x*$p2.x)+($p1.y*$p2.y)+($p1.z*$p2.z);
}

Vector cross_product(Vector $v1,Vector $v2){
  return new Vector($v1.vy*$v2.vz-$v1.vz*$v2.vy,$v1.vz*$v2.vx-$v1.vx*$v2.vz,$v1.vx*$v2.vy-$v1.vy*$v2.vx);
}
