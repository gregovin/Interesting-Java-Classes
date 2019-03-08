Board b;
public int gameOver = 0;
// 0 is ongoing, 1 is white wins, 2 is black wins, 3 is draw
public int reasonForGO = 0; 
public String[] reasons = {"Check mate", "resignation", "Time out", "Draw Offer", "Three fold repitition", 
"Perpetual", "50 move rule", "Insuficient material"};
//0 is check mate, 1 is resign, 2 is time out, 3 is draw offer, 4 is three fold, 5 is perpetual, 6 is 50 move rule, 7 is insuficient material
final int INITIAL_TIME = 10;
final int INC = 10;
final int SQUARE_WIDTH = 32;
final int SQUARE_HEIGHT = 32;
int promotesTo = 3;
String[] sides = {"white", "black"};
final int SIDE_OFFSET = 10;
final int TOP_OFFSET = 10;
Timer[] times;
boolean empesa = false;
boolean promotes = false;
String[] possibleValues = {"Bishop", "Knight", "Rook", "Queen"};
int turn = 0;
// From top of window to top of buttons
final int BUTTON_WIDTH = 100;
final int BUTTON_HEIGHT = 40;
public int movesSinceIrreversible = 0;
ArrayList<Position> posLs = new ArrayList<Position>();
public void undoMove(){
  times[1-turn].unStop();
  turn = 1 - turn;
  posLs.remove(posLs.size() -1);
  movesSinceIrreversible --;
  gameOver = 0;
}
public void checkThreeFold(){
  Position cur = posLs.get(posLs.size()-1);
  int count = 1;
  for(int i =posLs.size()-movesSinceIrreversible - 1; i < posLs.size()-1 && count < 3; i ++){
    if(cur.equals(posLs.get(i))) {
      count++;
    }
  }
  if(count >= 3){
    gameOver = 3;
    reasonForGO = 4;
  }
}
public static boolean between(int a, int lower, int upper) {
  return (a >= lower) && (a <= upper);
}
public static boolean notNull(Piece piece) {
    if (piece == null) {
      return false;
    }
    return true;
}
void setup(){
  size(512,512,P3D);
  b = new Board();
  times = new Timer[2];
  times[0] = new Timer(8 * SQUARE_WIDTH + 2 * SIDE_OFFSET, 2 * SQUARE_HEIGHT + TOP_OFFSET, INITIAL_TIME, INC, 0);
  times[1] = new Timer(8 * SQUARE_WIDTH + 2 * SIDE_OFFSET, TOP_OFFSET, INITIAL_TIME,INC, 1);
  times[0].start();
  frameRate(30);
}
void draw(){
  background(#db9732);
  fill(#ffffff);
  rect(SIDE_OFFSET, TOP_OFFSET, 8 *SQUARE_WIDTH, 8 * SQUARE_HEIGHT);
  fill(#323232);
  for(int i = 0; i < 8; i ++){
    for(int j = i % 2; j < 8; j += 2){
      rect(j * SQUARE_WIDTH + SIDE_OFFSET, i * SQUARE_HEIGHT+TOP_OFFSET, SQUARE_WIDTH, SQUARE_HEIGHT);
    }
  }
  b.getPos().display();
  
  times[0].display();
  times[1].display();
  if(gameOver==0){
    times[0].tickOne(1.0/30);
    times[1].tickOne(1.0/30);
  } else {
    fill(#000000);
    rect(8 * SQUARE_WIDTH + 2 * SIDE_OFFSET, 4 * SQUARE_HEIGHT + TOP_OFFSET, 4 * SQUARE_WIDTH, 2 * SQUARE_HEIGHT);
    fill(#ffffff);
    textAlign(CENTER, CENTER);
    if(gameOver < 3){
      text(reasons[reasonForGO], 8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + 2 * SQUARE_WIDTH, 4 * SQUARE_HEIGHT + TOP_OFFSET + SQUARE_HEIGHT/2);
      text(sides[gameOver-1] + " won", 8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + 2 * SQUARE_WIDTH, 4 * SQUARE_HEIGHT + TOP_OFFSET + 3 * SQUARE_HEIGHT/2);
    } else {
      text(reasons[reasonForGO], 8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + 2 * SQUARE_WIDTH, 4 * SQUARE_HEIGHT + TOP_OFFSET + SQUARE_HEIGHT);
      text("draw", 8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + 2 * SQUARE_WIDTH, 4 * SQUARE_HEIGHT + TOP_OFFSET + 3 * SQUARE_HEIGHT/2);
    }
  }
  if(movesSinceIrreversible >= 100) {
    gameOver = 3;
    reasonForGO = 6;
  }
  drawButtons();
}
void drawButtons(){
  rect(8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + SQUARE_WIDTH * 2, 3 * SQUARE_HEIGHT + TOP_OFFSET, SQUARE_WIDTH, SQUARE_HEIGHT/2);
  rect(8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + SQUARE_WIDTH * 2, TOP_OFFSET + SQUARE_HEIGHT, SQUARE_WIDTH, SQUARE_HEIGHT/2);
  image(loadImage("img/Resign.png"), 8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + SQUARE_WIDTH * 2, 3 * SQUARE_HEIGHT + TOP_OFFSET, SQUARE_WIDTH, SQUARE_HEIGHT/2);
  image(loadImage("img/Resign.png"), 8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + SQUARE_WIDTH * 2, TOP_OFFSET + SQUARE_HEIGHT, SQUARE_WIDTH, SQUARE_HEIGHT/2);
  fill(#f2f2f2);

  rect(8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + SQUARE_WIDTH, 3 * SQUARE_HEIGHT + TOP_OFFSET, SQUARE_WIDTH, SQUARE_HEIGHT/2);
  rect(8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + SQUARE_WIDTH, TOP_OFFSET + SQUARE_HEIGHT, SQUARE_WIDTH, SQUARE_HEIGHT/2);
  rect(8 * SQUARE_WIDTH + 2 * SIDE_OFFSET, 3 * SQUARE_HEIGHT + TOP_OFFSET, SQUARE_WIDTH, SQUARE_HEIGHT/2);
  rect(8 * SQUARE_WIDTH + 2 * SIDE_OFFSET, TOP_OFFSET + SQUARE_HEIGHT, SQUARE_WIDTH, SQUARE_HEIGHT/2);
  textAlign(CENTER, CENTER);
  fill(#000000);
  text("1/2", 8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + (3 *SQUARE_WIDTH)/2, (13 * SQUARE_HEIGHT/4) + TOP_OFFSET);
  text("1/2", 8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + (3 *SQUARE_WIDTH)/2, (5 * SQUARE_HEIGHT/4) + TOP_OFFSET);
  text("TB", 8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + (SQUARE_WIDTH)/2, (13 * SQUARE_HEIGHT/4) + TOP_OFFSET);
  text("TB", 8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + (SQUARE_WIDTH)/2, (5 * SQUARE_HEIGHT/4) + TOP_OFFSET);
}
