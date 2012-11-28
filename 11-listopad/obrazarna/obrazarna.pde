/**
* obrazarna by kof
*/

ArrayList images;



String path = "/home/kof/obrazarna/images";
ArrayList <String> files;


void setup(){
size(1024,768,P2D); 
 files = getNew(); 
 loadImages();
 
 imageMode(CENTER);
 
}


void draw(){
  
  background(0);
  
  PImage tmp = (PImage)images.get(frameCount%images.size());
  image(tmp,width/2,height/2);
  
  
}

void loadImages(){
 
images = new ArrayList();
  for(int i = 0 ; i < files.size();i++){
    String tmp = (String)files.get(i);
     images.add(loadImage(tmp));
  }  
}

ArrayList getNew(){
File dir = new File(path);
        File [] files  = dir.listFiles();
        Arrays.sort(files, new Comparator(){
            public int compare(Object o1, Object o2) {
                return compare( (File)o1, (File)o2);
            }
            private int compare( File f1, File f2){
                long result = f2.lastModified() - f1.lastModified();
                if( result > 0 ){
                    return 1;
                } else if( result < 0 ){
                    return -1;
                } else {
                    return 0;
                }
            }
        });
        //System.out.println( Arrays.asList(files ));
        
        ArrayList tmp = new ArrayList();
        
        for(int i = 0;i<files.length;i++){
         
         if(files[i].getName().indexOf(".jpg")>-1 || 
         files[i].getName().indexOf(".png")>-1 ||
         files[i].getName().indexOf(".gif")>-1)
          tmp.add(files[i].getAbsolutePath());
        }
          
        return tmp;
    }
    
   
