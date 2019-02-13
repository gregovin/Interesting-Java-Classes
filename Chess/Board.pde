import javax.swing.JOptionPane;
public class Board{
  public Piece[][] piecelist;
  public Piece pieceAt(int row, int coll){
    if(!inBoard(row, coll)){
      return null;
    }
    return piecelist[row][coll];
  }
  public Piece[] kings(){
    Piece[] res = new Piece[2];
    for(Piece[] pl : piecelist){
      for(Piece p : pl){
        if(notNull(p) && p.type == 0){
          res[p.side] = p;
        }
      }
    }
    return res;
  }
  public boolean inBoard(int row, int coll){
    return row >= 0 && row <= 7 && coll >= 0 && coll <= 7;
  }
  public void teleport(int currow, int curcol, int newrow, int newcol){
    Piece moving = piecelist[currow][curcol];
    if(notNull(moving) && inBoard(newrow, newcol)){
      moving.teleport(newrow, newcol);
      piecelist[currow][curcol] = null;
      piecelist[newrow][newcol] = moving;
    }
  }
  public boolean move(int currow, int curcol, int newrow, int newcol){
    Piece moving = piecelist[currow][curcol];
    if(notNull(moving) && inBoard(newrow, newcol) && moving.side == turn){
      moving.teleport(newrow, newcol);
      piecelist[currow][curcol] = null;
      Piece temp = piecelist[newrow][newcol];
      piecelist[newrow][newcol] = moving;
      if(kings()[moving.side].inCheck(this)){
        moving.teleport(currow, curcol);
        piecelist[currow][curcol] = moving;
        piecelist[newrow][newcol] = temp;
        return false;
      } else {
        moving.teleport(currow, curcol);
        piecelist[currow][curcol] = moving;
        piecelist[newrow][newcol] = temp;
        if(moving.move(newrow,newcol, this)){
          piecelist[newrow][newcol] = moving;
          piecelist[currow][curcol] = null;
          times[turn].stop();
          turn = 1 - turn;
          times[turn].start();
          if(empesa){
            piecelist[currow][newcol] = null;
            empesa = false;
          }
          if(promotes){
             Object selectedValue = JOptionPane.showInputDialog(null,
             "Promotes To", "Pieces",
             JOptionPane.INFORMATION_MESSAGE, null,
             possibleValues, possibleValues[0]);
            if(selectedValue.equals("Queen")){
              piecelist[newrow][newcol] = new Queen(moving.side, "img/" + sides[moving.side] + "Queen.png", newrow, newcol);
            } else if(selectedValue.equals("Knight")){
              piecelist[newrow][newcol] = new Knight(moving.side, "img/" + sides[moving.side] + "Knight.png", newrow, newcol);
            } else if(selectedValue.equals("Bishop")){
              piecelist[newrow][newcol] = new Bishop(moving.side, "img/" + sides[moving.side] + "Bishop.png", newrow, newcol);
            } else {
              piecelist[newrow][newcol] = new Rook(moving.side, "img/" + sides[moving.side] + "Rook.png", newrow, newcol);
            }
            promotes = false;
          }
          if(turn == 1){
            for(Piece[] pl : piecelist){
              for(Piece p: pl){
                if(notNull(p)) p.updateTurns();
              }
            }
          }
          return true;
        }
        return false;
      }
    }
    return false;
  }
  public Board(){
    piecelist = new Piece[8][8];
    piecelist[0][0] = new Rook(0, "img/whiteRook.png", 0);
    piecelist[0][7] = new Rook(0, "img/whiteRook.png", 7);
    piecelist[7][0] = new Rook(1, "img/blackRook.png", 0);
    piecelist[7][7] = new Rook(1, "img/blackRook.png", 7);
    piecelist[0][1] = new Knight(0, "img/whiteKnight.png", 1);
    piecelist[0][6] = new Knight(0, "img/whiteKnight.png", 6);
    piecelist[7][1] = new Knight(1, "img/blackKnight.png", 1);
    piecelist[7][6] = new Knight(1, "img/blackKnight.png", 6);
    piecelist[0][2] = new Bishop(0, "img/whiteBishop.png", 2);
    piecelist[0][5] = new Bishop(0, "img/whiteBishop.png", 5);
    piecelist[7][2] = new Bishop(1, "img/blackBishop.png", 2);
    piecelist[7][5] = new Bishop(1, "img/blackBishop.png", 5);
    piecelist[0][3] = new King(0, "img/whiteKing.png");
    piecelist[7][3] = new King(1, "img/blackKing.png");
    piecelist[0][4] = new Queen(0, "img/whiteQueen.png");
    piecelist[7][4] = new Queen(1, "img/blackQueen.png");
    for(int i = 0; i < 8; i++) {
      piecelist[1][i] = new Pawn(0, "img/whitePawn.png", i);
      piecelist[6][i] = new Pawn(1, "img/blackPawn.png", i);
    }
  }
}
