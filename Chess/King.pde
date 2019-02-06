class King extends Piece{
  public King(int side, String imgFilePath) {
    super(0 , 3, 7 * side, imgFilePath, side);
  }
  public boolean valid_move(int newRow, int newColl, Board board){
    if(Math.abs(newRow - row) > 1 || Math.abs(newColl - coll) > 2){
       return false;
     } else if(newColl - coll == 2){
       println("attempting to castle");
       Piece corner = board.pieceAt(7 * side, 7);
       if(!notNull(corner) || corner.type != 2 || corner.moves_made !=0 || this.moves_made != 0 || 
                   notNull(board.pieceAt(7 * side, 6)) || notNull(board.pieceAt(7 * side, 5)) || notNull(board.pieceAt(7 * side, 4))){
              println("failed due to lack of neccesary conditions");
              return false;
       }
       if(board.move(7 *side, 7, 7 * side, newColl-1)){
         board.teleport(7 * side, newColl-1, 7 * side, 7);
         times[this.side].unStop();
         turn = this.side;
         if(board.move(this.row, this.coll, 7 * side, newColl-1)){
           turn = this.side;
           times[this.side].unStop();
            if(board.move(this.row, this.coll, 7 * side, newColl)){
               board.teleport(7 * side, 7, 7 * side, newColl-1);
               println("casle succeded");
               turn = this.side;
               return true;
           }
         }
       }
       println("rook or king could not move");
       this.moves_made =0;
       corner.moves_made = 0;
       return false;
     } else if(newColl - coll == -2){
       Piece corner = board.pieceAt(7 * side, 0);
       if(!notNull(corner) || corner.type != 2 || corner.moves_made !=0 || this.moves_made != 0 ||
               notNull(board.pieceAt(7 * side, 1)) || notNull(board.pieceAt(7 * side, 2))){
         return false;
       }
       if(board.move(7 * side, 0, 7 * side, newColl+1)){
         board.teleport(7*side, newColl+1, 7*side, 0);
         times[this.side].unStop();
         turn = this.side;
         if(board.move(this.row, this.coll, 7*side, 2)){
           turn = this.side;
           times[this.side].unStop();
           if(board.move(this.row, this.coll, 7*side, newColl)){
             board.teleport(7*side, 0, 7*side, newColl+1);
             turn = this.side;
             return true;
           }
         }
       }
       println("rook or king could not move");
       this.moves_made =0;
       corner.moves_made = 0;
       return false;
     }
     if(notNull(board.pieceAt(newRow,newColl))){
       return board.pieceAt(newRow, newColl).side == 1-this.side;
     }
     return true;
  }
}
