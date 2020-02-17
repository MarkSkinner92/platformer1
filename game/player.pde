void loadPlayers(){
  playerimg[0] = loadImage("tiles/player.png");
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
  image(playerimg[0],psp.x,psp.y);
}
