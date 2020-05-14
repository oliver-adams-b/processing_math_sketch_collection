//     All of this code was written very late at night, I am sorry if it is really hard to read/follow. There should be some cool stuff hidden around
// This code was inspired by some literature on the Sierpinski Gasket. The first panel you will see is the initial IFS state, the second is the 'fractal' 
// after some number of iterations, and the third panel is a space-filling 'curve' from the gasket.  


frac test = new frac(); 
Vertex[] boxes = new Vertex[4]; 

int count = 0; 

void setup() {
  //fullScreen(); 
  size(1200, 800); 
  background(153);
  
  rectMode(CENTER); 
  noStroke(); 
  
  for(int i = 0;i < boxes.length; i++){
   boxes[i] = new Vertex();
   boxes[i].size = new PVector(200, 200); 
   boxes[i].type = "Vertex"; 
   boxes[i].MoveType = "Normal";
  }
  
  //boxes[3].size = new PVector(100, 100); 
  //boxes[4].size = new PVector(100, 100);
  
  boxes[0].position = new PVector(width/2 - 100, height/2 - 100);
  boxes[1].position = new PVector(width/2 + 100, height/2 - 100);
  boxes[2].position = new PVector(width/2 + 100, height/2 + 100);
  boxes[3].position = new PVector(width/2 - 100, height/2 + 100);
  //boxes[4].position = new PVector(width/2 - 75, height/2 + 75);
  
  test.pos = new PVector(width/2, height/2); 
  test.L = 400; 
  test.iteration = 4; 
  test.initialize();
  test.pop(); 
  
} 

void draw() { //*******************************************DRAW
  background(107, 183, 218, 153); 
  test.display(); 
  for(Vertex v: boxes){
   v.run();
  }
   
}


PVector seedPos(int i, square S0){
  float x = boxes[i].position.x;//constrain(int(boxes[i].position.x), int(width/2 - 200 + boxes[i].size.x/2), int(width/2  + 200 - boxes[i].size.x/2)); 
  float y = boxes[i].position.y;//constrain(int(boxes[i].position.y), int(height/2 - 200 + boxes[i].size.y/2), int(height/2 + 200 - boxes[i].size.y/2)); 
  
  float mapX = map(x, width/2 - 200 + boxes[i].size.x/2 , width/2  + 200 - boxes[i].size.x/2, -S0.size/4, S0.size/4);
  float mapY = map(y, height/2 - 200 + boxes[i].size.y/2, height/2 + 200 - boxes[i].size.y/2, -S0.size/4, S0.size/4);
  
  return new PVector(mapX, mapY); 
}


PVector mobiusTransform(PVector P0, PVector P1,  float a){
  PVector P2 = PVector.sub(P0, P1); 
  float r = mag(P2.x, P2.y);
  float newr = pow(a/2, 2) / r; 
  
  P2.normalize(); 
  P2.mult(-newr);
  P2.add(P0); 
 
  return P2; 
}

class square{ //*******************************************SQUARE OBJECT
  PVector pos; 
  PVector mobPos;  
  float size; 
  
  square(){
   pos = new PVector(0, 0); 
   size = 0; 
  }
  
  square(PVector P0, float L){
   pos = P0; 
   size = L;
   
   mobPos = mobiusTransform(new PVector(width/2, height/2), pos, 100); 
   mobPos.x += 400; 
   
   mobPos.x = constrain(int(mobPos.x), width/2 + 200, width/2 + 600);
   mobPos.y = constrain(int(mobPos.y), height/2 - 200, height/2 + 200);
   
  }
  
  void draw(){
   fill(0, 200); 
   ellipse(pos.x, pos.y, size, size); 
   //ellipse(mobPos.x, mobPos.y, size, size); 
  }
}

class frac{ //*******************************************FRACT
 ArrayList<square> squares; 
 PVector pos;
 float L; 
 int iteration;

 frac() {
  //squares = new ArrayList<square>(); 
  pos = new PVector(0, 0);
  L = 0; 
  iteration = 0; 
 }

