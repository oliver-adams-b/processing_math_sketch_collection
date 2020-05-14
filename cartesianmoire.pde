PVector[] points = new PVector[5000];
PVector[] spoints = new PVector[5000];

void setup(){
  size(800, 800); 
  background(0); 
  
  int n = 0; 
  
  for(int i = 0; i < points.length; i++){ points[i] = new PVector(0, 0); spoints[i] = points[i];}
  
  for(int i = 0; i < floor(sqrt(points.length)); i++){
     for(int j = 0; j < floor(sqrt(points.length)); j++){
       float x = map(i, 0, floor(sqrt(points.length)), 0, width); 
       float y = map(j, 0, floor(sqrt(points.length)), 0, height); 
       //delay(10); 
       
       points[n] = new PVector(x, y); 
       spoints[n] = points[n];
       
       n++;
       println(n); 
     }
  }
}

void draw(){
  background(153); 
  
  stroke(255); 
  fill(255); 
  for(int i = 0; i < points.length-1; i++){
    PVector P0 = points[i]; 
    PVector P1 = spoints[i]; 
    ellipse(P0.x, P0.y, 5, 5); 
  }
  
  for(PVector P0: spoints){
    float d = dist(P0.x, P0.y, mouseX, mouseY)*.88;
    PVector dir = new PVector(mouseX - P0.x, mouseY - P0.y); 
    dir.normalize(); 
    
    P0 = new PVector(-d * dir.x + mouseX, -d * dir.y + mouseY); 
    ellipse(P0.x, P0.y, 5, 5); 
  }
  
  
  
}

void ray(PVector P0, PVector P1){
 PVector P2 = newVertex(P0, P1, 10000);
 PVector P3 = newVertex(P1, P0, 10000);
 
 line(P0.x, P0.y, P3.x, P3.y);
 line(P0.x, P0.y, P2.x, P2.y);
}

PVector newVertex(PVector P0, PVector P1, float dist) { 

  PVector direction = PVector.sub(P0, P1);
  direction.normalize();
  direction.mult(dist);
  PVector P2 = PVector.add(P0, direction);

  return P2;
}