
class Processor {
  FreqTable ft;
  Dictionary dictionary;
  int messageLength;
  char raw[];
  
  float space_feq = 50;
float learn_rate = 50.0;
  float dictWeight = 3.0f;

  char output[];
  float error, error2;

  Processor(int len) {
    messageLength = len;

    dictionary = new Dictionary();

    ft = new FreqTable();
    raw = new char[messageLength];
    output = generateRandom(messageLength);
    for (int i = 0 ; i < raw.length;i++)
      raw[i] = output[i];

    error = error2 = trial(raw);
  }

  void step() {


    error = trial(output);
    raw = mutate(output, learn_rate);
    error2 = trial(raw);

    if (error2 < error) {
      for (int i = 0 ; i < raw.length;i++)
        output[i] = raw[i];
      println(error2);
    }
  }

  char[] generateRandom(int len) {
    char tmp [] = new char[len];
    for (int i =0 ; i < len;i++) {
      int rnd = (int)random(97, 123);
      
      
      if(random(100)<space_feq)
      tmp[i] = ' ';
      else
      tmp[i] = (char)rnd;
    }
    return tmp;
  }

  float trial(char[] in) {
    float err = 0.0f;
    Letter l;

    // reset all
    for (int i =0 ; i < in.length;i++) {
      l = (Letter)ft.charMap.get((int)(in[i]==' '?25:in[i]-97));
      l.reset();
    }

    // count letter frequency
    for (int i =0 ; i < in.length;i++) {
      l = (Letter)ft.charMap.get((int)(in[i]==' '?25:in[i]-97));
      l.count++;
    }

    // count percentage
    for (int i =0 ; i < in.length;i++) {
      l = (Letter)ft.charMap.get((int)(in[i]==' '?25:in[i]-97));
      err += abs(l.count/(l.weight*(in.length+0.0f)));
    }

    err /= (in.length+0.0f);

    float search = dictionary.search(in)/dictWeight;
    if (search > 0) {
      err -=  search;
    }

    return err;
  }

  char[] mutate(char [] tmp, float rate) {
    char ttmp[] = new char[tmp.length];
    for (int i =0 ; i < tmp.length;i++) {
      Letter l = (Letter)ft.charMap.get((int)(tmp[i]==' '?25:tmp[i]-97));

      if (random(1000)<rate) {
        int rnd = (int)random(97, 123);
      
      
      if(random(100)<space_feq)
      ttmp[i] = ' ';
      else
      ttmp[i] = (char)rnd;
        
        
        
        
        
        
      }
      else {
        ttmp[i] = tmp[i];
      }
    }
    return ttmp;
  }

  void plot() {
    text(" ", 10, height/2);



    boolean words[] = new boolean[output.length];
      for (int i= 0; i < output.length;i++) {
    for (int q = 0 ; q < dictionary.actual.size();q++) {
      Word w = (Word)dictionary.actual.get(q);







        // text(" ");
        // if (w.where == i )
        // text(" ");


      //  if (w.where >= i && i < w.where+w.word.length()) {
       //   words[i] = true;
       // }

      

        if (i == w.where+w.word.length() || i == w.where) {
          words[i] = true;
            
        }



        //      if (random(1000)<5)
        //      txt[i]+=random(22, 126);
        //txt[i]+=(int)(2*noise((frameCount+i)/100.0));

        //if ((int)txt[i]>126) {
        // int more = (txt[i]-126);
        // raw[i] = (char)(22+more);
      }
    }

    for (int i= 0; i < output.length;i++) {

   //   if (words[i])
     // text("  ");
      /* fill(0xffff0000);
       else
       fill(255);
       */
      text(output[i]);
    }
    
    

    text(" ", 10, 20);
    for (int q = 0 ; q < dictionary.actual.size();q++) {
      Word w = (Word)dictionary.actual.get(q);
      text(w.word+" ");
    }
  }
}

