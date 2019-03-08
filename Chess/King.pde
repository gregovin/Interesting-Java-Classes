class King extends Piece{
  //specific constructor, puts the king in the right starting location
  public King(int side, String imgFilePath) {
    super(0 , 3, 7 * side, imgFilePath, side);
  }
  //arbitrary location constructor, puts the king in an arbitrary position
  public King(int side, String imgFilePath, int row, int coll){
    super(0 , coll, row, imgFilePath, side);
  }
  //generic constructor, used for cloning the king
  public King(int side, String imgFilePath, int row, int coll, int movesMade, int turnsSinceLast){
    super(0 , coll, row, imgFilePath, side, movesMade, turnsSinceLast);
  }
  //check if it is a valid move
  public boolean valid_move(int newRow, int newColl, Board board){
    if(Math.abs(newRow - row) > 1 || Math.abs(newColl - coll) > 2){//if we are trying to go more than 1 row or 2 colls
       return false;//we can't
     } else if(newColl - coll == 2 && ! this.inCheck(board)){//if we are going 2 colls to the left and we arn't in check
       println("attempting to castle queenside");//print a diagonstic for my sanity
       Piece corner = board.pieceAt(7 * side, 7);//get the cornerpiece
       if(!notNull(corner) || corner.type != 2 || corner.moves_made !=0 || this.moves_made != 0 || 
           notNull(board.pieceAt(7 * side, 6)) || notNull(board.pieceAt(7 * side, 5)) || notNull(board.pieceAt(7 * side, 4)) || this.inCheck(board)){
              //if the corner piece is null or not a rook or has made a move
              //or we have made a move or is in check
              //or there are pieces in the way
              println("failed due to lack of neccesary conditions");//we failed to castle
              return false;
       }
       if(board.move(7 *side, 7, 7 * side, newColl-1)){//if we can move the rook where it needs to go
         board.teleport(7 * side, newColl-1, 7 * side, 7);//put it back
         undoMove();//undo the move
         if(board.move(this.row, this.coll, 7 * side, newColl-1)){//if we can move the king one square in the right direction
           undoMove();//undo the move, but keep the position and stuff
            if(board.move(this.row, this.coll, 7 * side, newColl)){//if we can move the king another square
               board.teleport(7 * side, 7, 7 * side, newColl-1);//teleport the rook to the right place
               println("casle succeded");//we did it
               undoMove();//undo move to keep the timer and stuff in sink
               return true;//yay
           }
         }
       }
       println("rook or king could not move");//something went wong
       this.moves_made =0;//reset
       corner.moves_made = 0;
       return false;//can't do it
     } else if(newColl - coll == -2){//if we are going to the right
       println("attempting to castle kingside");//system dialog for my sanity
       Piece corner = board.pieceAt(7 * side, 0);//get the corner piece
       if(!notNull(corner) || corner.type != 2 || corner.moves_made !=0 || this.moves_made != 0 ||
               notNull(board.pieceAt(7 * side, 1)) || notNull(board.pieceAt(7 * side, 2)) || this.inCheck(board)){
          //if there is no corner piece or it is not a rook or it has made a move
          //or this piece has made a move or is in check
          //or something is in the way
         return false;//we can't
       }
       if(board.move(7 * side, 0, 7 * side, newColl+1)){//can we move the rook to the right place?
         board.teleport(7*side, newColl+1, 7*side, 0);//put it back
         undoMove();//undo the move
         if(board.move(this.row, this.coll, 7*side, 2)){//if we can move the king one square
           undoMove();//make sure the timers and stuff are right
           if(board.move(this.row, this.coll, 7*side, newColl)){//can we move one more square?
             board.teleport(7*side, 0, 7*side, newColl+1);//teleport the rook
             undoMove();//sink the timers and stuff
             return true;//we did it
           }
         }
       }
       println("rook or king could not move");//something whent horribly wrong
       this.moves_made =0;//reset
       corner.moves_made = 0;
       return false;//nope
     }
     if(notNull(board.pieceAt(newRow, newColl)) && board.pieceAt(newRow, newColl).side == 1 - this.side){//if we can capture
       movesSinceIrreversible = -1;//we did an irreversible
       return true;//we can move
     } else if(notNull(board.pieceAt(newRow, newColl))) return false;//there is a piece their of my color, nope
     return true;//we can do it
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
