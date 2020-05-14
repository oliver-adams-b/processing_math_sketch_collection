float theta = 0;  
float dtheta = .5; 
float H = 3; 
float dH = .001; 


void setup() {  
  background(231, 60, 82); 
  size(600, 600, P3D);
}

void draw() {
  background(231, 60, 82);
  noFill();
  
  lorenz$();
   
  
        
  line(0, 0, -60, 0, 0, 60);
  line(0, -60, 0, 0, 60, 0);
  line(-60, 0, 0, 60, 0, 0);
}

void lorenz(float h, float a, float b, float c, float x0, float y0, float z0){ 
  for(int i = 0; i <= 2500; i ++){
    pushMatrix();
    pushStyle();
    
    float x1, y1, z1; 
    
      x1 = x0 + h * a * (y0 - x0);
      y1 = y0 + h * (x0 * (b - z0) - y0); 
      z1 = z0 + h * (x0 * y0 - c * z0); 

      x0 = x1; 
      y0 = y1; 
      z0 = z1; 
      
      float Y = map(i, 0, 2500, 70, 153); 
      stroke(Y);
      strokeWeight(4);
      
      line(x0, y0, z0, x1, y1, z1); 
      
      translate(x0, y0, z0); 
      point(0, 0);
    
    popStyle();
    popMatrix();
   }
  
}

void rossler(float h, float a, float b, float c, float x0, float y0, float z0, Boolean D){
  
  if(D == false){
    for(int i = 0; i <= 2000; i ++){
      pushMatrix();
      pushStyle();
      
      float x1, y1, z1; 
      
        x1 = -y0 - (h * (z0));
        y1 = x0 + (h * a * y0); 
        z1 = b + (h * (z0 * (x0 - c))); 
        
        //line(x0, y0, z0, x1, y1, z1); 
        
        x0 = x1; 
        y0 = y1; 
        z0 = z1; 
        
        translate(x0, y0, z0); 
        strokeWeight(4);
        point(0, 0);
      
      popStyle();
      popMatrix();
     }
  }
}

void lorenz$(){
  float f = (map(mouseX, 0, width, 0, 50));
  float Q = (map(mouseY, 0, height, 0, 80));
  
  rotateY((-theta / 57.5) + radians(90));
    textSize(7);
    //text("F = " + f, 30, -30); 
  rotateY((theta / 57.5) + radians(90));
  
  float x0, y0, z0, x1, y1, z1;
  //float h = .14468335; 
  float h = .01;
  float a = Q; 
  float b = f; 
  float c = 4; 
  
  x0 = .1; 
  y0 = 0; 
  z0 = -30; 
  
  lorenz(h, a, b, c, x0, y0, z0); 
  lorenz(h, a, b, c, -x0, y0, z0);

  if( H < 0 || H > 6 ) dH = -dH; 
  H+= dH;
  theta += dtheta;
  float alpha = 60 * (sin(radians(theta)));
  
  camera(180 * (cos(radians(90 + alpha))), -40, 180 * (sin(radians(90 + alpha))), 
          0, 0, 0,
          0, 1, 0);
  
}

