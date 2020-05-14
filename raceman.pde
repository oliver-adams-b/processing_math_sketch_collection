IntList sequence = new IntList(); 
//int count = 0; 
int S = 1; 

void setup(){
  size(600, 600); 
  background(255); 
  
  sequence.append(S); 
}


void draw(){
 //count++;
 background(255); 
 
 fill(0); 
 int max = 0;
 int swap = 0; 
 
 for(int count = 0; count < 100; count++){
  for(int i = 0; i < sequence.size(); i++){
   int k = sequence.get(i); 
   
   if(k == S - count){S -= count; sequence.append(S);break;}
  }
 }
 
 
  
  for(int i = 0; i < sequence.size(); i++){
   int k = sequence.get(i); 
    
   
   float x = map(i, 0, sequence.size(), width/4, 3*width/4); 
   float y = map(k, 0, max, 0, 200); 
   
   ellipse(x, height/2 + y, 4, 4); 
 }
 
 
 
 
}