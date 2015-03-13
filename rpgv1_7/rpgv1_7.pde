  introScreen introScreen = new introScreen();
  
  int currentMap = 0;
  map map = new map();
  saveLoad saveLoad = new saveLoad();
  playerData playerData = new playerData();
  mapBuilder[] mapBuilder = new mapBuilder[4];
  
  player player = new player(width/2, height/2);
  enemy[] enemies = new enemy[2];
  PImage[] enemiesImg = new PImage[2];
  dialogBox dialogBox = new dialogBox();
  Battle battle = new Battle();
  Menu menu = new Menu(240, 240);
  
  PImage sprites, playerImg, dialogBg, grassBg;
  PFont font;
  boolean space;
  
  void setup() {
    size(640, 640, P3D);
    //load sprite sheets and images
    sprites = loadImage("sprite2.png");
    playerImg = loadImage("roshan.png");
    dialogBg = loadImage("dialogBox.png");
    grassBg = loadImage("grass.jpg");
    //load font
    font = loadFont("Tahoma-48.vlw");
    
    //load all maps into mapBuilder array so they can be drawn
    for (int i = 0; i < map.maps.length; i++) {
      mapBuilder[i] = new mapBuilder(map.maps[i]);
    }
  
    enemySetup();
    frameRate(30);
  }
  
  void draw() {
    if (introScreen.visible()) {
      introScreen.display();
    } else {
      mapBuilder[currentMap].drawMap(); //call to draw map from mapBuilder.
      mapBuilder[currentMap].switchMap(currentMap);
      mapBuilder[currentMap].drawEnemyTiles();
      player.drawPlayer(); //draw player
      player.movePlayer(); //move player
      mapBuilder[currentMap].dialogTrigger(currentMap); //trigger dialog for current map
      dialogBox.resetDialogBox(); //call reset dialog box function
  
      menu.displayGameMenu(width-menu.boxWidth, 0); //displays menu as required
      playerData.display();
  
      if (battle.battle) { //if battle variable is set to true
        //battle.battleAnim();
        battle.battling(); //call function to battle
      } else {
        mapBuilder[currentMap].battleTrigger(currentMap);
        battle.resetBattle();
      }
    }
    
    if(saveLoad.showSave && !space){ 
        dialogBox.displayTextBox(0,0,"Saved.");
    }else{
      saveLoad.showSave = false;
    }
    
  } //end of draw
  
  
  
  void keyPressed() {
    if (key == ' ')
      space = true;

    if (key == 'q'){
      battle.battleOver();
      battle.movedAway = false;
    }

    //movement keys and variables  
    if (keyCode == UP) {
      player.up = true;
      player.down = false;
      player.left = false;
      player.right = false;
    }
  
    if (keyCode == DOWN) {
      player.down = true;
      player.up = false;
      player.left = false;
      player.right = false;
    }
  
    if (keyCode == LEFT) {
      player.left = true;
      player.up = false;
      player.down = false;
      player.right = false;
    }
  
    if (keyCode == RIGHT) {
      player.right = true;  
      player.up = false;
      player.left = false;
      player.down = false;
    }
  
    if (keyCode == ENTER && !battle.battle) {
      menu.display = !menu.display;
      if(playerData.display()){
          playerData.show();
      }
      player.walkable = !player.walkable;
    }
  }
  
  void keyReleased() {
    //reset vertex X, ensures player doesn't get stuck with in a position e.g. "leg in the air"
    player.vertX = 0; 
    //variable for displaying and hiding dialog
    if (key == ' ') 
      space = false;
    //movement key variables  
    if (keyCode == UP)
      player.up = false;
    if (keyCode == DOWN)
      player.down = false;
    if (keyCode == LEFT)
      player.left = false;
    if (keyCode == RIGHT)
      player.right = false;  
    //end of movement key variables
  }
  
  void mouseClicked() {
    if (menu.savePressed()){
      saveLoad.save();
      saveLoad.showSave = true;
    }
    if (menu.quitPressed())
      exit();
    if (menu.loadPressed())
      saveLoad.load();
    if(menu.statsPressed())
      playerData.show();
    if (introScreen.visible()) {
      introScreen.select(introScreen.index);
    }
    
  }
  
  void stop() {
    saveLoad.output.close(); //close saveGame file just incase.
  }
  
  void enemySetup() { //seperate enemy setup to avoid "bulking" main setup()
    enemies[0] = new enemy(3, "Gigantic Bee", 0, "Sting", "Flap");
    enemiesImg[0] = loadImage("bee.png");
    enemies[1] = new enemy(3, "Large Bat", 1, "Bite", "Screech");
    enemiesImg[1] = loadImage("bat.png");
  }

  void setMap(int _map){
    currentMap = _map;
  }
