PImage[] tiles = new PImage[10];
PImage playerimg;
int[][] level = new int[80][8];
PVector worldpos = new PVector(0,0);
PVector playerPos = new PVector(0,0);//world pos
PVector psp = new PVector(0,0);//player screen position
PVector pspeed = new PVector(0,0);
PVector pacc = new PVector(0,0.5);
boolean canjump = true;
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
void moveCam(){
  float target = -playerPos.x+400;
  if(target >= 0){
    target = 0;
  }
  worldpos.x = lerp(worldpos.x,target,0.03);
  worldpos.y = 0;
}
void playerCollision(){
  if(playerPos.y+100 > 500){
    playerPos.y -= playerPos.y - 400;
    pspeed.y = 0;
  }
}
void playerPhysics(){
  if(keys['a'] == true){
    pspeed.x = -5;
  }
  if(keys['d'] == true){
    pspeed.x = 5;
  }
  if(keys['w'] == true){
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
    for(int j = 0; j < 8; j++){
      if(level[i][j] != -1){
        image(tiles[level[i][j]],i*100+x,(j-2)*100+y);
      }
    }
  }
}
void loadTiles(){
  tiles[0] = loadImage("tiles/test.png");
  tiles[1] = loadImage("tiles/dirt.png");
  tiles[2] = loadImage("tiles/ladder.png");
}
void loadLevel(){
  for(int i = 0; i < 80; i++){
    for(int j = 0; j < 8; j++){
      level[i][j] = -1;
    }
  }
  for(int i = 0; i < 80; i++){
    level[i][7] = 1;
  }
  level[8][6] = 2;
  level[8][5] = 2;
  level[8][4] = 2;
  level[4][7] = -1;
  level[5][7] = -1;
  level[6][7] = -1;
}
void keyPressed(){
  if(key == 'w'){
    keys[key] = true;
  }
  if(key == 's'){
  }
  if(key == 'a'){
    keys[key] = true;
  }
  if(key == 'd'){
    keys[key] = true;
  }
}
void keyReleased(){
  keys[key] = false;
}
