class Rook extends Piece {
  public Rook(int side, String imgFilePath, int coll) {
    super(2, coll, 7 * side, imgFilePath, side);
  }
  public boolean valid_move(int newRow, int newColl, Board board){
    if(newRow == row){
      if(newColl > coll){
        int k = 1;
        while(k < newColl-coll && !notNull(board.pieceAt(row, coll+ k))){
          k++;
        }
        if(k == newColl-coll){
          if(notNull(board.pieceAt(newRow, newColl))){
            return board.pieceAt(newRow, newColl).side == 1- this.side;
          }
          return true;
        }
      } else if(newColl < coll){
        int k = -1;
        while(k > newColl-coll && !notNull(board.pieceAt(row, coll+ k))){
          k--;
        }
        if(k == newColl-coll){
          if(notNull(board.pieceAt(newRow, newColl))){
            return board.pieceAt(newRow, newColl).side == 1- this.side;
          }
          return true;
        }
      }
    } else if(newColl == coll){
      if(newRow > row){
        int k = 1;
        while(k < newRow-row && !notNull(board.pieceAt(row+k, coll))){
          k++;
        }
        if(k == newRow-row){
          if(notNull(board.pieceAt(newRow, newColl))){
            return board.pieceAt(newRow, newColl).side == 1- this.side;
          }
          return true;
        }
      } else if(newRow < row){
        int k = -1;
        while(k > newRow-row && !notNull(board.pieceAt(row + k, coll))){
          k--;
        }
        if(k == newRow-row){
          if(notNull(board.pieceAt(newRow, newColl))){
            return board.pieceAt(newRow, newColl).side == 1- this.side;
          }
          return true;
        }
      }
    }
    return false;
  }
}
