class SeamParticleSystem {
   
  ArrayList<SeamParticle> particles;
  
  SeamParticleSystem(int numParticles) {
     particles = new ArrayList<SeamParticle>();
     
     for(int i=0;i<numParticles;i++) {
        SeamParticle p = new SeamParticle(new Vec3D(0,width/2,0), random(2,5), random(0.8,1.2));
        particles.add(p);
     }
  }
  
  void follow() {
    for(SeamParticle p : particles) {
      p.follow(seam);
    }
  }
  
  void applyForce(Vec3D f){
     for(SeamParticle p : particles){
        p.applyForce(f); 
     }
  }
  
  void run() {
     for(SeamParticle p : particles) {
        p.update(); 
        p.display();
     }
     //showConnections();
  }
  
  void showConnections() {
    for(int i=0;i<particles.size()-1;i++){
        SeamParticle s1 = particles.get(i); 
          for(int j = i+1; j<particles.size(); j++){
            SeamParticle s2 = particles.get(j);
            
            float distance = s1.location.distanceTo(s2.location);
            
           if(distance < 5) {
        
               stroke(255,0,0,150);
               strokeWeight(0.6);
               line(s1.location.x,s1.location.y,s1.location.z,s2.location.x,s2.location.y,s2.location.z); 
           
            }
            
          }
     }
  }
  
  void disappear() {
     for(SeamParticle p : particles){
        p.disappear();
     }
  }
  
  void appear() {
    for(SeamParticle p : particles){
        p.appear();  
     }
  }
  
}
