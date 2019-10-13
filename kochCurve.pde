/***********************************
         author: Hao Wang
***********************************/

void setup(){
  size(800,800);
  frameRate(1);
}

void koch(float x1,float y1, float x2,float y2, float x3,float y3, int level){
  if(level==0){
    triangle(x1,y1,x2,y2,x3,y3);
    //fill(0);
    return;
  }
  triangle(x1,y1,x2,y2,x3,y3);
  
  float xa=(2*x1+x2)/3; 
  float ya=(2*y1+y2)/3; 
  float xb=(x1+2*x2)/3; 
  float yb=(y1+2*y2)/3; 
  float xc=x1; 
  float yc=(y1+2*y2)/3;
  
  float xd=(2*x2+x3)/3; 
  float yd=(2*y2+y3)/3; 
  float xe=(x2+2*x3)/3; 
  float ye=(y2+2*y3)/3; 
  float xf=x3; 
  float yf=(2*y2+y3)/3;
  
  float xg=(2*x1+x3)/3; 
  float yg=(2*y1+y3)/3; 
  float xh=(x1+2*x3)/3; 
  float yh=(y1+2*y3)/3; 
  float xi=x2;
  float yi=2*yg-ya;
  
  koch(xc,yc, xa,ya, xb,yb, level-1);
  koch(xd,yd, xe,ye, xf,yf, level-1);
  koch(xg,yg, xi,yi, xh,yh, level-1);
  
  koch(x1,y1, xa,ya, xg,yg, level-1);
  koch(xb,yb, x2,y2, xd,yd, level-1);
  koch(xh,yh, xe,ye, x3,y3, level-1);
  
}

int level=0;
void draw(){
  koch(width/2-sqrt(3)*height/5,7*height/10,   
       width/2,height/10, 
       width/2+sqrt(3)*height/5,7*height/10,
       level);
  level++;
  if(level>7){
    level=0;
  }
}
