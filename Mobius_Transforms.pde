circle C0 = new circle(); 
circle[] circles = new circle[1]; 
square[] squares = new square[1]; 
PVector M = new PVector(); 
PVector C = new PVector();

void setup(){ //***************************************** SETUP
 size(600, 600); 
 background(252, 110, 110);
 
 C0.res = 100; 
 C0.radius = 100; 
 
 for(int i = 0; i < circles.length; i++){
   float a = map(i, 0, circles.length, 100, 300); 
   circles[i] = new circle(); 
   circles[i].radius = a; 
   circles[i].res = int(a * 1.5); 
 }
 
 for(int i = 0; i < squares.length; i++){
  float a = map(i, 0, squares.length, 100, 200); 
  
  squares[i] = new square(); 
  squares[i].dim = a; 
  squares[i].res = int(a); 
 }
}

void draw(){  //***************************************** MAIN
 background(252, 110, 110); 
 M = new PVector(mouseX, mouseY); 
 C = new PVector(width/2, height/2); 
 
 pushStyle();
   noFill();
   stroke(0);
   ellipse(width/2, height/2, 100, 100); 
 popStyle();
 
 for(circle C0: circles){
  C0.initialize(); 
  C0.update(); 
  C0.position = new PVector(M.x, M.y);
  C0.drawTransform(); 
 }
 
 for(square S0: squares){
  S0.initialize(); 
  S0.update(); 
  S0.position = new PVector(M.x, M.y); 
  S0.drawTransform(); 
 } 
}

class circle{ //***************************************** CIRCLE CLASS
  
  PVector position; 
  PVector[] vertices; 
  
  int res; 
  float radius; 
  
  circle(){
   position = new PVector(width/2, height/2); 
   vertices = new PVector[res];
   res = 0; 
  }
  
  void initialize(){
    vertices = new PVector[res];
    
    for(int i = 0; i < res; i++){
     float theta = map(i, 0, res, 0, TWO_PI); 
     PVector P1 = new PVector(); 
     
     P1.x = radius/2 * cos(theta) + position.x; 
     P1.y = radius/2 * sin(theta) + position.y; 
     
     vertices[i] = P1; 
    }
  }
  
  void update(){
   pushStyle(); 
   fill(0); 
    for(PVector P0: vertices){
      ellipse(P0.x, P0.y, 1, 1);  
    }
   popStyle(); 
  }
  
  void drawTransform(){
   pushStyle();
   for(int i = 0; i < res; i++){
    PVector P1 = new PVector(); 
    PVector P2 = new PVector();
    
    P1 = mobiusTransform(new PVector(width/2, height/2), 
                         vertices[i], 
                         100); 
    P2 = mobiusTransform(new PVector(width/2, height/2), 
                         vertices[(i + 1)%res], 
                         100); 
                         
    fill(255);
    stroke(255);
    line(P2.x, P2.y, P1.x, P1.y); 
    noStroke();
    ellipse(P1.x, P1.y, 2, 2); 
   }
   popStyle();
  }
}

class square{  //***************************************** RECTANGLE
 
  PVector[] vertices; 
  PVector position; 
 
  float dim; 
  int res; 
  
  square(){
   position = new PVector(width/2, height/2); 
   res = 0; 
   dim = 0; 
   
   vertices = new PVector[res * 4]; 
  }
  
  void initialize(){
   vertices = new PVector[res * 4]; 
   PVector tl = new PVector(position.x - dim/2, position.y - dim/2); 
   PVector br = new PVector(position.x + dim/2, position.y + dim/2);
   
   float d = map(4, 0, vertices.length, 0, dim); 
   
   for(int i = 0; i < vertices.length; i += 4){
    float a = map(i, 0, vertices.length, 0, dim); 
    
    vertices[i] = new PVector(br.x - a - d, br.y); 
    vertices[i + 1] = new PVector(br.x, br.y - a); 
    vertices[i + 2] = new PVector(tl.x + a + d, tl.y); 
    vertices[i + 3] = new PVector(tl.x, tl.y + a); 
   }
  }
  
  void update(){
   pushStyle(); 
   fill(0); 
    for(PVector P0: vertices){
      ellipse(P0.x, P0.y, 1, 1);  
    }
   popStyle(); 
  }
  
  void drawTransform(){
   pushStyle();
   for(int i = 0; i < vertices.length; i++){
    PVector P1 = new PVector(); 
    PVector P2 = new PVector();
    
    P1 = mobiusTransform(new PVector(width/2, height/2), 
                         vertices[i], 
                         100); 
    P2 = mobiusTransform(new PVector(width/2, height/2), 
                         vertices[(i + 4)%(vertices.length)], 
                         100); 
                         
    fill(255);
    stroke(255);
    //line(P2.x, P2.y, P1.x, P1.y); 
    noStroke();
    ellipse(P1.x, P1.y, 2, 2); 
   }
   popStyle();
  }
}

//***************************************** MISCELLANEOUS FUNCTIONS


PVector mobiusTransform(PVector P0, PVector P1,  float a){
  PVector P2 = PVector.sub(P0, P1); 
  float r = mag(P2.x, P2.y);
  float newr = pow(a/2, 2) / r; 
  
  P2.normalize(); 
  P2.mult(-newr);
  P2.add(P0); 
 
  return P2; 
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