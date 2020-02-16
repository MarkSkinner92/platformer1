PImage[] tiles = new PImage[10];
int[][] level = new int[80][8];
PVector worldpos = new PVector(0,0);
void setup(){
  size(1000,600);
  loadTiles();
  loadLevel();
  frameRate(60);
}
void draw(){
  background(204, 239, 255);
  renderTiles(worldpos.x,worldpos.y);
  worldpos.x = -mouseX;
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
}
