struc S0 = new struc(); 
frac F0 = new frac(); 

float count = 0; 

void setup(){
 //fullScreen();
 size(800, 800); 
 //background(255); 
  
 S0.a = new PVector(width/2 + 250, height/2 + 250); 
 S0.b = new PVector(width/2 - 250, height/2 + 250 );  
 S0.init();
  
 F0.S0 = S0;
 F0.init();
 F0.pop();
}

void draw(){
background(255); 

 S0.n = int(map(mouseY, 10, height, 2, 2)); 
 S0.init(); 
  
 F0.S0 = S0;
 F0.I = 8; 
 F0.init();
 F0.pop();
  
 F0.disp(); 
  
 if(mousePressed == true) count = 0; 
}

class struc{
 PVector a; 
 PVector b; 
 PVector[] points; 
 int n; 
 struc(){
   a = new PVector(); 
   b = new PVector();
   n = 0;
   points = new PVector[0]; 
 }

 void init(){
  points = new PVector[n+2]; 
  PVector midPoint = new PVector((a.x + b.x)/2, (a.y + b.y)/2);
  float rad = dist(a.x, a.y, b.x, b.y)/2; 
  float phi = atan((a.y - b.y)/(a.x - b.x)); ///atan2((a.y - b.y), (a.x - b.x));
  
  float scalar = 1;//.8375; //map(mouseX, 0, width, 0, 2); 
  
  //println(scalar);
  
  for(int i = 0; i < points.length; i++){
   float theta = map(i, 0, points.length - 1, TWO_PI, PI); 
    
   points[i] = new PVector(rad*scalar*cos(theta+phi) + midPoint.x, rad*scalar*sin(theta+phi) + midPoint.y); 
  }
 }
 
 void disp(){
   strokeWeight(1); 
   stroke(0, 153);
   
   for(int i = 0; i < points.length - 1; i++){
    PVector P1 = points[i]; 
    PVector P0 = points[(i + 1) % points.length]; 
     
    line(P1.x, P1.y, P0.x, P0.y); 
   }
    
 }
}

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
  int N = 0; 
  
  while(N < I){
  ArrayList<struc> temp = new ArrayList<struc>(); 
  
  for(struc S : strucs){
   for(int i = 0; i < S.points.length - 1; i++){
    PVector P1 = S.points[i]; 
    PVector P2 = S.points[(i + 1) % S.points.length]; 
    
    struc S1 = new struc(); 
    S1.a = P1; 
    S1.b = P2; 
    S1.n = S.n; 
    S1.init();
    
    temp.add(S1);
    //temp.add(S); 
   }
  }
  
  strucs.clear();
  
  strucs = temp; 
  
   N++;
  }
 }
}

float atanb(float x, float y){
 float theta = 0; 
  
 if(x > 0) theta = atan2(y, x);
 if(x < 0 && y >= 0) theta = atan2(y, x) + PI; 
 if(x < 0 && y < 0) theta = atan2(y, x) - PI; 
 if(x == 0 && y > 0) theta = PI/2; 
 if(x == 0 && y > 0) theta = -PI/2; 
  
 return theta; 
}