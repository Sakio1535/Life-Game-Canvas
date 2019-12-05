// Game Of Life

int[][] grid;
int cols;
int rows;
int resolution = 10;
boolean a = false;

void setup() {
  frameRate(10);
  size(1200, 800);
  cols = width / resolution;
  rows = height / resolution;

  grid = new int[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j] = 0; //initial value
    }
  }
  gliderGenerate();
}

void draw() {
  background(0); 
  //check the state and draw cells
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int x = i * resolution;
      int y = j * resolution;
      if (grid[i][j] == 0) {
        fill(255);
        //display squares
        stroke(255);
        rect(x, y, resolution - 1, resolution - 1);
      }
    }
  }
  //when ENTER pressed
  if(a == true) {
    start();
  }
}

int countNeighbors(int[][] grid, int x, int y) {
  int sum = 0;
  for (int i = -1; i < 2; i++) {
    for (int j = -1; j < 2; j++) {
      int col = (x + i + cols) % cols;
      int row = (y + j + rows) % rows;
      sum += grid[col][row];
    }
  }
  sum -= grid[x][y];
  return sum;
}

void touch() {
  int x = floor(mouseX / resolution);
  int y = floor(mouseY / resolution);
  //black to white, white to black
  if(grid[x][y] == 1) {
    grid[x][y] = 0;
  } else if(grid[x][y] == 0) {
    grid[x][y] = 1;
  }
}

void start() {
    int[][] next = new int[cols][rows];
    // apply some rules of LifeGame, and computed livings start moving..
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        int state = grid[i][j];
        // check 8 living cells
        int neighbors = countNeighbors(grid, i, j);
  
        if (state == 0 && neighbors == 3) {
          next[i][j] = 1;
        } else if (state == 1 && (neighbors < 2 || neighbors > 3)) {
          next[i][j] = 0;
        } else {
          next[i][j] = state;
        }
      }
    }
    grid = next;
}

void mouseClicked() {
  touch();
}

void mouseDragged() { 
  touch();
}

void keyPressed() {  
  if(key == ENTER && a == false) {
    a = true;
  } else if(key == ENTER && a == true) {
    a = false;
  }
}


void gliderGenerate() {
  //Glider is cute!!
  grid[floor(cols/2) -1][floor(rows/2) -1] = 1;
  grid[floor(cols/2) -1][floor(rows/2)   ] = 1;
  grid[floor(cols/2) -1][floor(rows/2) +1] = 1;
  grid[floor(cols/2)   ][floor(rows/2) +1] = 1;
  grid[floor(cols/2) +1][floor(rows/2)   ] = 1;
}
