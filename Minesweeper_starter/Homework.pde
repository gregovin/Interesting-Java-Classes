import java.util.Random;
void initGrid(){
  squares = new Square[ROWS][COLS];
  gameOver = false;
  Random generator = new Random();
  boolean[][] mineLs = randomList(ROWS, COLS, MINES, generator);
  for(int i = 0; i < ROWS; i ++){
    for(int j = 0; j < COLS; j ++){
      squares[i][j] = new Square(mineLs[i][j], i, j);
    }
  }
}
boolean[][] randomList(int rows,int colls,int number, Random generator){
  boolean[][] result = new boolean[rows][colls];
  while(number > 0){
    int row = generator.nextInt(rows);
    int coll = generator.nextInt(colls);
    if(!result[row][coll]){
      result[row][coll] = true;
      number --;
    }
  }
  return result;
}
void reveal(int row, int coll){
  if(gameOver ||squares[row][coll].flaged){
  
  }else {
    squares[row][coll].calcAdjMines();
    int contents = squares[row][coll].reveal();
    if(contents == 0){
      for(int i = (row == 0) ? 0 : row-1; i <= ((row == ROWS-1) ? ROWS - 1 : row + 1); i ++){
        for(int j = (coll == 0) ? 0 : coll - 1; j <= ((coll == COLS-1) ? COLS -1 : coll + 1); j ++){
          if(i != row || j != coll) reveal(i, j);
        }
      }
    }else if(contents == 9) gameOver = true;
  }
}
void displaySquares(){
  for(int i = 0; i < ROWS; i ++){
    for(int j = 0; j < COLS; j ++){
      squares[i][j].display(LEFT_OFFSET, TOP_OFFSET, SQUARE_WIDTH, SQUARE_HEIGHT);
    }
  }
}
public static boolean between(int a, int lower, int upper) {
  return (a >= lower) && (a <= upper);
}
void reset(){
  initGrid();
}