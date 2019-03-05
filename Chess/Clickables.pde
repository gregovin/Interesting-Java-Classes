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
    if(clickedRow != clickedRow2 || clickedCol != clickedCol2){
      b.move(7-clickedRow, 7-clickedCol, 7-clickedRow2, 7-clickedCol2);
    }
  } else if(between(mouseX, 8 * SQUARE_WIDTH + 2 * SIDE_OFFSET, 11 * SQUARE_WIDTH + 2 * SIDE_OFFSET) && between(mouseY, 3 * SQUARE_HEIGHT + TOP_OFFSET, (7 * SQUARE_HEIGHT)/2 + TOP_OFFSET)){
    int buttonClicked = (mouseX - 8 * SQUARE_WIDTH - 2 * SIDE_OFFSET)/SQUARE_WIDTH;
    if(turn == 0 && buttonClicked == 2){
      gameOver = 2;
      reasonForGO = 1;
    } else if(turn == 0 && buttonClicked == 1){
      Object selectedValue = JOptionPane.showConfirmDialog(null,
        "White has offered a draw, do you accept", "Draw", JOptionPane.YES_NO_OPTION);
      if(selectedValue.equals(0)){
         gameOver = 3;
         reasonForGO = 3;
      }
    } else if(buttonClicked == 0 && posLs.size() > 1){
      Object selectedValue = JOptionPane.showConfirmDialog(null,
        "White has asked for a takeback, do you accept?", "takeback", JOptionPane.YES_NO_OPTION);
      if(selectedValue.equals(0)){
         b.setPos(posLs.get(posLs.size()-2));
         posLs.remove(posLs.size()-1);
         
      }
    }
  } else if(between(mouseX, 8 * SQUARE_WIDTH + 2 * SIDE_OFFSET, 11 * SQUARE_WIDTH + 2 * SIDE_OFFSET) && between(mouseY, TOP_OFFSET + SQUARE_HEIGHT, (3 *SQUARE_HEIGHT)/2 + TOP_OFFSET)){
    int buttonClicked = (mouseX - 8 * SQUARE_WIDTH - 2 * SIDE_OFFSET)/SQUARE_WIDTH;
    if(buttonClicked == 2){
      gameOver = 1;
      reasonForGO = 1;
    } else if(turn ==1 && buttonClicked == 1){
      Object selectedValue = JOptionPane.showConfirmDialog(null,
        "Black has offered a draw, do you accept", "Draw", JOptionPane.YES_NO_OPTION);
      if(selectedValue.equals(0)){
         gameOver = 3;
         reasonForGO = 3;
      }
    } else if(buttonClicked == 0 && posLs.size() > 1){
      Object selectedValue = JOptionPane.showConfirmDialog(null,
        "Black has asked for a takeback, do you accept?", "takeback", JOptionPane.YES_NO_OPTION);
      if(selectedValue.equals(0)){
         b.setPos(posLs.get(posLs.size()-2));
         posLs.remove(posLs.size()-1);
      }
    }
  }
  
}
