PImage[] tiles = new PImage[10];
void setup(){
  size(1000,600);
  loadTiles();
}
void draw(){
  background(0);
  for(int x = 0; x < 10; x++){
    for(int y = 0; y < 10; y++){
      image(tiles[0],x*100,y*100);
    }
  }
}
void loadTiles(){
  tiles[0] = loadImage("tiles/test.png");
}
