class Knight extends Piece{
  public Knight(int side, String imgFilePath, int coll) {
    super(3, coll, 7 * side, imgFilePath, side);
  }
  public boolean valid_move(int newRow, int newColl, Board board){
    if(Math.abs(newRow-row) == 2 && Math.abs(newColl-coll) ==1){
      if(notNull(board.pieceAt(newRow, newColl))){
        return board.pieceAt(newRow, newColl).side == 1 - this.side;
      }
      return true;
    } else if(Math.abs(newRow-row) == 1 && Math.abs(newColl-coll) ==2){
      if(notNull(board.pieceAt(newRow, newColl))){
        return board.pieceAt(newRow, newColl).side == 1 - this.side;
      }
      return true;
    }
    return false;
  }
}