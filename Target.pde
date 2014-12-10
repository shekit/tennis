class Target extends VerletParticle {
  
  boolean locked;
  
  Target(Vec3D pos, boolean _locked) {
     super(pos); 
     locked = _locked;
     physics.addParticle(this);
     if(locked){
       this.lock();
     }
  }
  
  void display() {
    noFill();
    pushMatrix();
    translate(x,y,z);
    stroke(0,150,0);
    strokeWeight(2);
    point(0,0);
    popMatrix();
  }
  
  
}
