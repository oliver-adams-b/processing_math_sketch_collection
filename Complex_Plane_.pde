 float a = 2;
 float rMax = a* PI,
      rMin = -a* PI, 
      iMax = a* PI, 
      iMin = -a* PI;
      
int count = 0; 
int res = 2; 

float theta = 0; 
float dtheta = .05; 

complex c = new complex(0, -1.2); 
      
 void setup(){
  size(700, 700);
  background(255); 
  
 }
 
 void draw(){
  background(255); 
  
  theta += dtheta; 
  float x = 50*cos(2*theta) + width/2; 
  float y = 50*sin(4*theta) + height/2; 
  
  //c = new complex(map(x, 0, 100, 
  //c = new complex(map(x, 0, width, rMin/2, rMax/2), map(y, 0, height, iMin/2, iMax/2)); 
  
  drawTestOperation(count++);
  
  ellipse(width/2, height/2, 4, 4); 
  //ellipse(x, y, 4, 4); 
 }
 
////*****************************************************************88
 void drawTestOperation(int count){
 pushStyle(); 
 colorMode(HSB, 100);
 
 complex maxZ = new complex(rMax, iMax);
 
 float mag, maxMag = magnitude(maxZ);  
 
   for(float i = 0; i < width; i += res){
    for(float j = 0; j < height; j += res){
      float mapr = map(i, 0, width, rMin, rMax); 
      float mapi = map(j, 0, height, iMin, iMax);
       
      complex Z0 = new complex(mapr, mapi); 
      
      for(float a = 0; a < count; a++){
       //Z0 = tanh(ln(Z0)); 
       //Z0 = e(Z0); 
       Z0 = ln(tanh(Z0)); 
       Z0 = coth(Z0); 
       //Z0 = sum(Z0, c); 
       //Z0 = coth(ln((Z0))); 
       
       //Z0 = ln(sech(Z0)); 
      }
      
      mag = magnitude(Z0); 
      
      noStroke(); 
      fill(map(mag, 0, maxMag, 0, 30), map(mag, 0, maxMag, 100, 100),
           map(mag, 0, maxMag, 50, 250), 100); 
      
      rect(i, j, res + .1, res + .1); 
    }
   }
 
 popStyle(); 
}

//***************************************************************Miscellaneous Functions

PVector circle(PVector P0, float radius, float theta){
 PVector P1 = new PVector(P0.x + radius*cos(3*theta), P0.y + radius*sin(5*theta)); 
 return P1; 
}



//***************************************************************Complex Number Class

class complex{
  float real; 
  float imag; 
  
  complex(float a, float b){
    real = a; 
    imag = b; 
  }
  
  complex(){
   real = 0; 
   imag = 0; 
  }
}

//***************************************************************Complex Number Functions

complex square(complex Z0){
 complex Z1 = new complex((pow(Z0.real, 2) - pow(Z0.imag, 2)), (2*Z0.real*Z0.imag)); 
 return  Z1; 
}

complex cube(complex Z0){
 complex Z1 = new complex(pow(Z0.real, 3) - (3*Z0.real*pow(Z0.imag, 2)), 
                          (3*pow(Z0.real, 2)*Z0.imag - pow(Z0.imag, 3))); 
 return Z1; 
}

complex sum(complex Z0, complex Z1){
  complex Z2 = new complex((Z0.real + Z1.real), (Z1.imag + Z0.imag)); 
  return Z2; 
}

complex subtract(complex Z0, complex Z1){
  complex Z2 = new complex((Z0.real - Z1.real), (Z1.imag - Z0.imag)); 
  return Z2; 
}

float magnitude(complex Z0){ 
 float mag = sqrt(abs(pow(Z0.real, 2) + pow(Z0.imag, 2))); 
 
 if(mag > 1000000) return 1000000; 
 if(mag < 1000000) return mag; 
 return 0;
}

complex divide(complex Z0, complex Z1){
  complex Z2 = new complex();
  
  Z2.real = (1 / (pow(Z1.real, 2) + pow(Z1.imag, 2)))*((Z0.real* Z1.real) - (Z0.imag*Z1.imag));
  Z2.imag = (1 / (pow(Z1.real, 2) + pow(Z1.imag, 2)))*((Z0.imag* Z1.real) + (Z0.real*Z1.imag));
  return Z2; 
}

complex divide(complex Z0, float a){
 complex Z1 = new complex(); 
 
 Z1.real = Z0.real / a; 
 Z1.imag = Z0.imag / a; 
 
 return Z1; 
}

complex multiply(complex Z0, float a){
 complex Z1 = new complex(); 
 
 Z1.real = Z0.real * a; 
 Z1.imag = Z0.imag * a; 
 
 return Z1; 
}

complex multiply(float a, complex Z0){
 complex Z1 = new complex(); 
 
 Z1.real = Z0.real * a; 
 Z1.imag = Z0.imag * a; 
 
 return Z1; 
}

complex conjugate(complex Z0){
 complex Z1 = new complex(); 
 
 Z1 = new complex(Z0.real, Z0.imag * -1); 
 return Z1; 
}

