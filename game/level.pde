PImage[] tiles = new PImage[10];
int[][] level = new int[80][6];
void loadTiles(){
  tiles[0] = loadImage("tiles/test.png");
  tiles[1] = loadImage("tiles/dirt.png");
  tiles[2] = loadImage("tiles/ladder.png");
}
void loadLevel(){
  String s[] = loadStrings("tiles/generatedlevel.txt");
  String[] list = split(s[0], ' ');
  int ind = 0;
  for(int i = 0; i < 80; i++){
    for(int j = 0; j < 6; j++){
      level[i][j] = Integer.parseInt(list[ind]);
      ind++;
    }
  }
}
void renderTiles(float x, float y){
  for(int i = constrain(round(-(x+100)/100),0,79); i < constrain(round(-(x-1100)/100),0,79); i++){
    for(int j = 0; j < 6; j++){
      if(level[i][j] != -1){
        image(tiles[level[i][j]],i*100+x,(j)*100+y);
      }
    }
  }
  //noFill();
  //stroke(0,255,0);
  //rect(worldpos.x+(floor((playerPos.x+50)/100)+1)*100,worldpos.y+(floor((playerPos.y+50)/100))*100,100,100);
  //rect(worldpos.x+(floor((playerPos.x+50)/100)-1)*100,worldpos.y+(floor((playerPos.y+50)/100))*100,100,100);
  //rect(worldpos.x+(floor((playerPos.x+50)/100))*100,worldpos.y+(floor((playerPos.y+50)/100+1))*100,100,100);
  //rect(worldpos.x+(floor(((playerPos.x+50)/100)))*100,worldpos.y+(floor((playerPos.y+50)/100)-1)*100,100,100);
  //stroke(0,0,255);
  //rect(worldpos.x+(floor((playerPos.x+25)/100))*100,worldpos.y+(floor((playerPos.y+50)/100+1))*100,100,100);
  //rect(worldpos.x+(floor((playerPos.x+75)/100))*100,worldpos.y+(floor((playerPos.y+50)/100+1))*100,100,100);
}