 void initialize(){
  squares = new ArrayList<square>();
  squares.add(new square(pos, L)); 
 }

 void display(){
  pushStyle(); 
  
    for(int i = 1; i <= squares.size(); i++){
      square S0 = squares.get(i % squares.size()); 
      square S1 = squares.get((i-1) % squares.size()); 
      
      strokeWeight(1);
      stroke(0);
      //line(S0.pos.x + 400, S0.pos.y, S1.pos.x + 400, S1.pos.y);
      //line(S0.mobPos.x, S0.mobPos.y, S1.mobPos.x, S1.mobPos.y);
      
      noStroke();
      S0.draw();
    }
    popStyle(); 
 }
 
 void pop(){
   
  //iteration = constrain(iteration, -6, 6); 
   
  ArrayList<square> newFrac = new ArrayList<square>();
  
  for(int j = 0; j < abs(iteration); j++){
    
    for(int i = newFrac.size()-1; i >= 0; i--){
      newFrac.remove(i);   
    }
    
    for(int i = 0; i < squares.size(); i++){
      square S0 = squares.get(i); 
      
      newFrac.add(new square(new PVector(S0.pos.x + seedPos(0, S0).x, S0.pos.y + seedPos(0, S0).y), S0.size/2));
      newFrac.add(new square(new PVector(S0.pos.x + seedPos(1, S0).x, S0.pos.y + seedPos(1, S0).y), S0.size/2));
      newFrac.add(new square(new PVector(S0.pos.x + seedPos(2, S0).x, S0.pos.y + seedPos(2, S0).y), S0.size/2));
      newFrac.add(new square(new PVector(S0.pos.x + seedPos(3, S0).x, S0.pos.y + seedPos(3, S0).y), S0.size/2));
      //newFrac.add(new square(new PVector(S0.pos.x + seedPos(4, S0).x*1.5, S0.pos.y + seedPos(4, S0).y*1.5), S0.size/4));
    } 
    
   for(int i = squares.size()-1; i >= 0; i--){
    squares.remove(i);   
   }
   
   for(int i = 0; i < newFrac.size(); i++){
    squares.add(newFrac.get(i));  
   }
  }
  
  //println(squares.size()); 
 }

}

void mousePressed(){
  for(Vertex v: boxes){
   v.pressed();  
  }
}

void mouseDragged(){
  for(Vertex v: boxes){
   v.dragged();
   
   //float x = constrain(int(v.position.x),  int(width/2 - 200 + v.size.x/2), int(width/2 + 200 - v.size.x/2));
   //float y = constrain(int(v.position.y), int(height/2 - 200 + v.size.y/2), int(height/2 + 200 - v.size.y/2));
   
   v.position = v.position; //new PVector(x, y);
   
   test.initialize(); 
   test.pop(); 
  }
}

void mouseReleased(){
  for(Vertex v: boxes){
   v.released();  
  }
}

void keyPressed(){
 if(keyCode == UP){
  count++; 
  test.iteration = int(constrain(count, -7, 7));
  test.initialize(); 
  test.pop();
 }
 
 if(keyCode == DOWN){
  count--; 
  test.iteration = int(constrain(count, -6, 6));
  test.initialize(); 
  test.pop();
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
    noStroke(); 
    
    if(mouseX > position.x - (.5 * size.x) && mouseX < position.x + (.5 * size.x) && 
       mouseY > position.y - (.5 * size.y) && mouseY < position.y + (.5 * size.y)) {
          
      overVertex = true;

      if(!locked){ 
        //stroke(153);
        fill(255, 153);
      }
      
    }else{ // Colors and Shit for Unselected
      //stroke(0);
      fill(255, 153);
      overVertex = false;
    }

    if(type == "Vertex") {
      noFill(); 
      stroke(255, 153, 153); 
      strokeWeight(2); 
      rect(position.x, position.y, size.x, size.y);
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
    textSize(12);
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
