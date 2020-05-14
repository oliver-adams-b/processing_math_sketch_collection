

void setup(){
  size(600, 600); 
  background(255); 
}

void draw(){
  background(255); 
  
  float R1 = 100; 
  float F1 = 50; 
  PVector mouse = new PVector(mouseX, mouseY); 
  
  
  
  stroke(0); 
  strokeWeight(10); 
  line(width/2, height/2 + R1, width/2, height/2 - R1); 
  
  stroke(153); 
  strokeWeight(4); 
  line(width/2 + F1, height/2, width/2 - F1, height/2 ); 
  
  float x0 = width/2 - mouseX; 
  float y0 = height/2 - mouseY; 
  
  float x1 = pow((1/F1) - (1/x0), -1);
  float y1 = (-x1/x0)*y0; 
  
  noStroke(); 
  fill(153, 153, 255); 
  ellipse(mouseX, mouseY, 10, 10);
  ellipse(width/2 + x1, height/2 - y1, 10, 10); 
  
  stroke(255, 153, 153); 
  line(mouseX, mouseY, mouseX + x0, mouseY); 
  line(mouseX + x0, mouseY, width/2 + x1, height/2 - y1); 


  
  
}