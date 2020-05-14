void setup(){
 background(255);
 size(600, 600); 
 
 
}

void draw(){
 background(255);
 float r0 = 100; 
 int n = int(map(mouseX, 0, width, 0, 20));
 
 for(int i = 0; i < n; i++){
  float theta = map(i, 0, n, 0, 2*PI);
  float dtheta = 2*PI/n;
  noFill(); 
  stroke(0); 
  strokeWeight(1); 
  ellipse(width/2, height/2, r0, r0); 
  ellipse(width/2 + r0*cos(theta), height/2 + r0*sin(theta), r0, r0); 
  ellipse(width/2 + 2*r0*cos(theta), height/2 + 2*r0*sin(theta), r0, r0);
  
  line(width/2 + r0*cos(theta), height/2 + r0*sin(theta), width/2 + r0*cos(dtheta + theta), height/2 + r0*sin(dtheta + theta)); 
  line(width/2 + 2*r0*cos(theta), height/2 + 2*r0*sin(theta), width/2 + 2*r0*cos(dtheta + theta), height/2 + 2*r0*sin(dtheta + theta));
  
  line(width/2 + r0*cos(theta), height/2 + r0*sin(theta), width/2 + r0*cos(2*dtheta + theta), height/2 + r0*sin(2*dtheta + theta)); 
  line(width/2 + 2*r0*cos(theta), height/2 + 2*r0*sin(theta), width/2 + 2*r0*cos(2*dtheta + theta), height/2 + 2*r0*sin(2*dtheta + theta));
  
  line(width/2 + 2*r0*cos(theta), height/2 + 2*r0*sin(theta), width/2 + 2*r0*cos(3*dtheta + theta), height/2 + 2*r0*sin(3*dtheta + theta));
  
  line(width/2 + 2*r0*cos(theta), height/2 + 2*r0*sin(theta), width/2 + 2*r0*cos(4*dtheta + theta), height/2 + 2*r0*sin(4*dtheta + theta)); 

 }
 
 for( int i = 0; i < 5; i++){
   float theta = map(i, 0, 5, 0, 2*PI);
   theta = theta + 0.70162237; 
   float delta = 2*PI/5;
   stroke(0); 
   strokeWeight(1); 
   PVector P0 = new PVector(width/2, height/2); 
   
   line(P0.x + r0/2*cos(theta), P0.y + r0/2*sin(theta), P0.x + r0/2*cos(theta + 2*delta), P0.y + r0/2*sin(theta + 2*delta));  
 }
 
 println(map(mouseX, 0, width, 0, 2*PI)); 
}