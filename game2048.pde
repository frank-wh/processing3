/*
* author: Hao Wang
*/
int[][] b = new int[4][4], pp[] = new int[4][4][3]; // b: board   
int f = b.length, pad = 20, bs = 100; // bs: blocks
int score=0, aS, aL=10;
boolean dead = true;

void setup() {
  size(500,500); 
  restart();
  textFont(createFont("Times New Roman",40)); 
  noStroke();
}
void restart() { 
  b = new int[4][4]; 
  spawn();
  score = 0;
  dead = false;
}
void spawn() { 
  ArrayList<Integer> xs = new ArrayList<Integer>(), ys = new ArrayList<Integer>();
  for(int j = 0; j < f; j++){
    for(int i = 0; i < f; i++){
      for(int k = 0; k < 1 && b[j][i]==0; k++, xs.add(i), ys.add(j)){
      }
    }
  }
  int r = (int)random(xs.size());
  int y = ys.get(r);
  int x = xs.get(r);
  b[y][x] = random(-(pp[y][x][0]=-1))<0.9 ? 2 : 4;
}

void draw() {
  background(255); 
  rectt(0,0,width,height,10,color(150));
  fill(200);
  for(int j = 0; j < f; j++){
    for(int i = 0; i < f; i++){
      rect(pad+(pad+bs)*i, pad+(pad+bs)*j, bs, bs, 5);
    }
  }
  for(int j = 0 ; j < f; j++) {
    for(int i = 0 ; i < b[j].length; i++) {
      float fC = frameCount, xt = pad+(pad+bs)*i, yt = pad+(pad+bs)*j;
      float x = xt, y = yt, val = b[j][i], tm = (fC-aS)*1.0/aL;
      if(fC - aS < aL && pp[j][i][0] > 0) {
        int py = pad+(pad+bs)*pp[j][i][1], px = pad+(pad+bs)*pp[j][i][2];
        x = (x-px)*tm + px;
        y = (y-py)*tm + py;
        if(pp[j][i][0] > 1){ 
          val = pp[j][i][0];
          textt("" + pp[j][i][0], xt, yt+35, bs, bs, color(0), 40, CENTER);
          rectt(xt,yt,bs,bs,5, colorPicker(val)); 
        }
      }
      if(fC - aS > aL || pp[j][i][0] >= 0){
        if(pp[j][i][0] >= 2){
          float gr = abs(0.5-tm)*2;
          if(fC - aS > aL*3)
            gr = 1;
          rectt(x-2*gr, y-2*gr, bs+4*gr, bs+4*gr, 5, color(255,255,0,100));
        }
        else if(pp[j][i][0] == 1)
          rectt(x-2, y-2, bs+4, bs+4, 5, color(255,100));
        if(val > 0){
          rectt(x,y,bs,bs,5,colorPicker(val));
          textt(""+int(val), x, y+35, bs, bs, color(0),40,CENTER);
        }
      }
    }
  }
  textt("score: "+score,10,5,100,50, color(0),10.0, LEFT);
  if(dead){
    rectt(0,0,width,height,0,color(255,100));
    textt("Gameover! Click to restart", 0,height/2,width,50,color(0),30,CENTER);
    if(mousePressed)
      restart();
  }
}
color colorPicker(float v){
  float r,g,b;
  float level = log(v)/log(2);
  if(level < 4){
    r = 255 - level*30;
    g = level*30 + 135;
    b = 0;
  } else if(level >= 4 && level < 8){
    r = 0;
    g = 255 - (level-3)*40;
    b = (level-3)*40 + 95;
  } else if(level >= 8){
    r = (level-8)*30 + 135;
    g = (level-8)*30 + 135;
    b = 255 - (level-8)*30;
  } else{
    r = g = b = 50;
  }
  return color(r,g,b);
}
void rectt(float x, float y, float w, float h, float r, color c) {
  fill(c);
  rect(x,y,w,h,r);
}
void textt(String t, float x, float y, float w, float h, color c, float s, int align) {
  fill(c);
  textAlign(align);
  textSize(s);
  text(t,x,y,w,h);
}

void keyPressed(){
  if(dead)
    return;
  int kC = keyCode, dy = kC==UP?-1:(kC==DOWN?1:0), dx = kC==LEFT?-1:(kC==RIGHT?1:0);
  int[][] newb = go(dy,dx,true);
  if(newb != null) {
    b=newb;
    spawn();
  }
  if(gameover())
    dead = true;
}

boolean gameover() {
  int[] dx = {1,-1,0,0}, dy = {0,0,1,-1}, ppbk[][] = pp;
  boolean out = true;
  for(int i = 0; i < f; i++){
    if(go(dy[i],dx[i],false) != null)
      out = false;
  }
  pp = ppbk;
  return out;
}
int[][] go(int dy, int dx, boolean updateScpre) {
  pp = new int[4][4][3];
  boolean moved = false;
  int[][] bk = new int[4][4];
  for(int j = 0; j < f; j++)
    for(int i = 0; i < f; i++)
      bk[j][i] = b[j][i];
  if(dx != 0 || dy != 0) {
    int d = dx!=0?dx:dy;
    for(int perp = 0; perp < f; perp++) 
      for (int tang = (d>0? f-2 : 1); tang != (d>0? -1 : f); tang -= d) {
        int y = dx!=0? perp : tang, x = dx!=0? tang : perp, ty = y, tx = x; 
        if(bk[y][x] == 0) 
          continue;
      for(int i = (dx != 0? x : y) + d; i != (d>0?f : -1); i += d) {
        int r = dx != 0 ? y : i, c = dx != 0 ? i : x; 
        if(bk[r][c]!=0 && bk[r][c]!=bk[y][x]) 
          break; 
        if(dx != 0) 
          tx=i; 
        else 
          ty=i; 
      }
      if((dx!=0 && tx==x) || (dy!=0 && ty==y)) 
        continue;
      else if(bk[ty][tx] == bk[y][x]){
        moved = true;
        pp[ty][tx][0] = bk[ty][tx];
        if(updateScpre)
          score += (bk[ty][tx]*=2);
      }
      else if((dx!=0 && tx!=x)||(dy!=0 && ty!=y)){
        pp[ty][tx][0] = 1; 
        bk[ty][tx] = bk[y][x]; 
        moved = true;
      }
      if(moved) {
        pp[ty][tx][1] = y;
        pp[ty][tx][2] = x;
        bk[y][x] = 0; 
      } 
    } 
  }
  if(!moved) 
    return null; 
  aS = frameCount; 
  return bk; 
}
void mousePressed() {
  keyCode = 0;
  if(mouseX < width / 4) 
    keyCode = LEFT;
  if(mouseX > width * 3 / 4) 
    keyCode = RIGHT;
  if(mouseY < height / 4) 
    keyCode = UP;
  if(mouseY > height * 3 / 4) 
    keyCode = DOWN;
  if(keyCode > 0) 
    keyPressed();
}
