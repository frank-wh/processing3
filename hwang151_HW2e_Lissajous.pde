/*********************************************************
 author: Hao Wang
 reference:  https://www.openprocessing.org/sketch/26608/
   but I didn't use the method, I shortened the code
*********************************************************/
void setup(){
  size(800,800);
}
float x, y;
float a=1,b=1;
void draw(){
  translate(width/2,height/2);
  scale(width/2.2,height/2.2);//full scale is width/2, height/2
  strokeWeight(0);
  for(float t=0;t<2*PI;t+=0.01){
    x=cos(13*t);
    y=cos(15*t);
    line(x,y,a,b);
    a=x;
    b=y;
  }
}
