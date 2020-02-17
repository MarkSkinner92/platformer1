PImage[] tiles = new PImage[10];
PImage[] coins = new PImage[3];
int[][] level = new int[80][6];
int[] coinstate = new int[]{0,1,2,1};
void loadTiles(){
  coins[0] = loadImage("tiles/coin1.png");
  coins[1] = loadImage("tiles/coin2.png");
  coins[2] = loadImage("tiles/coin3.png");
  tiles[0] = loadImage("tiles/test.png");
  tiles[1] = loadImage("tiles/dirt.png");
  tiles[2] = loadImage("tiles/ladder.png");
  tiles[3] = loadImage("tiles/coin1.png");
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
        if(level[i][j] == 3){//coin
          image(coins[coinstate[(frameCount/10)%4]],i*100+x,(j)*100+y);
        }
        else{
          image(tiles[level[i][j]],i*100+x,(j)*100+y);
        }
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
