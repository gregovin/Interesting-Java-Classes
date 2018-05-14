final int ROWS = 40;
final int COLS = 40;
final int MINES = 160;
final int SQUARE_WIDTH = 15;
final int SQUARE_HEIGHT = 15;
final int LEFT_OFFSET = 12;
final int TOP_OFFSET = 12;
public boolean gameOver;
final int BOTTOM_GRID_OFFSET = TOP_OFFSET + (SQUARE_HEIGHT+1)*ROWS;
// From top of window to top of buttons
final int BUTTON_Y_OFFSET = BOTTOM_GRID_OFFSET + 12;
final int BUTTON_WIDTH = 100;
final int BUTTON_HEIGHT = 40;
boolean flagging = false;
public Square[][] squares;
void setup(){
  size(1024, 768, P3D);
  initGrid();
  PFont font = createFont("ComicSansMS-Bold", 10);
  textSize(10);
  textFont(font);
  textAlign(CENTER, CENTER);
}
void draw(){
  background(#ffffff);
  stroke(#000000);
  displaySquares();
  drawButtons();
}
void drawButtons(){
  fill(#DDDDDD);
  rect(LEFT_OFFSET, BUTTON_Y_OFFSET, BUTTON_WIDTH, BUTTON_HEIGHT);
  rect(LEFT_OFFSET + BUTTON_WIDTH + 12, BUTTON_Y_OFFSET, BUTTON_WIDTH, BUTTON_HEIGHT); 
  fill(#0000FF);
  text(flagging ? "reveal" : "flag", LEFT_OFFSET+50, BUTTON_Y_OFFSET+12);
  text("reset", LEFT_OFFSET + BUTTON_WIDTH + 62, BUTTON_Y_OFFSET + 12);
}