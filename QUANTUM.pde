float theta = 0; 
float dtheta = 0.01; 
float A = 40; 

import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
PeasyCam cam; 

void setup(){
 size(700, 700, P3D); 
 background(255); 
  
   cam = new PeasyCam(this, 600);

}

void draw(){
 background(255);  
 
 theta += dtheta; 
 
 stroke(0);
 line(0, 0, 0, 200, 0, 0); 
 line(0, -100, 0, 0, 100, 0); 
 line(0, 0, -100, 0, 0, 100); 
 
 for(int i = 0; i < 200; i++){
   float dx = map(i, 0, 200, 0, 2*PI); 
   PVector P0  = new PVector(i, A*sin(2*theta)*sin(dx/2), A*cos(2*theta)*sin(dx/2));
   stroke(153, 0, 0); 
   point(P0.x, P0.y, P0.z); 
   
   stroke(0, 0, 153); 
   strokeWeight(4); 
   PVector P1  = new PVector(i, A*sin(16*theta)*sin(2*dx), A*cos(16*theta)*sin(2*dx));
   point(P1.x, P1.y, P1.z); 
   
   stroke(0, 153, 0); 
   PVector P2 = new PVector (P1.y - P0.y, P1.z - P1.z);
   point(P1.x, 0, P2.mag()); 
   
 }
}