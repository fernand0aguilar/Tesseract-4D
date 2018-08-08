class Matrix {
  int rows;
  int cols;
  float[][] data;

  Matrix(int rows, int cols) {
    this.rows = rows;
    this.cols = cols;
    this.data = new float[rows][cols];
  }

  Matrix(float[][] data) {
    this.rows = data.length;
    this.cols = data[0].length;
    this.data = new float[rows][cols];

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        this.data[r][c] = data[r][c];
      }
    }
  }

  void log() {
    println("---------------------");
    println(this.rows + " x " + this.cols);
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        print(this.data[r][c] + "   ");
      }
      println();
    }
    println("---------------------/n");
  }
  
  Matrix mult(Matrix b){
    if(this.cols != b.rows){
      println("Columns of A must match rows of B.");
      return null;
    }
    
    Matrix result = new Matrix(this.rows, b.cols);
    for(int i = 0; i < result.rows; i++){
      for(int j = 0; j < result.cols; j++) {
        float sum = 0;
        for(int k = 0; k < this.cols; k++){
          sum += this.data[i][k] * b.data[k][j];
        }
        result.data[i][j] = sum;
      }
    }
    return result;
  }
}
