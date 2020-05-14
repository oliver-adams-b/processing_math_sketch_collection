int size = 20; 
float radx = 200;
float rady = 100; 
PVector[][] packets = new PVector[size][size];

float theta = 0; 
float dtheta = 0.05; 


void setup(){
  background(255); 
  size(600, 600);
  
  PVector C0 = new PVector(width/2, 3*height/4); 
  
  for(int i = 0; i < size; i++){
   for(int j = 0; j < size; j++){
     float x = map(i, 0, size, -radx + C0.x, radx + C0.x); 
     float y = map(j, 0, size, -rady + C0.y, rady + C0.y); 
     
     packets[i][j] = new PVector(x, y); 
   }
  }
  
}

void draw(){
  noFill(); 
  stroke(0); 
  
  if(mousePressed)strokeWeight(1); 
  if(!mousePressed){strokeWeight(10);background(255);}
  
  theta += dtheta; 
  
  for(int i = 0; i < size; i++){
   for(int j = 0; j < size; j++){
     PVector P = packets[i][j];
     float r1 = map(j, 0, size, 0, 3.5);
     float r = exp(-.5*pow(r1 - .7, 2))*radx/size; 
     float phi = map(i, 0, size, 0, 3*PI); 
     
     PVector P1 = new PVector(P.x + cos(theta + .1*phi)*r, P.y + map(mouseX, 0, width, 0, 10)*sin(theta - phi)*r); 
     ellipse(P1.x, P1.y, 1, 1);
     
   }
  }
}