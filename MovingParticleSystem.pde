class MovingParticleSystem {
  
  ArrayList<MovingParticle> particles;
  float sAlpha = 20;
  float sAlpha1 = 90;
  float sAlpha2 = 150;
  
  MovingParticleSystem(int numParticles) {
     particles = new ArrayList<MovingParticle>();
     
     for(int i=0;i<numParticles;i++) {
        Vec3D v = Vec3D.randomVector();
        v.scaleSelf(width+10);
        MovingParticle p = new MovingParticle(v,v); 
        particles.add(p);
     }
  }
  
  void setTarget(ArrayList<Target> targets) {
      for(MovingParticle p: particles) {
         int randomNumber = int(random(targets.size()));
         Target t = targets.get(randomNumber);
         p.setTarget(t);
      }
  }
  
  void arrive() {
     for(MovingParticle p : particles) {
         p.arrive();
     }
  }
  
  void display() {
     for(MovingParticle p : particles){
        p.display(); 
     }
     

       showConnections();
 
     
  }
  
  void showConnections(){
    // connect the dots with lines
     for(int i=0; i <particles.size(); i++) {
       MovingParticle pi = particles.get(i);
       for(int j=0;j<i;j++){
         MovingParticle pn = particles.get(j);
         
         float d = pi.distanceTo(pn);
         //float strokeWeightVar = map(d, 0, ballDiameter+2, 0,1);
         if(d>75 && d<150){
           strokeWeight(0.2);
           stroke(213,255,36,sAlpha);
           if(!greenConnections){
              sAlpha -= 0.001;
              sAlpha = constrain(sAlpha,0,20);
           } else {
              sAlpha = constrain(sAlpha,0,20);
              sAlpha += 0.0005;
           }
           if(sAlpha != 0){
             line(pi.x,pi.y,pi.z,pn.x,pn.y,pn.z);
           }

         }else if(d>50 && d <= 75) {
           strokeWeight(0.6);
           stroke(213,255,36,sAlpha1);
           if(!greenConnections){
              sAlpha1 -= 0.001;
              sAlpha1 = constrain(sAlpha1,0,90);
           } else {
              sAlpha1 = constrain(sAlpha1,0,90);
              sAlpha1 += 0.0005;
           }
           if(sAlpha1 != 0){
             line(pi.x,pi.y,pi.z,pn.x,pn.y,pn.z);
           }
           // stroke(213,255,36,90);
           //  strokeWeight(0.6); 
           //  line(pi.x,pi.y,pi.z,pn.x,pn.y,pn.z);
         } else if(d>25 && d<=50) {
           strokeWeight(1);
           stroke(213,255,36,sAlpha2);
           if(!greenConnections){
              sAlpha2 -= 0.001;
              sAlpha2 = constrain(sAlpha2,0,150);
           } else {
              sAlpha2 = constrain(sAlpha2,0,150);
              sAlpha2 += 0.0005;
           }
           if(sAlpha2 != 0){
             line(pi.x,pi.y,pi.z,pn.x,pn.y,pn.z);
           }

         } else if(d>15 && d<20){
            
           if(!greenConnections){
              strokeWeight(0.3);
              stroke(213,255,36,100);
              line(pi.x, pi.y, pi.z, pn.x, pn.y, pn.z);
           }

         } else if(d<10){
            
           if(!greenConnections){
              strokeWeight(1.2);
              stroke(213,255,36,255);
              line(pi.x, pi.y, pi.z, pn.x, pn.y, pn.z);
           }
         } 
          //stroke(255);
          
       }
    }
  }
  
  void applyForce(Vec3D f) {
     for(MovingParticle p : particles) {
        p.addForce(f); 
     }
  }
  
}
