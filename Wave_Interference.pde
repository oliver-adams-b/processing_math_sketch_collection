waveParticle WP0 = new waveParticle(); 
waveParticle WP1 = new waveParticle(); 
waveParticle WP2 = new waveParticle(); 

float a = 700, da = 1; 

void setup(){
 fullScreen();
 background(255); 
 
 WP0.waveFronts = 10; 
 WP0.antinodes = true; 
 WP0.drawn = true; 
 
 WP1.waveFronts = 10;
 WP1.antinodes = true; 
 WP1.drawn = true; 
  
 WP2.waveFronts = 10;
 WP2.antinodes = true; 
 WP2.drawn = true;
}

void draw(){
 if(!mousePressed){
  background(255); 
  WP0.drawWave(); 
  WP1.drawWave(); 
  WP2.drawWave();
 }  

 //float d = map(mouseX, 100, width - 100, 0, 20);
 //d = floor(d); 
 //d *= ((WP0.maxRadius/8)/WP0.waveFronts);
  
 float d = map(mouseX, 100, width - 100, 0, 300); 
 
 
 WP1.position = new PVector(width/2 - d, height/2 - 100); 
 WP0.position = new PVector(width/2 + d, height/2 - 100);
 WP2.position = new PVector(width/2, (height/2) + (sqrt(3) * d) - 100); 
  
 plotIntersections(WP0, WP1, true);
 plotIntersections(WP0, WP2, true); 
 plotIntersections(WP2, WP1, true); 
  
 WP0.updateWave();
 WP1.updateWave(); 
 WP2.updateWave();
}

class waveParticle{
 PVector position; 
 
 float frequency; 
 float waveLength;
 float phase; 
 float maxRadius; 
 
 int waveFronts; 
 
 boolean antinodes;
 boolean drawn; 

 private float c; 
 
  waveParticle(){
   position = new PVector(width/2, height/2); 
   frequency = 1;
   waveLength = 1;
   c = 2; 
   
   waveFronts =  20;
   maxRadius = 800; 
   
   antinodes = false;
   drawn = true; 
  } 
  
  void drawWave(){
    pushStyle(); 
    
    
      for(int i = 0; i < waveFronts; i++){
        float radius = map(i, 0, waveFronts, phase, maxRadius + phase);  
        float alpha = map(radius % maxRadius, 0, maxRadius, 140, 0); 
        
        
        if(drawn){
          noFill(); 
          strokeWeight(2);
          stroke(0, 0, 0, alpha); 
          ellipse(position.x, position.y, radius % maxRadius, radius % maxRadius);
        
        if(antinodes){
           float mapd = ((maxRadius/2)/waveFronts); 
          
           alpha = map((radius + mapd) % maxRadius, 0, maxRadius, 140, 20); 
           stroke(255, 30, 30, alpha); 
           ellipse(position.x, position.y, (radius + mapd) % (maxRadius), 
                                           (radius + mapd) % (maxRadius));
        }
       }
      }
    
    popStyle(); 
  }
  
  void updateWave(){
    phase += c; 
  }
  
  void propagate(){
    updateWave(); 
    drawWave(); 
  }
  
}

void plotIntersections(waveParticle W0, waveParticle W1, boolean antinodes){
 PVector P0, P1, P2, P3; 
 
 float r0, r1; 
 float d0 = ((W0.maxRadius/2)/W0.waveFronts)/2; 
 float d1 = ((W1.maxRadius/2)/W1.waveFronts)/2; 
 float size = 3; 
 
 for(int i0 = 0; i0 < W0.waveFronts; i0++){
  for(int i1 = 0; i1 < W1.waveFronts; i1++){
    
    r0 = map(i0, 0, W0.waveFronts, W0.phase/2, (W0.maxRadius/2) + (W0.phase/2));
    r1 = map(i1, 0, W1.waveFronts, W1.phase/2, (W1.maxRadius/2) + (W1.phase/2));  
    
    P1 = findIntersection(W0.position, W1.position, r0 % (W0.maxRadius /2), r1 % (W1.maxRadius /2)); 
    P0 = findIntersection(W1.position, W0.position, r1 % (W1.maxRadius /2), r0 % (W0.maxRadius /2)); 
    
    stroke(0); 
    ellipse(P0.x, P0.y, size, size); 
    ellipse(P1.x, P1.y, size, size); 
    
    if(antinodes == true){
      P2 = findIntersection(W0.position, W1.position, (r0 + d0) % (W0.maxRadius /2), 
                                                      (r1) % (W1.maxRadius /2));
      P3 = findIntersection(W1.position, W0.position, (r1 + d1) % (W1.maxRadius /2), 
                                                      (r0) % (W0.maxRadius /2));

      stroke(255, 30, 30); 
      ellipse(P2.x, P2.y, size, size); 
      ellipse(P3.x, P3.y, size, size); 
    }
  }
 }
}

PVector findIntersection(PVector P0, PVector P1, float R0, float R1) {

  float d = dist(P0.x, P0.y, P1.x, P1.y); 
  float a = (pow(R0, 2) - pow(R1, 2) + pow(d, 2)) / (2 * d); 
  float h = sqrt(pow(R0, 2) - pow(a, 2));

  PVector z = (PVector.sub(P1, P0));
  PVector q = new PVector(z.x * (a / d), z.y * (a / d));
  PVector P2 = PVector.add(P0, q);
   
  PVector P3 = new PVector(P2.x + h * (P1.y - P0.y) / (d), P2.y - h * (P1.x - P0.x) / (d));
      
  return P3;
}