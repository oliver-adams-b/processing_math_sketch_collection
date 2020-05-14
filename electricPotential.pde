Vertex[] matrix = new Vertex[4];

void setup(){
 background(255); 
 size(900, 900); 
 //fullScreen(); 
 
 rectMode(CENTER);
 
 for(int i = 0; i < matrix.length; i++){
   matrix[i] = new Vertex(); 
   matrix[i].type = "Vertex"; 
   matrix[i].MoveType = "Normal"; 
   matrix[i].size = new PVector(20, 20); 
   matrix[i].selected = true; 
   matrix[i].slideVal = pow(-1, i) * 10; 
   matrix[i].position = new PVector(random(0, width), random(0, height)); 
 }
 
 matrix[0].slideVal = -10; 
 matrix[1].slideVal = 10; 
 matrix[2].slideVal = -10; 
 matrix[3].slideVal = 10; 
 
 
 
}

void draw(){
 background(255); 
 
 /*
 matrix[0].position = new PVector(width/2 -mouseX/2, width/2 - mouseY/2);
 matrix[1].position = new PVector(width/2 +mouseX/2, width/2 - mouseY/2);
 matrix[2].position = new PVector(width/2 +mouseX/2, width/2 + mouseY/2);
 matrix[3].position = new PVector(width/2 -mouseX/2, width/2 + mouseY/2);
 */
 pushStyle(); 
 int xres = 200; 
 int yres = 200; 
 
 for(int i = 0; i < xres; i++){
  for(int j = 0; j < yres; j++){
    float dx = map(i, 0, xres, 0, width); 
    float dy = map(j, 0, yres, 0, height); 
    
    float sum = 0; 
    for(int k = 0; k <matrix.length; k++){
     Vertex V0 = matrix[k]; 
     float dk = dist(dx, dy,  V0.position.x, V0.position.y); 
     sum += (1/dk)*matrix[k].slideVal; 
    }
   
    if(approx(sum, 0)) fill(255, 255, 255); 
    if(!approx(sum, 0))fill(map(sum, -0.005, 0.005, 0, 255), 0, 0); 
    noStroke(); 
    rect(dx, dy, width/(xres)*2, height/(yres) *2); 
  }
 }
 popStyle(); 
 
 for(Vertex v: matrix){
   v.run();  
  }
}

void mousePressed(){
  for(Vertex v: matrix){
   v.pressed();  
  }
}

void mouseDragged(){
  for(Vertex v: matrix){
   v.dragged();  
  }
}

void mouseReleased(){
  for(Vertex v: matrix){
   v.released();  
  }
}

//***************************************************************Vertex Class

class Vertex {

  PVector position; 
  PVector dPosition;
  PVector size;
  PVector sliderRange;
  PVector sliderPosition;

  boolean overVertex;
  boolean locked;
  boolean selected;
  boolean hidden; 

  float slideVal;

  String MoveType;
  String type;
  String name; 

//***************************************************************Instance

  public Vertex() {
    slideVal = 0;

    position = new PVector(random(4 * width / 5, width), random(0, height / 5));
    size = new PVector(0, 0);
    sliderRange = new PVector(0, 0);
    sliderPosition = new PVector(position.x, position.y);

    MoveType = "Normal";
    type = "Vertex";
    name = "";

    locked = false;
    selected = false;
  }
  
  public void run(){
   initiate();
   reInitiate();
  }

//***************************************************************Initiate

  public void initiate() {
    dPosition = new PVector(0, 0);
    if(type == "Slider")MoveType = "Vertical"; 
  } 

  public boolean select() {
    selected = !selected; 

    return selected;
  }

//***************************************************************Reinitiate
  public void reInitiate() {

    pushStyle();
    strokeWeight(1.5);

    if(mouseX > position.x - (.5 * size.x) && mouseX < position.x + (.5 * size.x) && 
       mouseY > position.y - (.5 * size.y) && mouseY < position.y + (.5 * size.y)) {
          
      overVertex = true;

      if(!locked){ 
        stroke(0);
        fill(153, 60);
      }
      
    }else{ // Colors and Shit for Unselected
      stroke(153);
      fill(107, 193, 218, 150);
      overVertex = false;
    }

    if(type == "Vertex") {
      ellipse(position.x, position.y, size.x, size.y);
    }
    
    if(type == "Button") {
      if(selected) { 
        stroke(0);
        strokeWeight(2);
        fill(107, 193, 218, 200);
      }
      
     if(!hidden) rect(position.x, position.y, size.x, size.y);
    }

    if (type == "Slider") {
      if(!hidden){
        fill(0);
        stroke(0); 
        text(sliderRange.y, sliderPosition.x - 15, sliderPosition.y - 85);
        text(sliderRange.x, sliderPosition.x - 15, sliderPosition.y + 92);
        line(sliderPosition.x, sliderPosition.y, sliderPosition.x, sliderPosition.y + 80);
        line(sliderPosition.x, sliderPosition.y, sliderPosition.x, sliderPosition.y - 80);
        
        fill(107, 193, 218, 200); 
        rect(position.x, position.y, size.x, size.y);
      }
      
      float slideDist = dist(position.x, position.y, sliderPosition.x, sliderPosition.y - 100);
      slideVal = (map(slideDist, 100 - (100 - .5 * size.y), 100 + (100 - .5 * size.y), sliderRange.y, sliderRange.x));
      
      name = "" + nf(slideVal, 1, 3);
    }
  


    fill(0);
    textSize(20);
    if(!hidden) text(name, position.x - (.5 * size.x) + 4, position.y + (.125 * size.y));
    popStyle();
  }

//***************************************************************Mouse Pressed
  public void pressed() {
    pushStyle();
    
    if(type == "Button") {
      if(overVertex) {
        select();
      }
    }
     
    if(type == "Vertex") {
      if(overVertex) {
        locked = true; 
        fill(153);
      }else{
        locked = false;
      } 
      dPosition = new PVector(mouseX - position.x, mouseY - position.y);
    }
     
    if(type == "Slider") {
      if(overVertex) {
        locked = true; 
        fill(153);
      }else{
        locked = false;
      } 
    }
    
    popStyle();
  }

//***************************************************************Mouse Dragged

  public void dragged(){

    if (locked) {
      if (MoveType == "Normal") {
        position = new PVector(mouseX - dPosition.x, mouseY - dPosition.y);
      }
      if (MoveType == "Horizontal") {
        position = new PVector(mouseX - dPosition.x, position.y);
      }
      if (MoveType == "Vertical") {
        position = new PVector(position.x, mouseY - dPosition.y);
        
        if(position.y < sliderPosition.y - (80 - .125 * size.y)) position.y = sliderPosition.y - (80 - .125 * size.y);
        if(position.y > sliderPosition.y + (80 - .125 * size.y)) position.y = sliderPosition.y + (80 - .125 * size.y);
      }
      if (MoveType == "Fixed") {
        //position = position;
      }
    }
  }

//***************************************************************Mouse Released

  public void released() {
    if (type == "Vertex") {
      locked = false;
    }
    if (type == "Button") {
      locked = true;
    }
  }
}

boolean approx(float a, float b){
  boolean buul = true;
  if(abs(a - b) < 0.0008) buul = true; 
  if(abs(a - b) > 0.0008) buul = false;  
  return buul;
}