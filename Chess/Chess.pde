Board b;
public int gameOver = 0;// 0 is ongoing, 1 is finnished
final int SQUARE_WIDTH = 32;
final int SQUARE_HEIGHT = 32;
final int SIDE_OFFSET = 10;
final int TOP_OFFSET = 10;
Timer[] times;
int turn = 0;
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
  times[0] = new Timer(8 * SQUARE_WIDTH + 2 * SIDE_OFFSET, 2 * SQUARE_HEIGHT + TOP_OFFSET);
  times[1] = new Timer(8 * SQUARE_WIDTH + 2 * SIDE_OFFSET, TOP_OFFSET);
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
  for(Piece[] pl : b.piecelist){
    for(Piece p: pl){
      if(notNull(p)){
        p.display();
      }
    }
  }
  times[0].display();
  times[1].display();
  times[0].tickOne(1.0/30);
  times[1].tickOne(1.0/30);
}
