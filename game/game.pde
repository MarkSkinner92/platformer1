PImage[] tiles = new PImage[10];
int[][] level = new int[80][8];
void setup(){
  size(1000,600);
  loadTiles();
  loadLevel();
}
void draw(){
  background(0);
  for(int x = 0; x < 10; x++){
    for(int y = 0; y < 10; y++){
      image(tiles[0],x*100,y*100);
    }
  }
  renderTiles(0,0);
}
void renderTiles(float x, float y){
  for(int i = 0; i < 80; i++){
    for(int j = 0; j < 8; j++){
      if(level[i][j] != -1){
        image(tiles[level[i][j]],i*100+x,(j-2)*100+y);
      }
    }
  }
}
void loadTiles(){
  tiles[0] = loadImage("tiles/test.png");
  tiles[1] = loadImage("tiles/ground.png");
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
}
