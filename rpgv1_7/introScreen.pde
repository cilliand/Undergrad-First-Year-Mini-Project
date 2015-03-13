class introScreen{
  
  String newGame = "New Game";
  String loadGame = "Load Game";
  boolean visible = true;
  int index = 0;
  
  boolean select;
  
  boolean visible(){
    return visible;
  }
  void display(){
    background(0);
    textFont(font, 18);
    text(newGame, width/2-((newGame.length()+1)*9), height/2);
    text(loadGame, width/2-(loadGame.length()*9), height/2+36);
    hover();
    }
  
   
  void hover(){
    if(mouseX >= width/2-((newGame.length()+1)*9) && mouseX <= width/2){
         if(mouseY >= height/2-18 && mouseY <= height/2){ //-((newGame.length()+1)*9)+newGame.length()*9)
            newGame = "> New Game";
            index = 0;
            }else{
            newGame = "New Game";
            }
         if(mouseY >= height/2+18 && mouseY <= height/2+36){
            loadGame = "> Load Game";
            index = 1;   
         }else{
           loadGame = "Load Game";
         }
    } else {
      index = -1;
    }
  }
  
  void select(int _index){
    switch(_index){
    case 0:
      visible = false;
      break;
    case 1:
      saveLoad.load();
      visible = false;
      break;  
    case -1:
      break;
    }
  }
  
}//end of class
