void setup(){
 background(153);
 size(600, 600, P3D);
 strokeWeight(2);
 textSize(14);
}

void draw(){
  background(153);
  
  
  
   double[] anotherSequence = extFib(1, 12);
   double[] otherSequence = extFib(1.5, 12);
   double[] testSequence = extFib(2, 12);
   double[] piSequence = extFib(1.61803398875, 12);
   
   double one = sum(anotherSequence);
   double one_point_five = sum(otherSequence);
   double two = sum(testSequence);
   double pi = sum(piSequence);

   for(int i = 0; i < testSequence.length; i++){
     if(i%2 == 1)fill(0);
     if(i%2 == 0)fill(100);
     text( i + ".  " + testSequence[i], 310, (13 * i) + 90); 
   }
   
   for(int i = 0; i < otherSequence.length; i++){
     if(i%2 == 1)fill(0);
     if(i%2 == 0)fill(100);
     text( i + ".  " + otherSequence[i], 160, (13 * i) + 90); 
   }
   
   for(int i = 0; i < anotherSequence.length; i++){
     if(i%2 == 1)fill(0);
     if(i%2 == 0)fill(100);
     text( i + ".  " + anotherSequence[i], 10, (13 * i) + 90); 
   }
   
   for(int i = 0; i < piSequence.length; i++){
     if(i%2 == 1)fill(0);
     if(i%2 == 0)fill(100);
     text( i + ".  " + piSequence[i], 460, (13 * i) + 90); 
   }
   
   fill(0);
   text("Initial Values of:", 10, 40);
   
   fill(0);
   text("1", 20, 70);
   text("1.5", 170, 70);
   text("2", 320, 70);
   text("Golden Ratio", 470, 70);
   
   text("Sum: " + one, 10, 540);
   text("Sum: " + one_point_five, 160, 540);
   text("Sum: " + two, 310, 540);
   text("Sum: " + pi, 460, 540);
}

double[] extFib(double initialVal, int iterations){
 double[] sequence = new double[iterations];
 sequence[0] = initialVal;
 sequence[1] = initialVal + 0;
 
 for(int i = 2; i < iterations; i++){
    sequence[i] = sequence[i - 1] + sequence[i - 2];
 }
 
  return sequence;
}

double sum(double[] sequence){
 double sum = 0;
 for(int i = 0; i < sequence.length; i ++){
   sum += sequence[i];
 }
 
 return sum;
}