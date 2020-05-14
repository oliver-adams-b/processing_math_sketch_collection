int n = 601; 
int[][] SandBox = new int[n][n]; 
int rad = 1;
float scalar = 1; 

void setup(){
  background(255); 
  //size(1000, 1000); 
  fullScreen(); 
  
  for(int i = 0; i < n; i++){
    for(int j = 0; j < n; j++){
      SandBox[i][j] = 0;
    }
  }  
  
  SandBox[floor(n/2)][floor(n/2)] = int(pow(2,18));
}

void draw(){
  background(255);
 
  pileup(SandBox); 
  if(!contains(SandBox, 8)){ disp(SandBox); }
  pushStyle();
  fill(0); 
  if(contains(SandBox, 8)); //text(SandBox[floor(n/2)][floor(n/2)], width/2, height/2); 
  popStyle(); 
  
  for(int i = 0; i < SandBox.length; i++){
   if(SandBox[i][int(n/2)] > 0){ 
     rad = i; 
     break;
   } 
  }
  
  
  scalar = map(mouseX, 0, width, 1, 10); 
}

void pileup(int[][] A){
  int[][] C = new int[A.length][A.length]; 
  if(contains(A, 8)){
    for(int i = rad; i < A.length-rad; i++){
      for(int j = rad; j < A.length-rad; j++){
        if(A[i][j] >= 8){
                          
          
          A[i][j] -= 8; 
          C[i-1][j] += 1; 
          C[i][j-1] += 1;
          C[i+1][j] += 1;
          C[i][j+1] += 1;
          
          C[i-1][j-1] += 1; 
          C[i+1][j-1] += 1;
          C[i+1][j+1] += 1;
          C[i-1][j+1] += 1;
          
        }
      }
    }
   
    addify(A, C); 
    disp(A);
  }
}

void addify(int[][] A, int[][] B){  
  for(int i = 0; i < A.length; i++){
      for(int j = 0; j < A.length; j++){
        A[i][j] += B[i][j]; 
      }
  }
}

void scrub(int[][] A){
  
  for(int i = 0; i < A.length; i++){
      for(int j = 0; j < A.length; j++){
        A[i][j] = 0; 
      }
  } 
}

Boolean contains(int[][] A, int N){
  Boolean bool = false; 
  
  for(int i = rad; i < A.length-rad; i++){
      for(int j = rad; j < A.length-rad; j++){
        if(A[i][j] >= N) {bool = true;}
      }
  }
  
  return bool; 
}

void disp(int[][] A){
  
  pushStyle(); 
  
  textAlign(CENTER, CENTER); 
  textSize(20); 
  noStroke(); 
   
  
    for(int i = rad; i < A.length-rad; i++){
      for(int j = rad; j < A.length-rad; j++){
        float x = map(i, 0, n, width/2 - scalar*400, width/2 + scalar*400); 
        float y = map(j, 0, n, height/2 - scalar*400, height/2 + scalar*400); 
       
        fill(map(A[i][j], 0, 8, 255, 0), map(A[i][j], 0, 8, 255, 0), map(A[i][j], 0, 8, 255, 0)); 
        
        ellipse(x, y, scalar*2, scalar*2); 
        //text(A[i][j], x, y);
        
      }
    }
  popStyle(); 
  
}