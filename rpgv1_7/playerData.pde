class playerData {

  boolean display = false;
  int statBoxHeight = 320;
  int statBoxWidth = 320;
  int vertX = 0; 
  int vertY = 0;

  void show() {
    display = !display;
  }

  boolean display() {
    if (display) {
      image(dialogBg, 0, 0, statBoxWidth, statBoxHeight);
      fill(0);
      textFont(font, 14);
      text("PLAYER STATS:", 32, 32);
      text("LEVEL: "+player.getLevel(), 32, 64);
      text("HP: "+player.getHP(), 32, 96);
      text("EXP: "+player.getExp(), 32, 128);
      playerImage(); //call to display player's image
      return true;
    }
    return false;
    
  } //end of display

  void playerImage() {
    animateVerts();
    beginShape();
    pushMatrix();
    texture(playerImg);
    translate(210, 32);
    scale(2);
    noStroke();
    vertex(0, 0, vertX, vertY);
    vertex(0, 32, vertX, vertY+32);
    vertex(32, 32, vertX+32, vertY+32);
    vertex(32, 0, vertX+32, vertY);
    endShape(CLOSE); 
    popMatrix();
  }

  void animateVerts(){
    if (frameCount%15 == 0) {
      if (vertY >= 96){
        vertY = 0;
      } else {
        vertY += 32;
      }
    }
  }
}//end of class

