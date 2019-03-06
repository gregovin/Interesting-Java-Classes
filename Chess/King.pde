class King extends Piece{
  public King(int side, String imgFilePath) {
    super(0 , 3, 7 * side, imgFilePath, side);
  }
  public King(int side, String imgFilePath, int row, int coll){
    super(0 , coll, row, imgFilePath, side);
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
         undoMove();
         if(board.move(this.row, this.coll, 7 * side, newColl-1)){
           undoMove();
            if(board.move(this.row, this.coll, 7 * side, newColl)){
               board.teleport(7 * side, 7, 7 * side, newColl-1);
               println("casle succeded");
               undoMove();
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
         posLs.remove(posLs.size() -1);
         movesSinceIrreversible --;
         if(board.move(this.row, this.coll, 7*side, 2)){
           turn = this.side;
           times[this.side].unStop();
           posLs.remove(posLs.size() -1);
           movesSinceIrreversible --;
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
     if(notNull(board.pieceAt(newRow, newColl)) && board.pieceAt(newRow, newColl).side == 1 - this.side){
       movesSinceIrreversible = -1;
       return true;
     } else if(notNull(board.pieceAt(newRow, newColl))) return false;
     return true;
  }
  public boolean inCheck(Board board){
    //look for pawns checking
    if(notNull(board.pieceAt(row + 1 - 2 * this.side, this.coll - 1)) &&
    board.pieceAt(row + 1 - 2 * this.side, this.coll - 1).type == 5 &&
    board.pieceAt(row + 1 - 2 * this.side, this.coll - 1).side == 1- side){
      return true;
    } else if(notNull(board.pieceAt(row + 1 - 2 * this.side, this.coll + 1))
    && board.pieceAt(row + 1 - 2 * this.side, this.coll + 1).type == 5
    && board.pieceAt(row + 1 - 2 * this.side, this.coll + 1).side == 1- side){
      return true;
    }
    //look for knights checking
    for(int x = 1; x < 3; x ++){
      for(int sig1 = -1; sig1 < 2; sig1 += 2){
        for(int sig2 = -1; sig2 < 2; sig2 += 2){
          if(notNull(board.pieceAt(row + x * sig1, coll + (3-x) * sig2)) && 
          board.pieceAt(row + x * sig1, coll + (3-x) * sig2).type == 3 && 
          board.pieceAt(row + x * sig1, coll + (3-x) * sig2).side == 1-this.side){
            return true;
          }
        }
      }
    }
    //look for bishops and queens
    int k = 1;
    while(!notNull(board.pieceAt(k + row, k+coll)) && board.inBoard(k + row, k + coll)){
       k++;
    }
    if(notNull(board.pieceAt(k + row, k+coll)) &&
    (board.pieceAt(k + row, k + coll).type == 4 || board.pieceAt(k + row, k + coll).type == 1) &&
    board.pieceAt(k + row, k + coll).side == 1- this.side){
      return true;
    }
    k = -1;
    while(!notNull(board.pieceAt(k + row, k+coll)) && board.inBoard(k + row, k + coll)){
       k--;
    }
    if(notNull(board.pieceAt(k + row, k+coll)) &&
    (board.pieceAt(k + row, k + coll).type == 4 || board.pieceAt(k + row, k + coll).type == 1) &&
    board.pieceAt(k + row, k + coll).side == 1- this.side){
      return true;
    }
    k = 1;
    while(!notNull(board.pieceAt(k + row, coll - k)) && board.inBoard(row + k, coll - k)){
       k++;
    }
    if(notNull(board.pieceAt(k + row, coll -k)) &&
    (board.pieceAt(k + row, coll -k).type == 4 || board.pieceAt(k + row, coll - k).type == 1) &&
    board.pieceAt(k + row,coll-k).side == 1- this.side){
      return true;
    }
    k = -1;
    while(!notNull(board.pieceAt(k + row, coll - k)) && board.inBoard(row + k, coll - k)){
       k--;
    }
    if(notNull(board.pieceAt(k + row, coll -k)) &&
    (board.pieceAt(k + row, coll -k).type == 4 || board.pieceAt(k + row, coll - k).type == 1) &&
    board.pieceAt(k + row,coll-k).side == 1- this.side){
      return true;
    }
    //looking for rooks and queens who are checking
    k = 1;
    while(!notNull(board.pieceAt(k + row, coll)) && board.inBoard(k + row, coll)){
       k++;
    }
    if(notNull(board.pieceAt(k + row, coll)) &&
    (board.pieceAt(k + row, coll).type == 2 || board.pieceAt(k + row, coll).type == 1) &&
    board.pieceAt(k + row, coll).side == 1- this.side){
      return true;
    }
    k = -1;
    while(!notNull(board.pieceAt(k + row, coll)) && board.inBoard(k + row, coll)){
       k--;
    }
    if(notNull(board.pieceAt(k + row, coll)) &&
    (board.pieceAt(k + row, coll).type == 2 || board.pieceAt(k + row, coll).type == 1) &&
    board.pieceAt(k + row, coll).side == 1- this.side){
      return true;
    }
    k = 1;
    while(!notNull(board.pieceAt(row, coll + k)) && board.inBoard(row, coll + k)){
       k++;
    }
    if(notNull(board.pieceAt(row, coll + k)) &&
    (board.pieceAt(row, coll + k).type == 2 || board.pieceAt(row, coll + k).type == 1) &&
    board.pieceAt(row,coll + k).side == 1- this.side){
      return true;
    }
    k = -1;
    while(!notNull(board.pieceAt(row, coll + k)) && board.inBoard(row, coll + k)){
       k--;
    }
    if(notNull(board.pieceAt(row, coll + k)) &&
    (board.pieceAt(row, coll + k).type == 4 || board.pieceAt(row, coll + k).type == 1) &&
    board.pieceAt(row,coll + k).side == 1- this.side){
      return true;
    }
    for(int x = -1; x <= 1; x++){
      for(int y = -1; y <=1; y++){
        if(notNull(board.pieceAt(row + x, coll+ y)) && board.pieceAt(row + x, coll+ y).type == 0 && board.pieceAt(row + x, coll+ y).side == 1- this.side){
          return true;
        }
      }
    }
    return false;
  }
}
