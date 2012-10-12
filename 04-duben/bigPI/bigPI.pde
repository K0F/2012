String pi[];
int cnt = 0;
PImage img;

void setup(){
  size(350,900,P2D);

  println(PI);
  textFont(createFont("Semplice Regular",8,false));
  textMode(SCREEN);
  
  pi = loadStrings("pi.txt");
  img = loadImage("pi.png");
  img.mask(img);
  img.filter(INVERT);
  img.filter(BLUR,4);
}



void draw(){

  background(0);


  beginShape();
  vertex(width/2,0);
  for(int i =0 ; i < height/10 ;i++){

    int sum = 0;
    for(int p = 0 ; p< pi[i+cnt].length() ; p++){
      if(pi[i+cnt].charAt(p)!=' '){
        int val = (int)pi[i+cnt].charAt(p)-48;
        fill(lerpColor(#ff0000,#00ff00,val/10.0));
        sum+=val;
        text(pi[i+cnt].charAt(p),p*6,i*10);
      }
    }
    noFill();
    stroke(255);
    vertex(sum,i*10);
  }
  vertex(width/2,height);
  endShape();

  cnt++;
}
