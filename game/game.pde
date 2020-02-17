PImage[] tiles = new PImage[10];
PImage[] playerimg = new PImage[3];
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
  loadPlayers();
  loadLevel();
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
