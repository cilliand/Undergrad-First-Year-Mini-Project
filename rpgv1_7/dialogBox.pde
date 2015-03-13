class dialogBox {

  int boxHeight;
  int boxWidth;

  int boxX, boxY;

  //String text;
  int playX;
  int playY;
  boolean movedAway= true;
  boolean display = true;


  dialogBox(int _height, int _width) {
    boxHeight = _height;
    boxWidth = _width; 
    // text = _text;
  }


  dialogBox() {
    boxHeight = 160;
    boxWidth = 640;
    // text = _text;
  }

  void resetDialogBox() {
    if (dist(playX, playY, player.posX, player.posY) > 32) {
      movedAway = true;
    }
  } 
  void displayTextBox(int _x, int _y, String dialog) {

    boxX = _x;
    boxY = _y;

     if (movedAway) {
      player.walkable = false;
      //Dialogbox Shape
      beginShape(QUADS);
      texture(dialogBg);
      vertex(boxX, boxY, 0, 0);
      vertex(boxX+boxWidth, boxY, 0, 640);
      vertex(boxX+boxWidth, boxY+boxHeight, 640, 640);
      vertex(boxX, boxY+boxHeight, 0, 640);
      endShape(CLOSE);

      fill(0);
      textFont(font, 14);
      text(dialog, boxX+32, boxY+32);
      if (space) {
        space = false;
        movedAway = false;
        playX = player.getX();
        playY = player.getY();
        display = false;
        player.walkable = true;
      }
    }
  } 

  void display(int _x, int _y, String _text) {

    boxX = _x;
    boxY = _y;

    player.walkable = false; 
    //Dialogbox Shape
    beginShape(QUADS);
    texture(dialogBg);
    vertex(boxX, boxY, 0, 0);
    vertex(boxX+boxWidth, boxY, 0, 640);
    vertex(boxX+boxWidth, boxY+boxHeight, 640, 640);
    vertex(boxX, boxY+boxHeight, 0, 640);
    endShape(CLOSE);

    fill(0);
    textFont(font, 14);
    text(_text, boxX+32, boxY+32);
  }
}

