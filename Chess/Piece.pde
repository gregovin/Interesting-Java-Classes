
class Piece{
  public int type;
  public int coll;
  public int row;
  public int side;
  public int moves_made;
  public PImage img;
  public Piece(int type, int coll, int row, String imgFilePath, int side) {
    this.type = type;
    this.coll = coll;
    this.row = row;
    this.moves_made = 0;
    this.side = side;
    img = loadImage(imgFilePath);
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
}
