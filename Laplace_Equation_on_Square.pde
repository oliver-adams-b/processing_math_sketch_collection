import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
PeasyCam cam; 

int res = 100; 
float[][] curSe = new float[res][res];
float[][] calSe = new float[res][res]; 

float[][] BC = new float[res][res];

void setup(){
 cam = new PeasyCam(this, 600);
 size(500, 500, P3D); 
 background(255);
 
 for(int i = 0; i < res; i++){ // random bounary conditions
   BC[i][0] = 0;//map(i, 0, res, 1, -1);
   BC[0][i] = 0;//map(i, 0, res, 1, -1);
   BC[i][res-1] = pow(map(i, 0, res, 0, 9)/9,2);
   BC[res-1][i] = map(i, 0, res, 0, 3)/3;
   
   /*
   BC[i][0] = random(-1, 1);
   BC[0][i] = random(-1, 1);
   BC[i][res-1] = random(-1,1); //-BC[i][0];
   BC[res-1][i] = random(-1,1); // -BC[0][i];
   */
 }
 
 for(int i = 0; i < res; i++){ // intitial interior conditions
   for(int j = 0; j < res; j++){
   curSe[i][j] = random(-1,1); 
   }
 }

 for(int i = 0; i < res; i++){ // assign BCS to current state
   curSe[i][0] = BC[i][0];
   curSe[0][i] = BC[0][i];
   curSe[i][res-1] = BC[i][res-1];
   curSe[res-1][i] = BC[res-1][i];
   
   calSe[i][0] = BC[i][0];
   calSe[0][i] = BC[0][i];
   calSe[i][res-1] = BC[i][res-1];
   calSe[res-1][i] = BC[res-1][i];
 }
 
 for(int i = 1; i < res-1; i++){
   for(int j = 1; j < res-1; j++){
     calSe[i][j] = (curSe[i+1][j+1] + curSe[i-1][j-1] 
                  + curSe[i-1][j+1] + curSe[i+1][j-1]
                  + curSe[i][j+1] + curSe[i][j-1]
                  + curSe[i-1][j] + curSe[i+1][j])/4;
   }
 }

 
}

void draw(){
 background(255); 
 //noLoop(); 
 pushStyle(); 
 colorMode(HSB, 100); 
 
 for(int i = 0; i < res; i++){ // display current state
   for(int j = 0; j < res; j+=2){
     float dx = map(i, 0, res, -100, 100); 
     float dy = map(j, 0, res, -50, 5); 
     float u_ij = curSe[i][j];
     
     
         stroke(map(u_ij, -1, 1, 0, 100), 100, 100);
         strokeWeight(7); 
         point(dx, dy,map(u_ij, -1, 1, -50, 50));
      
    
    print( u_ij + ", "); 
   }
   println(); 
 }
 popStyle(); 
 //delay(100);
 //ellipse(mouseX, mouseY, 10, 10); 
 
 for(int i = 1; i < res-1; i++){
   for(int j = 1; j < res-1; j++){
     calSe[i][j] = (curSe[i+1][j+1] + curSe[i-1][j-1] + curSe[i-1][j+1] + curSe[i+1][j-1])/4;
   }
 }
 
 for(int i = 1; i < res-1; i++){
   for(int j = 1; j < res-1; j++){
     curSe[i][j] = calSe[i][j];
   }
 }
 
 line(200, 0, 0, -200, 0, 0); 
 line(0, 200, 0, 0, -200, 0); 
 line(0, 0, 200, 0, 0, -200); 

 
 //println(curSe); 
}