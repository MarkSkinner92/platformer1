PImage[] tiles = new PImage[10];
int[][] level = new int[80][6];
boolean ctrlPressed;
int current = 1;
int x = 0; int y =0;
//press s to save current level.txt
void setup(){
  size(1000,600);
  loadTiles();
    for(int i = 0; i < 80; i++){
    for(int j = 0; j < 6; j++){
      level[i][j] = -1;
    }
  }
  //loadLevel();
}
void loadTiles(){
  tiles[0] = loadImage("test.png");
  tiles[1] = loadImage("dirt.png");
  tiles[2] = loadImage("ladder.png");
  tiles[3] = loadImage("ladder.png");
}
void draw(){
  background(240);
  grid();
  stroke(255,0,0);
  int mx = floor((mouseX)/100);
  int my = floor((mouseY)/100);
  rect(mx*100,my*100,100,100);
  if(mousePressed){
    if(mouseButton == LEFT)
    level[constrain(mx-x/100,0,79)][constrain(my,0,5)] = current;
    else{
      level[constrain(mx-x/100,0,79)][constrain(my,0,5)] = -1;
    }
  }
  for(int i = constrain(round(-(x+100)/100),0,79); i < constrain(round(-(x-1100)/100),0,79); i++){
    for(int j = 0; j < 6; j++){
      if(level[i][j] != -1){
        image(tiles[level[i][j]],i*100+x,(j)*100+y);
      }
    }
  }
  image(tiles[current],mouseX,mouseY,50,50);
  fill(0);
  text("x " + x,50,50);
}
void grid(){
  stroke(0);
  strokeWeight(1);
  noFill();
  for(int i =0; i < 10; i++)
  for(int j = 0; j < 6; j++)
  rect(i*100,j*100,100,100);
  strokeWeight(5);
  stroke(0,255,0);
  line(x,0,x,height);
  line(x+7900,0,x+7900,height);
}
void keyPressed(){
  switch(key){
    case '1':
    current = 1;
    break;
    case '2':
    current = 2;
    break;
    case '3':
    current = 3;
    break;
    case '4':
    current = 4;
    break;
    case '5':
    current = 5;
    break;
    case '6':
    current = 6;
    break;
    case '7':
    current = 7;
    break;
    case '8':
    current = 8;
    break;
    case '9':
    current = 9;
    break;
    case '0':
    current = 0;
    break;
    case 'd':
    x -= 100;
    break;
    case 'a':
    x += 100;
    break;
    case 'l':
    loadLevel();
    break;
  }
  if (key == CODED) {
    if (keyCode == CONTROL) {
      ctrlPressed = true;
    }
  }
  // regular key
  else {
    if (ctrlPressed) {
      // CTRL + KEY
        println("save");
        savelevel();
    }
  }
  if(tiles[current] == null) current = 0;
}
void keyReleased() {
  if (key == CODED) {
    if (keyCode == CONTROL) {
      ctrlPressed = false;
    }
  }
} 
void savelevel(){
  String[] s = new String[1];
  s[0] = "";
  for(int i = 0; i < 80; i++){
    for(int j = 0; j < 6; j++){
      s[0] += level[i][j] + " ";
    }
  }
  println(s);
  saveStrings("generatedlevel.txt", s);
}
void loadLevel(){
  String s[] = loadStrings("generatedlevel.txt");
  String[] list = split(s[0], ' ');
  int ind = 0;
  for(int i = 0; i < 80; i++){
    for(int j = 0; j < 6; j++){
      level[i][j] = Integer.parseInt(list[ind]);
      ind++;
    }
  }
}
