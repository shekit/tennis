class SeamParticle extends VerletParticle {
  
  Vec3D location;
  Vec3D velocity;
  Vec3D acceleration;
  float r;
  float maxforce;
  float maxspeed;
  float strokeAlpha = 255;
  
  SeamParticle(Vec3D pos, float ms, float mf){
    super(pos);
    location = pos;
    r = 2.0;
    maxspeed = ms;
    maxforce = mf;
    acceleration = new Vec3D(0,0,0);
    velocity = new Vec3D(maxspeed, 0,0);
  }
  
  public void run() {
     update();
     display();
  }
  
  void follow(SeamPath p) {
    Vec3D predict = velocity.copy();
    predict.normalize();
    predict.scaleSelf(50);
    Vec3D predictLoc = location.add(predict);
    
    Vec3D normal = null;
    Vec3D target = null;
    float worldRecord = 1000000;
    
    for(int i=0;i<p.points.size() - 1;i++) {
       Vec3D a = p.points.get(i);
       Vec3D b = p.points.get(i+1);
       
       Vec3D normalPoint = getNormalPoint(predictLoc, a,b);
       
       if (normalPoint.x < a.x || normalPoint.x > b.x) {
        normalPoint = b.copy();
      }

      if (normalPoint.y < a.y || normalPoint.y > b.y) {
        normalPoint = b.copy();
      }

      if (normalPoint.z < a.z || normalPoint.z > b.z) {
        normalPoint = b.copy();
      }
       
       float distance = predictLoc.distanceTo(normalPoint);
       
       if(distance < worldRecord) {
          worldRecord = distance;
          
          normal = normalPoint;
          
          Vec3D dir = b.sub(a);
          dir.normalize();
          
          dir.scaleSelf(10);
          target = normalPoint.copy();
          target.addSelf(dir);
       }
    }
       
       if(worldRecord > p.radius) {
          seek(target); 
       }
       
  }
  
    Vec3D getNormalPoint(Vec3D p, Vec3D a, Vec3D b) {
    // Vector from a to p
    Vec3D ap = p.sub(a);
    // Vector from a to b
    Vec3D ab = b.sub(a);
    ab.normalize(); // Normalize the line
    // Project vector "diff" onto line by using the dot product
    ab.scaleSelf(ap.dot(ab));
    Vec3D normalPoint = a.add(ab);
    return normalPoint;
  }


  // Method to update location
  void update() {
    // Update velocity
    velocity.addSelf(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    location.addSelf(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.scaleSelf(0);
  }

  void applyForce(Vec3D force) {
    // We could add mass here if we want A = F / M
    acceleration.addSelf(force);
  }
  


  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  void seek(Vec3D target) {
    Vec3D desired = target.sub(location);  // A vector pointing from the location to the target

    // If the magnitude of desired equals 0, skip out of here
    // (We could optimize this to check if x and y are 0 to avoid mag() square root
    if (desired.magnitude() == 0) return;

    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.scaleSelf(maxspeed);
    // Steering = Desired minus Velocity
    Vec3D steer = desired.sub(velocity);
    steer.limit(maxforce);  // Limit to maximum steering force

      applyForce(steer);
  }

  void display() {
    if(strokeAlpha != 0){
      pushMatrix();
        translate(location.x, location.y, location.z);
        pushStyle();
        stroke(255, strokeAlpha);
        strokeWeight(7);
        point(0,0);
        popStyle();
      popMatrix();
    }
  }
  
  void disappear(){

     if(strokeAlpha <= 0){
        strokeAlpha = 0; 
     } else {
        strokeAlpha -= 5;
     }
  }
  
  void appear() {
    if(strokeAlpha >= 255) {
        strokeAlpha = 255;
    } else {
      strokeAlpha += 2;
    }
  }
    
}
