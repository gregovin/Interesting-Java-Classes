class Pawn extends Piece{
  public Pawn(int side, String imgFilePath, int coll) {
    super(5, coll, 5 * side + 1, imgFilePath, side);
  }
  public boolean valid_move(int newRow, int newColl, Board board){
    if(newColl == coll){
      if(newRow - row == 2 - 4 * side && this.moves_made == 0 && && !notNull(board.pieceAt(row + 1 - 2 * side, newColl)) && !notNull(board.pieceAt(newRow, newColl))){
        return true;
      }else if(newRow - row == 1 - 2 * side && !notNull(board.pieceAt(newRow, newColl))){
        return true;
      }
    } else if(Math.abs(newColl - coll) == 1 && newRow - row == 1 - 2 * side){
      if(notNull(board.pieceAt(newRow, newColl))){
        return board.pieceAt(newRow,newColl).side == 1 - this.side;
      } else if(notNull(board.pieceAt(row, coll))){
        Piece test = board.pieceAt(newRow,newColl);
        return test.type == this.type && test.moves_made == 1 && test.row = 3 + test.side && test.side == 1 - this.side;
      }
    }
    return false;
  }
}
