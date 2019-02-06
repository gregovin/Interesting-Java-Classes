int mousex = -1;
int mousey = -1;
int clickedRow= -1;
int clickedCol = -1;
int clickedRow2 = -1;
int clickedCol2 = -1;
boolean is_chosing = true;
int GRID_X_MIN = SIDE_OFFSET;
int GRID_Y_MIN = TOP_OFFSET;
int GRID_X_MAX = GRID_X_MIN + SQUARE_WIDTH * 8;
int GRID_Y_MAX = GRID_Y_MIN + SQUARE_HEIGHT * 8;
void mousePressed(){
  if (is_chosing && between(mouseX, GRID_X_MIN, GRID_X_MAX) && between(mouseY, GRID_Y_MIN, GRID_Y_MAX)) {
    // Identify cell to toggle
    clickedRow = (mouseY-GRID_Y_MIN) / SQUARE_HEIGHT;
    clickedCol = (mouseX-GRID_X_MIN) / SQUARE_WIDTH;
    if(notNull(b.pieceAt(7-clickedRow, 7-clickedCol))){
      //println(b.pieceAt(7-clickedRow, 7-clickedCol));
      is_chosing = ! is_chosing;
    }
  } else if(between(mouseX, GRID_X_MIN, GRID_X_MAX) && between(mouseY, GRID_Y_MIN, GRID_Y_MAX)){
    clickedRow2 = (mouseY-GRID_Y_MIN) / SQUARE_HEIGHT;
    clickedCol2 = (mouseX-GRID_X_MIN) / SQUARE_WIDTH;
    is_chosing = ! is_chosing;
    b.move(7-clickedRow, 7-clickedCol, 7-clickedRow2, 7-clickedCol2);
  }
}
