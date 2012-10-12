String base[];// = "gekon";
String keys[];

int variations = 100;
int rnum = 3;

void setup(){

  base = loadStrings("base.txt");

  keys = new String[base.length*variations];
  
 int cnt = 0;
  for(int i = 0 ; i < base.length;i++){


    for(int q = 0 ;q<rnum;q++){

    String rand = "";
      
      for(int ii = 0;ii<rnum;ii++)
      rand += (int)random(0,9);
   
    keys[i*q] = base[i]+""+rand;
    
    }

    

  }

  saveStrings("dict1.txt",keys);

  exit();
}