complex squareroot(complex Z0){
 complex Z1 = new complex(); 
 
 Z1.real = sqrt(Z0.real) / (sqrt(1 - .25 * pow(Z0.imag, 2))); 
 Z1.imag = Z0.imag*(sqrt(1 - .25 * pow(Z0.imag, 2)));
 
 return Z1; 
}

complex reciprocal(complex Z0){
 complex Z1 = new complex(); 
 
 Z1 = divide(new complex(1, 0), Z0); 
 return Z1; 
}

float arg(complex Z0){
 float theta = 0; 
 
 if(Z0.real > 0) theta = atan(Z0.imag / Z0.real); 
 else if(Z0.real < 0 && Z0.imag >= 0) theta = atan(Z0.imag / Z0.real) + PI; 
 else if(Z0.real < 0 && Z0.imag < 0) theta = atan(Z0.imag / Z0.real) - PI;
 else if(Z0.real == 0 && Z0.imag > 0) theta = PI/2; 
 else if(Z0.real == 0 && Z0.imag < 0) theta = -PI/2; 
 
 return theta; 
}

complex e(complex Z0){
 complex Z1 = new complex();
 
 Z1.imag = exp(Z0.real)*sin(Z0.imag); 
 Z1.real = exp(Z0.real)*cos(Z0.imag); 
 
 return Z1; 
}

complex ln(complex Z0){
 complex Z1 = new complex(); 
 
 Z1.real = log(sqrt(pow(Z0.real, 2) + pow(Z0.imag, 2))); 
 Z1.imag = atan2(Z0.imag, Z0.real); 
 
 return Z1; 
}

complex power(complex Z0, float a){ // FIX ME 
  complex Z1 = new complex(); 
  
  Z1.real = pow(magnitude(Z0), a)*cos(arg(Z0)*a);
  Z1.imag = pow(magnitude(Z0), a)*sin(arg(Z0)*a); 
  return Z1; 
}



//***************************************************************Complex Trig Functions

complex cosine(complex Z0){
 complex Z1 = new complex(Z0.real, Z0.imag); 
 
 Z1.real = 1 - (1/2)*(pow(Z0.real, 2) - pow(Z0.imag, 2)) + (1/24)*(pow(Z0.real, 4) - 6*pow(Z0.real, 2)*pow(Z0.imag, 2) + pow(Z0.imag, 4)); 
 Z1.imag = -1*(Z0.real*Z0.imag) + (1/24)*(4*pow(Z0.real, 3)*Z0.imag - 4*Z0.real*pow(Z0.imag, 3)); 
 
 return Z1;  
}

complex sine(complex Z0){
 complex Z1 = new complex(); 
 
 Z1.real = Z0.real - (1/6)*(pow(Z0.real, 3) - 3*Z0.real*Z1.imag) + (1/120)*(pow(Z0.real, 5) - 10*pow(Z0.real, 3)*pow(Z0.real, 2) + 5*Z0.real*pow(Z0.imag, 4));
 Z1.imag = Z0.imag - (1/6)*(3*pow(Z0.real, 3)*Z0.imag - pow(Z0.imag, 3)) + (1/120)*(5*pow(Z0.real, 4)*Z0.imag - 10*pow(Z0.real, 2)*pow(Z0.imag, 3) + pow(Z0.imag, 5));
 
 return Z1;  
}

complex tangent(complex Z0){
 complex Z1 = new complex(Z0.real, Z0.imag); 
 
 Z1 = divide(sine(Z0), cosine(Z0));
 return Z1; 
}

complex cotangent(complex Z0){
 complex Z1 = new complex(Z0.real, Z0.imag); 
 
 Z1 = divide(cosine(Z0), sine(Z0));
 return Z1; 
}

complex secant(complex Z0){
  complex Z1 = new complex(); 
  
  Z1 = divide(new complex(1, 0), cosine(Z0)); 
  return Z1; 
}

complex cosecant(complex Z0){
  complex Z1 = new complex(); 
  
  Z1 = divide(new complex(1, 0), sine(Z0)); 
  return Z1; 
}

//***************************************************************Complex Hyperbolic Trig Functions

complex cosh(complex Z0){
  complex Z1 = new complex(); 
  
  Z1 = multiply(sum(e(Z0), e(multiply(Z0, -1))), .5); 
  return Z1; 
}

complex sinh(complex Z0){
  complex Z1 = new complex(); 
  
  Z1 = multiply(subtract(e(Z0), e(multiply(Z0, -1))), .5); 
  return Z1; 
}

complex tanh(complex Z0){
 complex Z1 = new complex(); 
 
 Z1 = divide(sinh(Z0), cosh(Z0)); 
 return Z1; 
}

complex sech(complex Z0){
  complex Z1 = new complex(); 
  
  Z1 = divide(conjugate(cosh(Z0)), pow(Z0.real, 2) + pow(Z0.imag, 2));  
  return Z1; 
}

complex csch(complex Z0){
  complex Z1 = new complex(); 
  
  Z1 = divide(conjugate(sinh(Z0)), pow(Z0.real, 2) + pow(Z0.imag, 2));  
  return Z1; 
}

complex coth(complex Z0){
 complex Z1 = new complex(); 
 
 Z1 = divide(cosh(Z0), sinh(Z0)); 
 return Z1; 
}