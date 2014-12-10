class Particle extends VerletParticle {
    
  Particle(Vec3D pos) {
      super(pos);
      physics.addParticle(this);
  }
  
  void display() {
      pushMatrix();
        translate(this.x,this.y,this.z);
        stroke(255);
        strokeWeight(2);
        point(0,0);
      popMatrix();
   }
}
