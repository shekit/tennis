class SvgImage {
  
  RShape name;
  RPoint[] points;
  ArrayList<Target> targets;
  
  float scale;
  Vec3D yOffset;
  
  SvgImage(String fileName, float _scale, Vec3D _yOffset, int sampleRate) {
    name = RG.loadShape(fileName);
    name = RG.centerIn(name,g);
    points = name.getPoints();
    targets = new ArrayList<Target>();
    scale = _scale;
    yOffset = _yOffset;
    for(int i=0;i<points.length;i++){
       if(i%sampleRate==0){
          Target t = new Target(new Vec3D(points[i].x, points[i].y, 0), true); 
          t.scaleSelf(scale);
          t.addSelf(yOffset);
          targets.add(t);
          
       }
    }
  }
  
  void display() {
     for(Target t : targets){
        t.display(); 
     }
  }
  
  void oscillate() {
      // for(Target t : targets){
      //     t.oscillate();
      // }
      float x = theta;
      for(int i=0;i<targets.size();i++){
           targets.get(i).z = sin(x) * 30;
           x += 0.0008;
     }
      
    }

}
