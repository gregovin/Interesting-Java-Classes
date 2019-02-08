class Bishop extends Piece{
  public Bishop(int side, String imgFilePath, int coll) {
    super(4, coll, 7 * side, imgFilePath, side);
  }
  public boolean valid_move(int newRow, int newColl, Board board){
    if(newRow -row == newColl - coll){
      if(newRow > row){
        int k = 1;
        while(k<newRow-row && !notNull(board.pieceAt(k + row, k+coll))){
          k++;
        }
        if(k == newRow - row){
          if(notNull(board.pieceAt(newRow, newColl))){
            return board.pieceAt(newRow, newColl).side == 1 - this.side;
          }
          return true;
        }
      } else if(newRow < row){
        int k = -1;
        while(k>newRow-row && !notNull(board.pieceAt(k + row, k+coll))){
          k--;
        }
        if(k == newRow - row){
          if(notNull(board.pieceAt(newRow, newColl))){
            return board.pieceAt(newRow, newColl).side == 1 - this.side;
          }
          return true;
        }
      }
    } else if (newRow-row == coll - newColl){
      if(newRow > row){
        int k = 1;
        while(k<newRow-row && !notNull(board.pieceAt(k + row, coll - k))){
          k++;
        }
        println(row + k, coll - k);
        if(k == newRow - row){
          if(notNull(board.pieceAt(newRow, newColl))){
            return board.pieceAt(newRow, newColl).side == 1 - this.side;
          }
          return true;
        }
      } else if(newRow < row){
        int k = -1;
        while(k>newRow-row && !notNull(board.pieceAt(k + row, coll - k))){
          k--;
        }
        if(k == newRow - row){
          if(notNull(board.pieceAt(newRow, newColl))){
            return board.pieceAt(newRow, newColl).side == 1 - this.side;
          }
          return true;
        }
      }
    }
    return false;
  }
}