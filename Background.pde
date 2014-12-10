class Background {
  
  ArrayList<Target> targets;
  float[] heights = {-height, height};
  
  Background(int numParticles){
    
    targets = new ArrayList<Target>();
    
    for(int i=0;i<numParticles;i++){
       Vec3D v = Vec3D.randomVector();
       if(i<1000){
         v.scaleSelf(width+10);
       } else {
          //int index = int(random(heights.length));
          v.x = random(-width,width);
          v.y = -height-5; //heights[index];
          v.z = random(height);
       }
       Target t = new Target(v, true); 
       targets.add(t);
    }
  }
  
  void display(){
     for(Target t : targets){
        t.display(); 
     }
  }
    
}
