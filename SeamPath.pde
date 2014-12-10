class SeamPath {
   
  ArrayList<Vec3D> points;
  float radius;
  String[] lines;
  
  SeamPath() {
     radius = 5;
     points = new ArrayList<Vec3D>();
     
     lines  = loadStrings("seam_points_in_order.txt");
     for(String s : lines) {
       s.trim();
       float[] numbers = float(s.split(","));
       Vec3D p = new Vec3D(numbers[0], numbers[1], numbers[2]);
       p.rotateZ(radians(270));
       p.scaleSelf(ballDiameter+16);
       points.add(p);
     }
  }
  
  void addPoint(Vec3D v){
     points.add(v); 
  }
  
  Vec3D getStart(){
     return points.get(0); 
  }
  
  Vec3D getEnd() {
     return points.get(points.size()-1); 
  }
  
  void display() {

     for(Vec3D v : points) {
        pushStyle();
        stroke(255,0,0);
        strokeWeight(3);
          point(v.x, v.y, v.z);
          
        popStyle();
     }
     stroke(0);
     strokeWeight(1);
     noFill();
     beginShape();
     for(Vec3D v : points) {
        vertex(v.x, v.y,v.z); 
     }
     endShape();
  }
  
}
