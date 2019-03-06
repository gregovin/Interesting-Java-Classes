
class Piece{
  public int type;
  public int coll;
  public int turnsSinceLast;
  public int row;
  public int side;
  public int moves_made;
  public String imgFilePath;
  public PImage img;
  public Piece(int type, int coll, int row, String imgFilePath, int side) {
    this(type, coll, row, imgFilePath, side, 0, side - 1);
  }
  public Piece(int type, int coll, int row, String imgFilePath,int side, int movesMade, int turnsSinceLast){
    this.type = type;
    this.coll = coll;
    this.row = row;
    this.moves_made = movesMade;
    this.side = side;
    this.turnsSinceLast = turnsSinceLast;
    this.imgFilePath= imgFilePath;
    img = loadImage(imgFilePath);
  }
  public Piece clone(){
    if(this instanceof Pawn){
      return new Pawn(side, imgFilePath, coll, row, moves_made, turnsSinceLast);
    } else if(this instanceof Bishop){
      return new Bishop(side, imgFilePath, row, coll, moves_made, turnsSinceLast);
    } else if(this instanceof King){
      return new King(side, imgFilePath, row, coll, moves_made, turnsSinceLast);
    } else if(this instanceof Knight){
      return new Knight(side, imgFilePath, row, coll, moves_made, turnsSinceLast);
    } else if(this instanceof Queen){
      return new Queen(side, imgFilePath, row, coll, moves_made, turnsSinceLast);
    } else if(this instanceof Rook){
      return new Rook(side, imgFilePath, row, coll, moves_made, turnsSinceLast);
    }
    return new Piece(this.type, this.coll, this.row, this.imgFilePath, this.side);
  }
  public String toString(){
    return "Piece: " + "(" + this.type + ", " + this.row + ", " + this.coll + ", " + this.side + ")"; 
  }
  public boolean equals(Piece p){
    return this.type == p.type && this.coll == p.coll && this.row == p.row && this.side == p.side;
  }
  public void display(){
    image(img, (7 -coll) * 32 + SIDE_OFFSET, (7-row) * 32 + TOP_OFFSET, SQUARE_WIDTH, SQUARE_HEIGHT);
  }
  public void teleport(int newRow, int newColl){
    this.row = newRow;
    this.coll = newColl;
  }
  public boolean valid_move(int newRow, int newColl, Board board){
     return board.inBoard(newRow, newColl); 
  }
  public boolean move(int newRow, int newColl, Board board) {
    if(this.valid_move(newRow, newColl, board)) {
      this.row = newRow;
      this.coll = newColl;
      moves_made ++;
      return true;
    }
    return false;
  }
  public boolean inCheck(Board board){
    return false;
  }
  public void updateTurns(){
    if (moves_made != 0){
      turnsSinceLast ++;
    }
  }
}
