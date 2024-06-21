public class Display{
  Boggle b;
  char[][] board;
  int boardSize;
  float squareSize;
  float x0, y0;
  
  public Display(Boggle b){
    this.b = b;
    board = b.board;
    boardSize = b.boardSize;
    squareSize = (width / (2.5 * b.boardSize) + height / (2.5 * b.boardSize)) / 2;
    x0 = width / (2.5 * b.boardSize);
    y0 = width / (2.5 * b.boardSize);
  }
  
  public float displayGame(String word){
    background(255);
    drawBoard();
    displayWord(word);
    float x = displayWords();
    displayTime();
    return x;
  }
  
  public float[] bToPCoords(int row, int col){
    float x0 = width / 12;
    float y0 = height / 12;
    
    float[] coords = {x0 + squareSize * col, y0 + squareSize * row};
    return coords;
  }
  
  public int[] pToBCoords(float x, float y){
    
    float thisY = y0 - squareSize / 2;
    float nextY = thisY + squareSize;
    
    for (int i = 0; i < boardSize; i++){
      float thisX = x0 - squareSize / 2;
      float nextX = thisX + squareSize;
      
      if (y > thisY && y < nextY){
        for (int j = 0; j < boardSize; j++){
          if (x > thisX && x < nextX){
            return (new int[]{i, j});
          }
          thisX = nextX;
          nextX = thisX + squareSize;
        }
      }
      
      thisY = nextY;
      nextY = thisY + squareSize;
    }
    return null;
  }
  
  public float displayWords(){
    ArrayList<String> words = b.words;
    textSize(20);
    textAlign(LEFT);
    int currWord = 0;
    float x = x0 + squareSize * boardSize;
    while (currWord < words.size()){
      float longestWord = 0;
      float y = y0 - squareSize;
      while (currWord < words.size() && y < height){
        if (textWidth(words.get(currWord)) > longestWord){
          longestWord = textWidth(words.get(currWord));
        }
        text(words.get(currWord), x, y);
        y += 25;
        currWord++;
      }
      x += longestWord + 10;
    }
    textAlign(CENTER);
    return x;
  }
  
  public void displayWord(String word){
    textSize(squareSize / 1.5);
    float y = bToPCoords(boardSize - 1, 0)[1];
    y += 2 * squareSize;
    float halfWidth = (boardSize - 1) * squareSize / 2;
    float x = x0 + halfWidth;
    
    text(word, x, y);
  }
  
  public void displayTime() {
    textSize(60);
    text(convertToMMSS(b.time), 1300, 70);
  }
  
  public String convertToMMSS(int time) {
    int mins = time / 60;
    int secs = time - time / 60 * 60;
    String result = mins + ":";
    if (secs == 0) {
      result = result + secs + 0;
    } else if (secs < 10) {
      result = result + 0 + secs;
    } else {
      result += secs;
    }
    return result;
  }
  
  public void drawBoard(){
    fill(230);
    stroke(0);
    textSize(squareSize / 1.5);
    
    for (int i = 0; i < boardSize; i++){
      for (int j = 0; j < boardSize; j++){
        float[] coords = bToPCoords(i, j);
        rect(coords[0], coords[1], squareSize, squareSize);
      }
    }
    
    fill(0);
    
    for (int i = 0; i < boardSize; i++){
      for (int j = 0; j < boardSize; j++){
        float[] coords = bToPCoords(i, j);
        char currChar = board[i][j];
        text(currChar + "", coords[0], coords[1] + squareSize / 4);
      }
    }
  }
  
  public void displayRobotWords(String[][] robotsWords, float xToStart){
    textSize(20);
    textAlign(LEFT);
    fill(255, 0, 0);
    float x = xToStart;
    
    for (String[] words: robotsWords){
      int currWord = 0;
      while (currWord < words.length){
        float longestWord = 0;
        float y = y0 - squareSize;
        while (currWord < words.length && y < height){
          if (textWidth(words[currWord]) > longestWord){
            longestWord = textWidth(words[currWord]);
          }
          text(words[currWord], x, y);
          y += 25;
          currWord++;
        }
        x += longestWord + 10;
      }
    }
    textAlign(CENTER);
    fill(0);
  }
  
  public void displayScores(int[] scores){
    textAlign(LEFT);
    textSize(30);
    float y = y0 + squareSize * boardSize;
    
    text("Player's score: " + scores[0], x0, y);
    for (int i = 1; i < scores.length; i++){
      y += 40;
      int score = scores[i];
      text("Robot " + i + "'s score: " + score, x0, y);
    }
    textAlign(CENTER);
  }
}
