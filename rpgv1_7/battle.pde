class Battle {

  //variables used later to check if player has moved away from battle
  //before reinitialising
  int playX = 33;
  int playY = 33;
  //vertex variables for animation
  int vertX = 0;
  int vertY = 64;
   
  float playerHP;
  String[] playerMoves;
  boolean playerGo;
  String move;
  boolean playerWins;
  boolean movedAway = true;
  //Enemy variables
  int enemyIndex;
  float enemyHP;
  boolean enemyGo;
  String enemyName;
  String[] enemyMoves;
  int[] enemyDPs;
  int enemyMove;
  boolean enemyWins;
  
  //General variables
  boolean battle;
  boolean battleSetupDone, playerUseMove, enemyUseMove;
  //variables for HP display.
  int pBatX = 420; //player battle stat box X
  int pBatY = 375; //player battle stat box X
  float playerHPlen = 180; //max length of HP bar
  int eBatX = 20;
  int eBatY= 20;
  float enemyHPlen = 180; //max langth of HP bar
  //variables to remove enemy
  int currentMap, index;
  //dialog object for battles
  dialogBox battleDialog = new dialogBox();
 
  
  //Methods to start and end battles.
  void battleTrue(int _num, int _currMap, int i) {
    if(movedAway)
    battle = true;
    battleSetupDone = false;
    enemyIndex = _num;
    this.currentMap = _currMap;
    index = i;
  }
 
  void battleOver() {
    battle = false; //when the battles is over
    player.walkable = true; //make the player walkable
  }
  
   void winner(){
    if(playerWins){
      map.battles[this.currentMap][index][4] = 0; //hide enemy tile if player wins
    }
  }  
      
  void battleSetup() {
    //battle background
    fill(255);
    if (!battleSetupDone) {
      playX = player.posX;
      playY = player.posY;
      enemyGo = false;
      enemyWins = false;
      playerGo = false;
      playerWins = false;
      playerHP = player.getHP(); //get player object's HP
      enemyHP = enemies[enemyIndex].getHP(); //get enemy object's HP
      enemyName = enemies[enemyIndex].getEnemyName(); //get enemy object's name
      playerMoves = player.moves;
      enemyMoves = enemies[enemyIndex].moves;
      enemyDPs = enemies[enemyIndex].damagePoints;
      battleDialog.display(0, height-battleDialog.boxHeight, enemyName+" has engaged you in battle.");
      if (int(random(0, 7))==0) {
        enemyGo = true;
      } else {
        playerGo = true;
      }

      if (space) {
        space = false;
        battleSetupDone = true;
      }
    }
  }

  void enemyFight() {
    if (enemyGo && battleSetupDone && !playerGo) {
    battleDialog.display(0, height-battleDialog.boxHeight, "Wild "+enemyName+" used "+enemyMoves[enemyMove]+".");
    if (space) {
      space = false;
      if(playerHP > enemyDPs[enemyMove]){
        playerHP -= enemyDPs[enemyMove];
      }else{
        playerHP -= playerHP;
      } 
      enemyGo = false;
      playerUseMove = false;
      if (playerHP > 0){
        playerGo = true;
      } else {
        enemyWins = true;
        playerBattleFaint();
      }
    }
  }
  }


  void playerGo() {
    if (playerGo && battleSetupDone && !enemyGo) {
      if (!playerUseMove) {
        battleDialog.display(0, height-battleDialog.boxHeight, "Move to use?");        
        text("1. "+player.moves[0], battleDialog.boxX+32, battleDialog.boxY+64);
        text("2. "+player.moves[1], battleDialog.boxX+32, battleDialog.boxY+96);
        text("3. "+player.moves[2], battleDialog.boxX+96, battleDialog.boxY+64);
        text("4. "+player.moves[3], battleDialog.boxX+96, battleDialog.boxY+96);
      } 
      if (keyPressed && key == '1') {
        move = playerMoves[key-49];
        playerUseMove = true;
      }
      if (keyPressed && key == '2') {
        move = playerMoves[key-49];
        playerUseMove = true;
      }
      if (keyPressed && key == '3') {
        move = playerMoves[key-49];
        playerUseMove = true;
      }
      if (keyPressed && key == '4') {
        move = playerMoves[key-49];
        playerUseMove = true;
      }
      if (playerUseMove) {
        battleDialog.display(0, height-battleDialog.boxHeight, "Player used "+move);
        if (space && !enemyGo) {
          if(enemyHP > 5){ //********** CHANGE THESE LINES TO REFLECT ******************
            enemyHP -= 5; //*********** DAMAGE CAUSED BY CHOSEN MOVE *****************
          } else {
            enemyHP -= enemyHP;
          } 
          space = false;
          playerUseMove = false;
          playerGo = false;
          if (enemyHP > 0) {
            enemyMove = (int)random(0, enemyMoves.length);
            enemyGo = true;
          }
          else {
            playerWins = true;
            player.setExp(player.getExp()+10);
            winner();
          }
        }
      }
    }
  }

  void battling() {
   // println("PlayerHP: "+playerHP);
    image(grassBg, 0, 0, 640, 640);
    drawEnemy();
    if (!battleSetupDone)
      battleSetup();
    drawStatsDisplay();
    if (playerGo)
      playerGo();
    if (enemyGo)
      enemyFight();  
    if (playerWins){
        //display dialog for level up
        if(player.getExp() >= 40){ //for example purposes only, however could be set to have varying numbers for each level up.
           battleDialog.display(0, height-battleDialog.boxHeight, "You win! Hooray! \nYou have gained 10 EXP. New EXP is 50. \nYou have leveled up to LEVEL"+player.getLevel()+".");      
        } else {  //display dialog to advise of exp point gained
          battleDialog.display(0, height-battleDialog.boxHeight, "You win! Hooray! \nYou have gained 10 EXP. New EXP is "+(player.getExp())+"."); 
        }
        if(space){
          space = false;
          battleOver();
        }         
    }
    if (enemyWins){
        battleDialog.display(0, height-battleDialog.boxHeight, enemyName+" has defeated you, you loose £<money>"); //to-do sort money variable 
        if(space){
          space = false;
          battleOver();
        }         
    }
  }


  void drawStatsDisplay() {  
    //player
    fill(0);
    rect(pBatX, pBatY, 200, 80, 5);
    fill(255);
    textFont(font, 16);
    text("Player HP: "+(int)playerHP+" / "+player.HP, pBatX+65, pBatY+30);
    rect(pBatX+10, pBatY+50, playerHPlen*(playerHP/player.HP), 10, 5);
    //enemy
    fill(0);
    rect(eBatX, eBatY, 200, 80, 5);
    fill(255);
    textFont(font, 16);
    text("Enemy HP: "+(int)enemyHP+" / "+enemies[enemyIndex].HP, eBatX+65, eBatY+30);
    stroke(0);
    rect(eBatX+10, eBatY+50, enemyHPlen*(enemyHP/enemies[enemyIndex].HP), 10, 5);
  }
  
  void drawEnemy(){
     animate();
     beginShape();
            texture(enemiesImg[enemyIndex]);
            vertex(width/2,0, vertX, vertY);
            vertex(width, 0,  vertX+32, vertY);
            vertex(width, height/2, vertX+32, vertY+32);
            vertex(width/2, height/2, vertX, vertY+32);
      endShape(CLOSE); 
  
  }
  
  void animate(){
    if(frameCount % 15 == 0){
      if(vertX >= 32*2)
      vertX = 0;
      else
      vertX +=32;
      }
  }
  
  void resetBattle(){
     if(dist(playX, playY, player.posX, player.posY) > 32){
       movedAway = true;
     } 
  }  
  
  void playerBattleFaint(){
        setMap(1);
        player.setX(320);
        player.setY(320);
  }

} //end of class

