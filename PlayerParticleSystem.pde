class PlayerParticleSystem {
  
  ArrayList<PlayerParticle> particles;
  float[] heights = {-height, height};
  
  PlayerParticleSystem(int numParticles) {
     particles = new ArrayList<PlayerParticle>();
     
     for(int i=0;i<numParticles;i++) {
        Vec3D v = Vec3D.randomVector();
        if(i%10 == 0){
          v.scaleSelf(width+10);
        } else {
           //int index = int(random(heights.length));
           v.x = random(-width,width);
           v.y = -height-5;
        }
        PlayerParticle p = new PlayerParticle(v,v); 
        particles.add(p);
     }
  }
  
  void setTarget(ArrayList<Target> targets) {
      
    // repopulate the list

      for(PlayerParticle p: particles) {
         int randomNumber = int(random(targets.size()));
         Target t = targets.get(randomNumber);
         p.setTarget(t);
      }

      
      // x= random(random.size());
      // randoms.remove(x)
      // while(randoms.contains(x){
      //    x = int(random(targets.size())); 
      // }
      // target t = targets.get(x);
      // p.setTarget(t);
  }
  
  void setTwoTargets(ArrayList<Target> picTargets, ArrayList<Target> nameTargets){
    int picTargetsNum = particles.size() - nameTargetParticles;
    
    for(int i=0;i<particles.size();i++){
       if(i<=picTargetsNum){
         int randomNumber = int(random(picTargets.size()));
         Target t = picTargets.get(randomNumber);
         particles.get(i).setTarget(t);
       } else {
         int randomNumber = int(random(nameTargets.size()));
         Target t = nameTargets.get(randomNumber);
         particles.get(i).setTarget(t);
       }
    }
  }
  
  void arrive() {
     for(PlayerParticle p : particles) {
         p.arrive();
     }
  }
  
  void display() {
     for(PlayerParticle p : particles){
          p.display(); 
     }
  }
  
  void applyForce(Vec3D f) {
     for(PlayerParticle p : particles) {
        p.addForce(f); 
     }
  }
    
}
