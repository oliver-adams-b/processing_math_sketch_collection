int n = 5; 
Vertex[] A = new Vertex[n]; 
frac F0 = new frac(); 
struc SG = new struc(); 

gridWork G = new gridWork(); 


void setup(){
 background(255); 
 size(1000, 1000); 
  
 SG.seed = new PVector[A.length]; 
 
 for(int i = 0; i < A.length; i++){
  A[i] = new Vertex(); 
  A[i].type = "Vertex"; 
  A[i].MoveType = "Normal"; 
  A[i].size = new PVector(20, 20);
  A[i].position = new PVector(map(i, 0, A.length-1, width/2 - 250, width/2 + 250), height/2);  
 }


 
 
 G.C0 = new PVector(width/2, height/2); 
 G.size = width/2; 
 G.type = "Polar"; 
 G.n = 20; 
 
 F0.I = 3;
}

// ********************************************* DRAW
void draw(){
 background(255); 
 
 for(int i = 0; i < A.length; i++){
   strokeWeight(2); 
   //A[i].run(); 
   SG.seed[i] = A[i].position;
 }
 
 
 
 PVector midpoint = new PVector((A[0].position.x + A[A.length-1].position.x)/2, (A[0].position.y + A[A.length-1].position.y)/2);
 float D0 = dist(A[0].position.x, A[0].position.y, A[A.length-1].position.x, A[A.length-1].position.y); 
 
 pushStyle(); 
   noFill(); 
   stroke(1); 
   strokeWeight(1);
   //ellipse(midpoint.x, midpoint.y, D0, D0); 
   
   G.disp(); 
 popStyle(); 

 //if(keyPressed) F0.I++; 
 SG.first = A[0].position; 
 SG.last = A[A.length-1].position; 
 SG.init();  
 F0.S0 = SG; 
 F0.init(); 
 F0.pop();
 F0.disp(); 
 
 for(int i = 0; i < A.length; i++){
   strokeWeight(2); 
   A[i].run(); 
   SG.seed[i] = A[i].position;
 }
}

void keyPressed()
{
  if(key == CODED)
  {
    if (keyCode == UP)
    {
      if (F0.I < 9)  F0.I++ ;
    }
    if(keyCode == DOWN)
    {
      if (F0.I >= 0)  F0.I-- ;
    }
    
  }
}

// ********************************************* STRUC
class struc{
 PVector first; 
 PVector last; 
 PVector[] seed;
 PVector[] points;
 
 struc(){
   first = new PVector(); 
   last = new PVector(); 
   seed = new PVector[0];
   points = new PVector[seed.length];
   
 }
 
 void init(){
  if(seed.length > 0){
    points = new PVector[seed.length];
    
    float r0 = dist(seed[0].x, seed[0].y, seed[seed.length - 1].x, seed[seed.length - 1].y);
    float delta = atan2(seed[seed.length-1].y - seed[0].y, seed[seed.length-1].x - seed[0].x); 
    float r1 = dist(last.x, last.y, first.x, first.y); 
    float phi = atan2((last.y - first.y), (last.x - first.x));
    
    for(int i = 0; i < seed.length; i++){
     float r2 = dist(seed[0].x, seed[0].y, seed[i].x, seed[i].y); 
     float theta = atan2((seed[i].y - seed[0].y), (seed[i].x - seed[0].x)); 
     
     PVector P1 = new PVector(first.x + (r2)*(r1/r0)*cos(theta + phi - delta), first.y + (r2)*(r1/r0)*sin(theta + phi - delta)); 
     
     points[i] = P1;  
    }
    
    
    points[0] = first;
    points[points.length - 1] = last; 
  }
 }
 
 void disp(){
   
   strokeWeight(2); 
   stroke(0, 153);
   
   for(int i = 0; i < points.length - 1 ; i++){
    PVector P1 = points[i]; 
    PVector P0 = points[i + 1]; 
     
    line(P1.x, P1.y, P0.x, P0.y); 
   }
 }
}


// ********************************************* STRUC
class frac {
 ArrayList<struc> strucs; 
 struc S0; 
 int I; 
 
 frac(){
   I = 0; 
   S0 = new struc(); 
   strucs = new ArrayList<struc>(); 
 }
 
 void init(){
  strucs.clear(); 
  strucs.add(S0);  
 }
 
 void disp(){
  for(struc S : strucs){
   S.disp();  
  }
 }
 
 void pop(){  
  for(int N = 0; N < I; N++) {
     ArrayList<struc> temp = new ArrayList<struc>();
     temp.clear(); 
     
    for(int j = 0; j <= strucs.size()-1; j++){
     struc S = strucs.get(j); 
     
     for(int i = 0; i < S.points.length - 1; i++){
       
      PVector P1 = S.points[i]; 
      PVector P2 = S.points[(i + 1) % S.points.length]; 
      
      struc S1 = new struc(); 
      S1.first = P1; 
      S1.last = P2; 
      S1.seed = S.points; 
      S1.init();
      
      temp.add(S1); 
      
     }
    }
    
     strucs.clear();
     strucs = temp;  
  }
 }
 
 
}

// ********************************************* MOUSE
void mousePressed(){
  for(Vertex v: A){
   v.pressed();  
  }
}

void mouseDragged(){
  for(Vertex v: A){
   v.dragged();  
  }
}

void mouseReleased(){
  for(Vertex v: A){
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

    position = new PVector(random(width/2 - 100, width/2 + 100), random(height/2 - 100, height/2 + 200));
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
      fill(107, 193, 218);
      overVertex = false;
    }

    if(type == "Vertex") {
      if(!hidden) ellipse(position.x, position.y, size.x, size.y);
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


class gridWork{
 PVector C0; 
 float size; 
 int n; 
 String type; 
  
 gridWork(){
  C0 = new PVector(); 
  size = 0; 
  n = 0; 
  
  type = "Cartesian"; 
 }
  
 void disp(){
  //if(type == "Cartesian"){
   stroke(183); 
   strokeWeight(1); 
   
   for(int i = 0; i < n + 1; i++){
    float x1 = map(i, 0, n, -size, size);
    
    line(C0.x - size, C0.y - x1, C0.x + size -1, C0.y - x1); 
    line(C0.x - x1, C0.y - size, C0.x - x1, C0.y + size -1); 
   }
  //}
  
  
  //if(type == "Polar"){
   for(int i = 0; i < n+1; i++){
     float rad = map(i, 0, n, 0, size); 
     
     ellipse(C0.x, C0.y, rad*4, rad*4); 
   }
  //}
}
}