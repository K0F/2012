/**
*  Code to convert JPEG bytes to awt.Image
*/


 
PImage GetFromJPEG(byte[] jpegBytes) {
  Image jpegImage = null;
 
  try{
    jpegImage = Toolkit.getDefaultToolkit().createImage(jpegBytes);
  }
  catch (Exception e){
    println("Something went super-terribly wrong chef: " + e.toString() + ": " + e.getMessage());
  }
   
  float waitTime = 0;
  
   /*
  while (jpegImage.getHeight (null) == -1){
    delay(1); //
    waitTime += 0.025;
  }
  */
  
  
  
  //delay(1);
  
  
   
  return new PImage(jpegImage);
}

