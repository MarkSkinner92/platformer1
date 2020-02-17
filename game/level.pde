void loadTiles(){
  tiles[0] = loadImage("tiles/test.png");
  tiles[1] = loadImage("tiles/dirt.png");
  tiles[2] = loadImage("tiles/ladder.png");
}
void loadLevel(){
  for(int i = 0; i < 80; i++){
    for(int j = 0; j < 6; j++){
      level[i][j] = 0;
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
