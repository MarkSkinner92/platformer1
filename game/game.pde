PImage[] tiles = new PImage[10];
PImage playerimg;
int[][] level = new int[80][6];
PVector worldpos = new PVector(0,0);
PVector playerPos = new PVector(0,101);//world pos
PVector psp = new PVector(0,0);//player screen position
PVector pspeed = new PVector(0,0);
PVector pacc = new PVector(0,0.5);
boolean canjump = true, onladder = false;
boolean[] keys = new boolean[255];
void setup(){
  size(1000,600);
  loadTiles();
  playerimg = loadImage("tiles/player.png");
  loadLevel();
  frameRate(60);
}
void draw(){
  background(204, 239, 255);
  playerPhysics();
  playerCollision();
  moveCam();
  renderTiles(worldpos.x,worldpos.y);
  renderPlayer();
}
void respawn(){
  worldpos = new PVector(0,0);
  playerPos = new PVector(0,101);//world pos
  psp = new PVector(0,0);//player screen position
  pspeed = new PVector(0,0);
  pacc = new PVector(0,0.5);
  canjump = true;
  onladder = false;
  keys = new boolean[255];
}
void moveCam(){
  float target = -playerPos.x+400;
  if(target >= 0){
    target = 0;
  }
  worldpos.x = lerp(worldpos.x,target,0.03);
  worldpos.y = 0;
}
void playerCollision(){
  if(playerPos.x < 0){
    playerPos.x = 0;
  }
  if(playerPos.y > 1000){
    respawn();
  }
  int bottomblockL = level[constrain(floor(((playerPos.x+75)/100)),0,79)][constrain(floor((playerPos.y+50)/100+1),0,5)];
  int bottomblockR = level[constrain(floor(((playerPos.x+25)/100)),0,79)][constrain(floor((playerPos.y+50)/100+1),0,5)];
  
  int rightblockT = level[constrain(floor((playerPos.x+50)/100+1),0,79)][constrain(floor((playerPos.y+25)/100),0,5)];
  int rightblockB = level[constrain(floor((playerPos.x+50)/100+1),0,79)][constrain(floor((playerPos.y+75)/100),0,5)];
  
  int leftblockT = level[constrain(floor((playerPos.x+50)/100-1),0,79)][constrain(floor((playerPos.y+25)/100),0,5)];
  int leftblockB = level[constrain(floor((playerPos.x+50)/100-1),0,79)][constrain(floor((playerPos.y+75)/100),0,5)];
  
  int topblockL = level[constrain(floor(((playerPos.x+25)/100)),0,79)][constrain(floor((playerPos.y+50)/100-1),0,5)];
  int topblockR = level[constrain(floor(((playerPos.x+75)/100)),0,79)][constrain(floor((playerPos.y+50)/100-1),0,5)];
  
  if(bottomblockL == 1 || bottomblockR == 1){
    if(playerPos.y+100 > (floor((playerPos.y+50)/100+1)*100)){
      canjump = true;
      playerPos.y-=playerPos.y-(floor((playerPos.y+50)/100+1)*100-100);
      pspeed.y = 0;
    }
  }else{
    canjump = false;
  }
  if(rightblockB == 1 || rightblockT == 1){
    if(playerPos.x+100 > (floor((playerPos.x+50)/100+1)*100)){
      playerPos.x-=playerPos.x-(floor((playerPos.x+50)/100+1)*100-100);
      pspeed.x = 0;
    }
  }
  if(leftblockB == 1 || leftblockT == 1){
    if(playerPos.x < (floor((playerPos.x+50)/100-1)*100)+100){
      playerPos.x-=playerPos.x-(floor((playerPos.x+50)/100-1)*100+100);
      pspeed.x = 0;
    }
  }
  if(topblockL == 1 || topblockR == 1){
    if(playerPos.y < floor((playerPos.y+50)/100-1)*100+100){
      playerPos.y-=playerPos.y-(floor((playerPos.y+50)/100-1)*100+100);
      pspeed.y = 0;
    }
  }
  boolean higherladder = level[constrain(floor(((playerPos.x+50)/100)),0,79)][constrain(floor((playerPos.y)/100+1),0,5)] == 2;
  boolean lowerladder = level[constrain(floor(((playerPos.x+50)/100)),0,79)][constrain(floor((playerPos.y)/100),0,5)] == 2;
  if(lowerladder || higherladder){
    pacc.y = 0;
    pspeed.y = 0;
    onladder = true;
    canjump = true;
    if(keys['w']){
      pspeed.y = -5;
      if(!lowerladder){
        pspeed.y = -10;
      }
    }
    if(keys['s']){
      pspeed.y = 5;
    }
  }else{
    pacc.y = 0.5;
    onladder = false;
  }
}
void playerPhysics(){
  if(keys['a']){
    pspeed.x = -5;
  }
  if(keys['d']){
    pspeed.x = 5;
  }
  if(keys['w'] && canjump &&!onladder){
    pspeed.y = -10;
  }
  pspeed.x += pacc.x;
  pspeed.y += pacc.y;
  playerPos.x += pspeed.x;
  playerPos.y += pspeed.y;
  pspeed.x *= 0.2;//friction
}
void renderPlayer(){
  psp.x = worldpos.x+playerPos.x;
  psp.y = worldpos.y+playerPos.y;
  noFill();
  stroke(255,0,0);
  strokeWeight(3);
  rect(psp.x,psp.y,100,100);
  image(playerimg,psp.x,psp.y);
}
void renderTiles(float x, float y){
  for(int i = constrain(round(-(x+100)/100),0,79); i < constrain(round(-(x-1100)/100),0,79); i++){
    for(int j = 0; j < 6; j++){
      if(level[i][j] != -1){
        image(tiles[level[i][j]],i*100+x,(j)*100+y);
      }
    }
  }
  noFill();
  stroke(0,255,0);
  rect(worldpos.x+(floor((playerPos.x+50)/100)+1)*100,worldpos.y+(floor((playerPos.y+50)/100))*100,100,100);
  rect(worldpos.x+(floor((playerPos.x+50)/100)-1)*100,worldpos.y+(floor((playerPos.y+50)/100))*100,100,100);
  rect(worldpos.x+(floor((playerPos.x+50)/100))*100,worldpos.y+(floor((playerPos.y+50)/100+1))*100,100,100);
  rect(worldpos.x+(floor(((playerPos.x+50)/100)))*100,worldpos.y+(floor((playerPos.y+50)/100)-1)*100,100,100);
  stroke(0,0,255);
  rect(worldpos.x+(floor((playerPos.x+25)/100))*100,worldpos.y+(floor((playerPos.y+50)/100+1))*100,100,100);
  rect(worldpos.x+(floor((playerPos.x+75)/100))*100,worldpos.y+(floor((playerPos.y+50)/100+1))*100,100,100);
}
void loadTiles(){
  tiles[0] = loadImage("tiles/test.png");
  tiles[1] = loadImage("tiles/dirt.png");
  tiles[2] = loadImage("tiles/ladder.png");
}
void loadLevel(){
  for(int i = 0; i < 80; i++){
    for(int j = 0; j < 6; j++){
      level[i][j] = -1;
    }
  }
  for(int i = 0; i < 80; i++){
    level[i][5] = 1;
  }
  level[4][4] = 2;
  level[4][3] = 2;
  level[4][2] = 2;
  level[5][2] = 1;
  level[6][5] = -1;
  level[5][5] = -1;
}
void keyPressed(){
  if(key == 'w'){
    keys[key] = true;
  }
  if(key == 's'){
    keys[key] = true;
  }
  if(key == 'a'){
    keys[key] = true;
  }
  if(key == 'd'){
    keys[key] = true;
  }
  if(key == CODED){
    if(keyCode == UP) keys['w'] = true;
    if(keyCode == DOWN) keys['s'] = true;
    if(keyCode == LEFT) keys['a'] = true;
    if(keyCode == RIGHT) keys['d'] = true;
  }
}
void keyReleased(){
  if(key == 'w' || key == 'a' || key == 's' || key == 'd') keys[key] = false;
  if(key == CODED){
    if(keyCode == UP) keys['w'] = false;
    if(keyCode == DOWN) keys['s'] = false;
    if(keyCode == LEFT) keys['a'] = false;
    if(keyCode == RIGHT) keys['d'] = false;
  }
}
