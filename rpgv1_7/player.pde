class player {

  int posX;
  int posY;

  int playerW, playerH;

  int eventTrigger;
  boolean dialogTrigger;
  int HP; // to be changed later
  int level = 1;
  int EXP;
  int money;
  boolean up, down, left, right;
  boolean walkable = true;

  String[] moves = {
    "Slice", "Cut", "Punch", "Headbutt" 
  };

  int vertX = 0;
  int vertY = 0;

  player(int _x, int _y) {
    posX = _x;
    posY = _y;
    playerW = 32;
    playerH = 32;
    setHP();
  }
  //trigger dialog using current map (_curr)//
  
  void drawPlayer() {
    beginShape();
    texture(playerImg);
    vertex(posX, posY, vertX, vertY);
    vertex(posX+32, posY, vertX+32, vertY+0);
    vertex(posX+32, posY+32, vertX+32, vertY+32);
    vertex(posX, posY+32, vertX+0, vertY+32);
    endShape(CLOSE);
  }

  void movePlayer() {
      if (walkable) {  
        if (up && posY > 0 && mapBuilder[currentMap].tile[(posY/32)][(posX)/32].isWalkable
                                                                        && mapBuilder[currentMap].tile[(posY/32)][(posX+31)/32].isWalkable){ // && mapBuilder[currentMap].tile[(posY/32)][(posX+16)/32].isWalkable) {
          posY -= 8;
          vertY = 96;
          animatePlayer();
          dialogBox.display = true;
        }

        if (down && posY+8 <= (mapBuilder[currentMap].tile.length-1)*32 && mapBuilder[currentMap].tile[(posY/32)+1][(posX)/32].isWalkable
                                                                        && mapBuilder[currentMap].tile[(posY/32)+1][(posX+31)/32].isWalkable) {
          posY+=8;
          vertY = 0;
          animatePlayer();
          dialogBox.display = true;
        }

        if (right && posX+8 <= (mapBuilder[currentMap].tile.length-1)*32 && mapBuilder[currentMap].tile[(posY+24)/32][(posX)/32+1].isWalkable) {
          posX+=8;
          vertY = 64;
          animatePlayer();
          dialogBox.display = true;
        }

        if (left && posX-8>=0 && mapBuilder[currentMap].tile[(posY+16)/32][(posX/32)].isWalkable) {
          posX -= 8;
          vertY = 32;
          animatePlayer();
          dialogBox.display = true;
        } 
    }
    
  }

  void animatePlayer() {

    if (vertX >= 96) {
      vertX = 0;
    }
    else {
      vertX += 32;
    }
  }

  int getX() {
    return posX;
  }

  int getY() {
    return posY;
  }
  
  void setX(int _x){
    posX = _x;
  }
  void setY(int _y){
    posY = _y;
  }
  int getHP() {
    return HP;
  }

  int getLevel() {
    return level;
  }
  
  void setLevel(int _level){
    level = _level;
    setHP();
  }
  
  void setHP(){
    HP = 15*getLevel();
  } 
  
  void setExp(int _exp){
    EXP = _exp;
    if(EXP >= 50){
      setLevel(getLevel()+1);
    }
   }
  
  int getExp(){
    return EXP;
  }
}

