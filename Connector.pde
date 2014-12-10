class Connector {
  
  Particle p1;
  Particle p2;
  int count = int(random(0,20));
  
  Connector(Particle _p1, Particle _p2){
     p1 = _p1;
     p2 = _p2;
  }
  
  void display() {
     stroke(213,255,36);
    // make lines blink
     pushStyle();
        if(count >= 0 && count < 5){
          strokeWeight(3);
        } else if(count >= 5 && count < 10){
           strokeWeight(2); 
        } else if(count >= 10 && count <= 15) {
           strokeWeight(1); 
        } else if(count>15 && count <= 20){
           strokeWeight(0.8); 
        }
     
     line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
     popStyle();
     
     count ++ ;
     
     if(count > 20) {
        count = 0; 
     }
    
  }
}
