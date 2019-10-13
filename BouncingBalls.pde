/**********************************
author: Hao Wang      date: 09/01
**********************************/
void setup(){
  size(600,600);
}
//we assume the two circle had the same mass, circle1 is earth, circle2 is mars
float earth_x=50,earth_y=300,   mars_x=350,mars_y=350;
// we assume that circle2(350,350) was stationary firstly
float dx1=10,dy1=0,   dx2=0,dy2=0;
float deltaX=(earth_x-mars_x>0)?(earth_x-mars_x):(mars_x-earth_x);
float deltaY=(earth_y-mars_y>0)?(earth_y-mars_y):(mars_y-earth_y);

float distanceSquare = deltaX*deltaX + deltaY*deltaY;
float distance=sqrt(distanceSquare);

float a,b;
float c;
float dX1;

void draw(){
  background(0);
  earth_x=earth_x+dx1;
  earth_y=earth_y+dy1;
  mars_x=mars_x+dx2;
  mars_y=mars_y+dy2;
  
  deltaX=(earth_x-mars_x>0)?(earth_x-mars_x):(mars_x-earth_x);
  deltaY=(earth_y-mars_y>0)?(earth_y-mars_y):(mars_y-earth_y);
  distanceSquare = deltaX*deltaX + deltaY*deltaY;
  distance=sqrt(distanceSquare);
  
  circle(earth_x,earth_y,100);
  circle(mars_x,mars_y,100);
  if(distance<=100){  //distance<=100 means a collision
    a=mars_x-earth_x;
    b=mars_y-earth_y;
    c=a*a+b*b;
    dX1=dx1; //<>//
    dx1=dx1*a*b/c; 
    dy1=-dx1*a*a/c;
    dx2=dX1-dx1;
    dy2=-dy1;
  }
  
  if(earth_x>=width-50){
    dx1=-dx1;
  }
  if(earth_x<=50){
    dx1=-dx1;
  }
  
  if(earth_y>=height-50){
    dy1=-dy1;
  }
  if(earth_y<=50){
    dy1=-dy1;
  }
  
  if(mars_x>=width-50){
    dx2=-dx2;
  }
  if(mars_x<=50){
    dx2=-dx2;
  }
  
  if(mars_y>=height-50){
    dy2=-dy2;
  }
  if(mars_y<=50){
    dy2=-dy2;
  }
}
