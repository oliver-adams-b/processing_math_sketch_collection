PFont DRIP;
float size = 50; 

void setup() {
  //fullScreen();
  size(600, 600); 
  background(255); 
  
  DRIP = createFont("DoubleFeature20.ttf", size); 
  textAlign(CENTER, CENTER); 
  
  noLoop();
} 

void draw() {
  background(255); 
  
  fill(0); 
  ellipse(width/2, height/2 + 30, 340, 340);
  
  textFont(DRIP);
  fill(255); 
  text("FULL MOON", width/2, height/2); 
  text("SURF SAILS", width/2, height/2 + 60); 
  
  PFont.list();
  
  saveFrame();
}