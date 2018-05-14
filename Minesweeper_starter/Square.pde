class Square{
  public boolean visible;
  public boolean isMine;
  public int minesAdj;
  public boolean flaged;
  public int row;
  public int coll;
  private color[] txtColor =  {#e8e8e8, #324eff, #13a803, #ff7700, #4100a3, #8c0000,
  #1dc6a5, #000000, #9b9b9b};
  public Square(boolean isMine, int row, int coll){
    this.isMine = isMine;
    this.row = row;
    this.coll = coll;
    this.visible = false;
    this.flaged = false;
  }
  public int reveal(){
    if(!visible){
      visible = true;
      if(isMine) return 9;
      return minesAdj;
    } else return -1;
  }
  public void calcAdjMines(){
    minesAdj = 0;
    for(int i = (row == 0) ? 0 : row-1; i <= ((row == ROWS-1) ? ROWS - 1 : row + 1); i ++){
      for(int j = (coll == 0) ? 0 : coll - 1; j <= ((coll == COLS-1) ? COLS -1 : coll + 1); j ++){
        if(squares[i][j].isMine) minesAdj ++;
      }
    }
  }
  public void display(int xoffset, int yoffset, int w, int h){
    xoffset += (w + 1) * row;
    yoffset += (h + 1) * coll;
    fill(#a8a8a8);
    stroke(0);
    rect(xoffset, yoffset, SQUARE_WIDTH, SQUARE_HEIGHT);
    if(flaged){
      line(xoffset+ SQUARE_WIDTH/2, yoffset + 3 * SQUARE_HEIGHT/4, xoffset+ SQUARE_WIDTH/2, yoffset + SQUARE_HEIGHT/4);
      fill(#ff0000);
      triangle(xoffset + SQUARE_WIDTH/2, yoffset + SQUARE_HEIGHT/4,
        xoffset + SQUARE_WIDTH/2, yoffset + SQUARE_HEIGHT/2, 
        xoffset + SQUARE_WIDTH/4, yoffset + SQUARE_HEIGHT/2);
    } else if(!visible){
      
    } else if(isMine){
      fill(#e8e8e8);
      rect(xoffset, yoffset, SQUARE_WIDTH, SQUARE_HEIGHT);
      fill(#000000);
      ellipse(xoffset + SQUARE_WIDTH/2, yoffset + SQUARE_HEIGHT/2, SQUARE_WIDTH/2, SQUARE_HEIGHT/2);
    } else if(minesAdj == 0){
      fill(txtColor[0]);
      rect(xoffset, yoffset, SQUARE_WIDTH, SQUARE_HEIGHT);
    } else {
      fill(txtColor[0]);
      rect(xoffset, yoffset, SQUARE_WIDTH, SQUARE_HEIGHT);
      stroke(txtColor[minesAdj]);
      fill(txtColor[minesAdj]);
      text(minesAdj + "", xoffset + SQUARE_WIDTH/2, yoffset+SQUARE_HEIGHT/2);
    }
  }
}