class PlayerImage {
  
   PImage img;
   ArrayList<Target> targets;
   
   PlayerImage(String filename) {
      img = loadImage(filename);
      targets = new ArrayList<Target>();
      
      img.loadPixels();
      for(int x = 0;x<img.width;x++){
        for(int y=0;y<img.height;y++){
          int loc1 = x+ y*img.width;
          float b = brightness(img.pixels[loc1]);
          
          if(b==255){
              Target v = new Target(new Vec3D(x-img.width/2,y-img.height/2,0), true);
              v.subSelf(new Vec3D(0,100,0));
              targets.add(v);
         }
      }
   }
   }
   
     void display() {
     // for(Target t : targets){
     //    t.display(); 
     // }
     
     for(int i=0;i<targets.size();i++){
        if(i%5==0){
           targets.get(i).display(); 
        }
     }
    }
  
    void oscillate() {
      // for(Target t : targets){
      //     t.oscillate();
      // }
      float x = theta;
      for(int i=0;i<targets.size();i++){
           targets.get(i).z = sin(x) * 20;
           x += 0.0002;
     }
      
    }
  
}
