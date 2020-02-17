int pmg = 0;
PImage[] playerimg = new PImage[3];
PVector playerPos = new PVector(0,101);//world pos
PVector psp = new PVector(0,0);//player screen position
PVector pspeed = new PVector(0,0);
PVector pacc = new PVector(0,0.5);
boolean canjump = true, onladder = false;
void loadPlayers(){
  playerimg[0] = loadImage("tiles/player.png");
  playerimg[1] = loadImage("tiles/player2.png");
  playerimg[2] = loadImage("tiles/player3.png");
}
void playerCollision(){
  int blockon = level[constrain(floor(((playerPos.x+50)/100)),0,79)][constrain(floor((playerPos.y+50)/100),0,5)];

  int bottomblockL = level[constrain(floor(((playerPos.x+75)/100)),0,79)][constrain(floor((playerPos.y+50)/100+1),0,5)];
  int bottomblockR = level[constrain(floor(((playerPos.x+25)/100)),0,79)][constrain(floor((playerPos.y+50)/100+1),0,5)];
  
  int rightblockT = level[constrain(floor((playerPos.x+50)/100+1),0,79)][constrain(floor((playerPos.y+25)/100),0,5)];
  int rightblockB = level[constrain(floor((playerPos.x+50)/100+1),0,79)][constrain(floor((playerPos.y+75)/100),0,5)];
  
  int leftblockT = level[constrain(floor((playerPos.x+50)/100-1),0,79)][constrain(floor((playerPos.y+25)/100),0,5)];
  int leftblockB = level[constrain(floor((playerPos.x+50)/100-1),0,79)][constrain(floor((playerPos.y+75)/100),0,5)];
  
  int topblockL = level[constrain(floor(((playerPos.x+25)/100)),0,79)][constrain(floor((playerPos.y+50)/100-1),0,5)];
  int topblockR = level[constrain(floor(((playerPos.x+75)/100)),0,79)][constrain(floor((playerPos.y+50)/100-1),0,5)];
  
  if(orr(bottomblockL,bottomblockR,new int[]{1,4,5,6})){
    if(playerPos.y+100 > (floor((playerPos.y+50)/100+1)*100)){
      canjump = true;
      playerPos.y-=playerPos.y-(floor((playerPos.y+50)/100+1)*100-100);
      pspeed.y = 0;
    }
  }else{
    canjump = false;
  }
  if(orr(rightblockB,rightblockT,new int[]{1,4,5,6})){
    if(playerPos.x+100 > (floor((playerPos.x+50)/100+1)*100)){
      playerPos.x-=playerPos.x-(floor((playerPos.x+50)/100+1)*100-100);
      pspeed.x = 0;
    }
  }
  if(orr(leftblockB,leftblockT,new int[]{1,4,5,6})){
    if(playerPos.x < (floor((playerPos.x+50)/100-1)*100)+100){
      playerPos.x-=playerPos.x-(floor((playerPos.x+50)/100-1)*100+100);
      pspeed.x = 0;
    }
  }
  if(orr(topblockR,topblockL,new int[]{1,4,5,6})){
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
  if(blockon == 3){//coin
    if(playerPos.x > 0 && playerPos.x < 7900 && playerPos.y >= 0 && playerPos.y <=500)
    level[floor((playerPos.x+50)/100)][floor((playerPos.y+50)/100)] = -1;
    score++;
  }
  if(blockon == 7){//spike
    if(playerPos.x > 0 && playerPos.x < 7900 && playerPos.y >= 0 && playerPos.y <=500)
    dead = true;
    pspeed.y = -8;
  }
  if(blockon == 8){//youwon
    if(playerPos.x > 0 && playerPos.x < 7900 && playerPos.y >= 0 && playerPos.y <=500)
    win = true;
    pspeed.y = -100;
  }
}
void playerPhysics(){
  if(!dead){
    if(keys['a']){
      pspeed.x = -5;
      pmg = 1;
    }
    if(keys['d']){
      pspeed.x = 5;
      pmg = 0;
    }
    if(keys['w'] && canjump &&!onladder){
      pspeed.y = -10;
    }
  }
  if(onladder) pmg = 2;
  pspeed.x += pacc.x;
  pspeed.y += pacc.y;
  playerPos.x += pspeed.x;
  playerPos.y += pspeed.y;
  pspeed.x *= 0.2;//friction
}
void renderPlayer(){
  psp.x = worldpos.x+playerPos.x;
  psp.y = worldpos.y+playerPos.y;
  //noFill();
  //stroke(255,0,0);
  //strokeWeight(3);
  //rect(psp.x,psp.y,100,100);
  image(playerimg[pmg],psp.x,psp.y);
}
boolean orr(int a, int b, int[] c){
  for(int i = 0; i < c.length; i++){
    if(a == c[i]) return true;
    if(b == c[i]) return true;
  }
  return false;
}
