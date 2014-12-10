class SpringCluster {
  
   ArrayList<Particle> particles;
   ArrayList<VerletSpring> springs;
   ArrayList<Connector> connectors;
   float diameter;
   float strength;
   int count = 0;
  
   SpringCluster(Vec3D center, float _diameter, float _strength, float numParticles){
       diameter = _diameter;
       strength = _strength;
       
       particles = new ArrayList<Particle>();
       springs = new ArrayList<VerletSpring>();
       connectors = new ArrayList<Connector>();
       
       //create particles and add to array
       for(int i=0; i<numParticles; i++){
          Vec3D randomVec = Vec3D.randomVector();
          Particle p = new Particle(center.add(randomVec));
          particles.add(p);
       }
       
       
       // create springs and add to the array
       for(int i=0;i<particles.size() - 1;i++){
          VerletParticle pi = particles.get(i);
          for(int j = i+1; j<particles.size();j++){
             VerletParticle pj = particles.get(j);
             VerletSpring s = new VerletSpring(pi, pj, diameter, strength);
             physics.addSpring(s);
             springs.add(s);
          }
       }
       
   }
   
   void display() {
      // for(Particle p : particles) {
      //    p.display(); 
      // }
      
      this.showConnections();
     
   }
   
   void showConnections() {
     for(int i=0;i<particles.size() - 1;i++){
        Particle pi = particles.get(i);
        for(int j = i+1; j<particles.size();j++){
           Particle pj = particles.get(j);
           if(pi.distanceTo(pj) < 50) {
             Connector c = new Connector(pi,pj);
             c.display();
             connectors.add(c);
           } 
        }
     }
   }
   
} 
