int mousex = -1;
int mousey = -1;
int clickedRow = -1;
int clickedCol = -1;
int GRID_X_MIN = LEFT_OFFSET;
int GRID_Y_MIN = TOP_OFFSET;
int GRID_X_MAX = GRID_X_MIN + COLS*(SQUARE_WIDTH+1);
int GRID_Y_MAX = GRID_Y_MIN + ROWS*(SQUARE_HEIGHT+1);
final int NUM_BUTTONS =2;
int buttonSelected = -1;
int buttonReleased = -1;
void mousePressed(){
  if (between(mouseX, GRID_X_MIN, GRID_X_MAX) && between(mouseY, GRID_Y_MIN, GRID_Y_MAX)) {
    // Identify cell to toggle
    clickedRow = (mouseY-GRID_Y_MIN) / (SQUARE_HEIGHT+1);
    clickedCol = (mouseX-GRID_X_MIN) / (SQUARE_WIDTH+1);
  } else {
    buttonSelected = -1;
    for (int i = 0; i < NUM_BUTTONS; i++) {
      if (between(mouseX, LEFT_OFFSET+i*(BUTTON_WIDTH+12), LEFT_OFFSET+i*(BUTTON_WIDTH+12) + BUTTON_WIDTH) &&
          between(mouseY, BUTTON_Y_OFFSET, BUTTON_Y_OFFSET+BUTTON_HEIGHT)) {
            mousex = mouseX;
            mousey = mouseY;
            // 0: Start/Stop, 1: Step, 2: Clear
            buttonSelected = i;
          } 
    }
  }
  println("Pressed: (" + mouseX + ", " + mouseY + "), " + buttonSelected);
}
void mouseReleased() {
  // buttonReleased determines if a button was clicked
  // Must set to -1 here as if not, do not want state change
  buttonReleased = -1;

  // If the click was on the grid, toggle the appropriate cell
  if (between(mouseX, GRID_X_MIN, GRID_X_MAX) && between(mouseY, GRID_Y_MIN, GRID_Y_MAX)) {
    // Identify cell to toggle
    int row = (mouseY-GRID_Y_MIN) / (SQUARE_HEIGHT+1);
    int col = (mouseX-GRID_X_MIN) / (SQUARE_WIDTH+1);
    if (row == clickedRow && col == clickedCol) {
      if(flagging){
        if(!squares[col][row].visible) squares[col][row].flaged = ! squares[col][row].flaged;
      } else reveal(col, row);
    }
  } else {  // Figure out if a button was clicked and, if so, which one
    int x = -1;
    int y = -1;
    for (int i = 0; i < NUM_BUTTONS; i++) {
      if (between(mouseX, LEFT_OFFSET+i*(BUTTON_WIDTH+12), LEFT_OFFSET+i*(BUTTON_WIDTH+12) + BUTTON_WIDTH) &&
          between(mouseY, BUTTON_Y_OFFSET, BUTTON_Y_OFFSET+BUTTON_HEIGHT)) {
            x = mouseX;
            y = mouseY;
            buttonReleased = i;
          } 
    }
    println("Released: (" + x + ", " + y + "), " + buttonReleased);
  }
  if(buttonSelected == buttonReleased){
    if(buttonSelected == 0){
      flagging = !flagging;
    } else if(buttonSelected == 1){
      reset();
    }
  }
}