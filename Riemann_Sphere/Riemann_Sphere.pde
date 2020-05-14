import peasy.*;
PeasyCam cam;

float res = .1;
float dim = 2; 

ArrayList<PVector> sphere = new ArrayList<PVector>();
ArrayList<PVector> plane = new ArrayList<PVector>();

PVector N = new PVector(0, 0, 10);
PVector disp = new PVector(0, 0); 


int step = 1; 
void setup(){
  background(255); 
  size(600, 600, P3D); 
  fill(153, 30);
  strokeWeight(4); 
  
  cam = new PeasyCam(this, 100); 
  cam.setMinimumDistance(60); 
  cam.setMaximumDistance(400);
  
  for(int i = 0; i < sphere.size(); i++){
   sphere.remove(i); 
  }
  for(int i = 0; i < plane.size(); i++){
   plane.remove(i); 
  }
  
  drawShit(); 
}

void draw(){
  background(255); 
  
  for(int i = 0; i < sphere.size(); i++){
    PVector S = sphere.get(i); 
    PVector P = plane.get(i);
    
    stroke(map(i, 0, sphere.size(), 255, 0), 
           map(i, 0, sphere.size(), 0, 225), 
           map(i, 0, sphere.size(), 63, 255));
           
    strokeWeight(2); 
    point(S.x, S.y, S.z);
   
    strokeWeight(2);
    point(P.x, P.y, P.z); 
  }
  
  pushStyle();
    noStroke();
    fill(255, 255, 255, 150); 
    sphereDetail(20); 
    sphere(10);
    
    stroke(255, 0, 63); 
    line(-100, 0, 0, 100, 0, 0); 
    
    stroke(0, 225, 255); 
    line(0, -100, 0, 0, 100, 0); 
  popStyle(); 
}

void keyPressed(){
  
  drawShit(); 
  
  if(key == CODED){
    if(keyCode == LEFT) disp.x  -= .1; 
    if(keyCode == RIGHT) disp.x += .1; 
    if(keyCode == DOWN) disp.y  += .1;
    if(keyCode == UP) disp.y    -= .1;
  }
  
  drawShit(); 

}

PVector lineToCircle(float d){
 PVector P0 = new PVector(); 
 
 P0.x = 2/(d + (1/d)); 
 P0.y = -2/(pow(d, 2) +1) + 1; 
  
 return P0; 
}

PVector planeToSphere(PVector P0){ 
 PVector P2 = new PVector(); 
 
 float r = 10; 
 
 P2.x = r * (2 * P0.x) / (1 + pow(P0.x, 2) + pow(P0.y, 2));  
 P2.y = r * (2 * P0.y) / (1 + pow(P0.x, 2) + pow(P0.y, 2));
 P2.z = r * (-1 + pow(P0.x, 2) + pow(P0.y, 2)) /  (1 + pow(P0.x, 2) + pow(P0.y, 2));
 
 return P2; 
}

PVector sphereToPlane(PVector P0){
 PVector P2 = new PVector(); 
 
 float r = 10; 
 
 P2.x = r * (P0.x / (1 - P0.z)); 
 P2.y = r * (P0.y / (1 - P0.z)); 
 
 return P2; 
}

void drawShit(){
 for(int i = 0; i < sphere.size(); i++){
  sphere.remove(i); 
 }
 
 for(int i = 0; i < plane.size(); i++){
  plane.remove(i); 
 }
 
 PVector P0; 

 for(float i = -dim + disp.x; i <= dim + disp.x; i += res){
   for(float j = -dim + disp.y; j <= dim + disp.y; j += res){

    P0 = planeToSphere(new PVector(i , j));
    
    sphere.add(new PVector(P0.x, P0.y, P0.z));
    plane.add(new PVector(i * 10, j * 10)); 
   }
 } 
}

float arctan(float x, float y){
 float theta = 0; 
 
 if(x > 0) theta = atan(y/x); 
 else if(x < 0 && y >= 0) theta = atan(y/x) + PI; 
 else if(x < 0 && y < 0) theta = atan(y/x) - PI; 
 else if(x == 0 && y > 0) theta = PI/2; 
 else if(x == 0 && y < 0) theta = -PI/2; 
 else if(x == 0 && y == 0) theta = 0; 
 
 return theta; 
}

void ray(PVector P0, PVector P1){
 PVector P2 = newVertex(P0, P1, 10000);
 PVector P3 = newVertex(P1, P0, 10000);
 
 line(P0.x, P0.y, P0.z, P3.x, P3.y, P3.z);
 line(P0.x, P0.y, P0.z, P2.x, P2.y, P2.z);
}

PVector newVertex(PVector P0, PVector P1, float dist) { 

  PVector direction = PVector.sub(P0, P1);
  direction.normalize();
  direction.mult(dist);
  PVector P2 = PVector.add(P0, direction);

  return P2;
}