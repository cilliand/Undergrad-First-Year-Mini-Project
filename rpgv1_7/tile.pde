class tile {
  boolean isWalkable;
  boolean isDoor;
  int doorTo;

  int tileX, tileY;
  int number;
  int tileArray[][];

  int spriteColumn, spriteRow;

  tile(int num, boolean walk, int _x, int _y) {
    number = num; 
    isWalkable = walk;
    tileX = _x;
    tileY = _y;
  }

  void display() {
    doSpriteRow(number); 
    noStroke();

    beginShape(QUADS);
    if (number < 999) {
      texture(sprites); //if number is part of the sprite sheet text with sprite
    } else {  //otherwise
      fill(0); //fill black
    }

    vertex(tileX, tileY, 0+32*spriteColumn, 0+32*spriteRow);
    vertex(tileX+32, tileY, 32+32*spriteColumn, 0+32*spriteRow);
    vertex(tileX+32, tileY+32, 32+32*spriteColumn, 32+32*spriteRow);
    vertex(tileX, tileY+32, 0+32*spriteColumn, 32+32*spriteRow);

    endShape(CLOSE);
  }

  //takes tile's value and calculates where in sprite sheet the image for that tile is.  
  void doSpriteRow(int value) {
    spriteColumn = value-64*(value/64); //calculate which sprite to display based on tile's value
    spriteRow = floor(value/64); //calculae row of sprite sheet based pn tile's value
  }
}// end of class

