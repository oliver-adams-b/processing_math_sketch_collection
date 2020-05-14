Field F0;

void setup(){
  
 //fullScreen(); 
 size(600, 600); 
 background(255);
  
 F0 = new Field(); 
 F0.position = new PVector(width/2, height/2);
 F0.region = new PVector(TWO_PI, TWO_PI); 
 F0.res = new PVector(50, 50);
 
 F0.initialize();
}

void draw(){
 background(255);  
 
 F0.initialize();
 F0.display(); 
}

class Field{
  
 arrow[][] vectors;
 PVector position;
 PVector region;
 PVector res; 

 Field(){
   position = new PVector(0, 0); 
   region = new PVector(0, 0); 
   res = new PVector(0, 0);
  
   vectors = new arrow[int(res.x)][int(res.y)];
 }

 void initialize(){
    vectors = new arrow[int(res.x)][int(res.y)];
   
    fill(255); 
    float x, y;
   
    for(int i = 0; i < res.x; i++){
      for(int j = 0; j < res.y; j++){
        
        y = map(j, 0, res.y, -region.x, region.x); 
        x = map(i, 0, res.x, -region.y, region.y);
        
        arrow P0 = new arrow(x, y);
        P0 = F(P0); 
        
        vectors[i][j] = P0; 
     }
   }
 }

void display(){
 pushStyle(); 
  
 colorMode(HSB, 100); 
 float x, y, h, s, b; 
 arrow P0 = new arrow(); 
 arrow P1 = new arrow(); 
 
 strokeWeight(2); 
  
 for(int i = 0; i < res.x; i++){
      for(int j = 0; j < res.y; j++){
        
        P0.pos = new PVector(map(i, 0, res.x, 0, width), map(j, 0, res.y, 0, height)); 
        P1 = vectors[i][j]; 
        
        
        h = P1.Color.x;  
        s = P1.Color.y; 
        b = P1.Color.z; 
       
        stroke(h, s, b); 
        line(P0.pos.x, P0.pos.y, P0.pos.x - P1.pos.x, P0.pos.y - P1.pos.y); 
      }
   } 
   
  popStyle(); 
}

 arrow F(arrow P0){
   arrow P1 = new arrow(); 
   float x = P0.pos.x; 
   float y = P0.pos.y;
   
   float a = map(mouseX, 0, width, 0, TWO_PI);
   float b = map(mouseY, 0, height, 0, TWO_PI);
   
   float theta = atan(y/x);
   float rad = sqrt(pow(x,2)+pow(y,2));
   y = -cos(theta)/pow(rad, 3); 
   x = -sin(theta)/pow(rad, 3);
   
   P1.pos.x = x; 
   P1.pos.y = y; 
   
   // ****COLOR MANIPULATION
   //P1.color = new PVector(x, y, 100); 
   
   P1.pos.normalize(); 
   P1.pos.mult(8); 
   
   return P1; 
 }

}

class arrow{
 PVector pos; 
 PVector Color; 
  
 arrow(){
  pos = new PVector(0, 0, 0); 
  Color = new PVector(0, 0, 0); 
 }
  
 arrow(float x, float y){
  pos = new PVector(x, y);
  Color = new PVector(x, y, 100); 
 }
  
}