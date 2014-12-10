class MovingParticle extends VerletParticle {
  
  float maxspeed = 9;
  float maxforce = 9;
  Vec3D target;
  float strokeWeightVar = 1.5;
  float lowerPointStrokeAlpha = 150;
  float lowerPointStrokeWeightVar = 0;
  
  MovingParticle(Vec3D pos, Vec3D _target) {
     super(pos);
     target = _target;
     physics.addParticle(this);
  }
  
  void display() {
     
     pushMatrix();
       translate(x,y,z);
       pushStyle();
         stroke(213,255,36,lowerPointStrokeAlpha);
         strokeWeight(lowerPointStrokeWeightVar);
         point(0,0);
       popStyle();
       pushStyle();
         stroke(213,255,36);
         strokeWeight(strokeWeightVar);
         point(0,0);
       popStyle();
     popMatrix();
    
  }
  
  void setTarget(Vec3D v) {
     target = v; 
  }
  
  void arrive() {
     Vec3D desired = target.sub(this); 
     float d = desired.magnitude();
     
     if(d<100) {
       float m = map(d, 0 ,100,0,maxspeed);
       desired.normalizeTo(m);
     } else {
        desired.normalizeTo(maxspeed); 
     }
     
     Vec3D steer = desired.sub(this.getVelocity());
     steer.limit(maxforce);
     addForce(steer);
  }
  
  void applyForce(Vec3D f){
     this.addForce(f); 
  }
  
  void setStrokeWeight() {
      
  }
  
  
}
