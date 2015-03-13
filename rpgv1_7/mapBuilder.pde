class mapBuilder {


  tile[][] tile;
  map mapname;


  boolean walk;
  int visible;

  mapBuilder(int _map[][]) {
    tile = new tile[_map.length][_map.length];
    for (int x = 0; x < _map.length; x++) {
      for (int y = 0; y < _map.length; y++) {
        walk = true;
        if (_map[x][y] >= 184) 
          walk = false;
        tile[x][y] = new tile(_map[x][y], walk, y*32, x*32);
      }
    }
  }  

  void drawMap() {
    for (int x = 0; x < tile.length; x++) {
      for (int y = 0; y < tile.length; y++) {
        tile[x][y].display();
      }
    }
  }


  void drawEnemyTiles() {
    int _curr = currentMap;
    for (int e = 0; e < enemies.length; e++) {
      enemies[e].enemyTileAnimation();
      for (int i = 0; i < map.battles[_curr].length; i++) {  
        //if the enemy is visible and their num is part of enemies array
        if (map.battles[_curr][i][4] == 1 && map.battles[_curr][i][5] <= enemies.length) {
          beginShape();
          texture(enemiesImg[map.battles[_curr][i][5]]);
          vertex(map.battles[_curr][i][0], map.battles[_curr][i][1], enemies[e].vertX, enemies[e].vertY);
          vertex(map.battles[_curr][i][0]+32, map.battles[_curr][i][1], enemies[e].vertX+32, enemies[e].vertY+0);
          vertex(map.battles[_curr][i][0]+32, map.battles[_curr][i][1]+32, enemies[e].vertX+32, enemies[e].vertY+32);
          vertex(map.battles[_curr][i][0], map.battles[_curr][i][1]+32, enemies[e].vertX+0, enemies[e].vertY+32);
          endShape(CLOSE);
        }
      }
    }
  }

  void setMap(int _map) {
    currentMap = _map;
  }

  void switchMap(int _curr) {
  //function takes currentMap as an parameter and uses it to acccess the relevant moveMap data
  //takes the relevant information and switches map and player position.
    for (int i = 0; i < map.moveMap[_curr].length; i++) {  
      if (player.posX >= map.moveMap[_curr][i][0] && player.posY == map.moveMap[_curr][i][1]
        && player.posX <= map.moveMap[_curr][i][0]+32 && player.posY == map.moveMap[_curr][i][1]) {
        player.setX(map.moveMap[_curr][i][3]); 
        player.setY(map.moveMap[_curr][i][4]); 
        setMap(map.moveMap[_curr][i][2]); 
      }
    }
  }

  void dialogTrigger(int _curr) {
  //function takes currentMap as a parameter and uses it to access the relevant dialog array
  //sets dialog box to be visiible and passes relevant text to display  
  for (int i = 0; i < map.dialogs[_curr].length; i++) {  
      if (player.posX == int(map.dialogs[_curr][i][0]) && player.posY == int(map.dialogs[_curr][i][1])) {
        dialogBox.display = true; 
        dialogBox.displayTextBox(0, height-dialogBox.boxHeight, map.dialogs[_curr][i][2]);
      }
    }
  }

  void battleTrigger(int _curr) {
    //function takes currentMap as parameter and uses this to access relevant array
    //checks if player is within the specified area and if so triggers the battle functions.
    for (int i = 0; i < map.battles[_curr].length; i++) {  
      if (player.posX >= map.battles[_curr][i][0] && player.posY >= map.battles[_curr][i][1]
        && player.posX <= map.battles[_curr][i][2]+32 && player.posY <= map.battles[_curr][i][3]+32) {
        visible = map.battles[_curr][i][4];
        if (visible == 1) { //if the enemy is visible (1)
          if (map.battles[_curr][i][5] < enemies.length) {//if the number is a valid number of an enemy
            battle.battleTrue(map.battles[_curr][i][5], _curr, i); //trigger a battle with enemies
          } else {
            int chance = int(random(990, 1000)); //generate random number
            if (chance == map.battles[_curr][i][5]) { //if random number is equal to 999
              battle.battleTrue(int(random(0, enemies.length)), _curr, i); //trigger random battle
            }
          }
        }
      }
    }
  }//end of battle trigger
  
  
} //end of class

