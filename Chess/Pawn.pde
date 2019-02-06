class Pawn extends Piece{
  public Pawn(int side, String imgFilePath, int coll) {
    super(5, coll, 5 * side + 1, imgFilePath, side);
  }
  public boolean valid_move(int newRow, int newColl, Board board){
    if(newColl == coll){
      if(newRow - row == 2 - 4 * side){
        
      }
    }
    return false;
  }
}
