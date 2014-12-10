class Ball {
  
  ArrayList<Target> targets;
  SphereConstraint sphere;
  Vec3D force = new Vec3D(0,0.1,0);
  
  Ball(int numParticles, float diameter){
    
    targets = new ArrayList<Target>();
    sphere = new SphereConstraint(worldCenter, diameter+1, true);
    
    for(int i=0;i<numParticles;i++){
       Vec3D v = Vec3D.randomVector();
       v.scaleSelf(diameter);
       Target t = new Target(v, false); 
       targets.add(t);
    }
  }
  
  void display(){
     for(Target t : targets){
        t.display(); 
     }
  }
  
  void applyConstraint() {
      for(Target t : targets){
         sphere.apply(t); 
      }
  }
  
  void applyForce(Vec3D f){
    
     for(int i = 0; i<targets.size(); i++){
       if(i%3 == 0){
          targets.get(i).addForce(f);
       }
     }
  }

    
}
