class Menu extends dialogBox{
  
  boolean display = false;
  
  String save = "Save Game";
  String quit = "Quit";
  String load = "Load";
  String stats = "Player Stats";
  
  Menu(int _width, int _height){
     super();
     boxHeight = _height;
     boxWidth = _width;  
  } 
  
  void hide(){
    this.display = false;
  }
  
  
  void displayGameMenu(int _x, int _y){
 
     boxX = _x;
     boxY = _y;
      
     if(this.display){  
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
       text("Menu", boxX+32, boxY+32);
       //playerdata (2)
       statsHover();
       text(stats, boxX+32, boxY+32*2);
       //save (3)
       saveHover();
       text(save, boxX+32, boxY+32*3);
       //load (4)
       loadHover();      
       text(load, boxX+32, boxY+32*4);
       //quit (5)
       quitHover();
       text(quit, boxX+32, boxY+32*5);
     }   
     
   } 
  
  void statsHover(){
    if(mouseX >= (boxX+32) && mouseX <= (boxX+32)+boxWidth
      && mouseY >= boxY+32*1.5 && mouseY <= boxY+32*2){
        stats = "> Player Stats";
      } else {
        stats = "Player Stats";
      }
  }
  void saveHover(){
      if(mouseX >= (boxX+32) && mouseX <= (boxX+32)+boxWidth
      && mouseY >= boxY+32*2.5 && mouseY <= boxY+32*3){
        save = "> Save Game";
      } else {
        save = "Save Game";
      }
  }
  
  void loadHover(){
      if(mouseX >= (boxX+32) && mouseX <= (boxX+32)+boxWidth
      && mouseY >= boxY+32*3.5 && mouseY <= boxY+32*4){
        load = "> Load Game";
      } else {
        load = "Load Game";
      }
  }
  void quitHover(){
      if(mouseX >= (boxX+32) && mouseX <= (boxX+32)+boxWidth
      && mouseY >= boxY+32*4.5 && mouseY <= boxY+32*5){
        quit = "> Quit";
      } else {
        quit = "Quit";
      }
  }
  
  boolean statsPressed(){
    if(this.display){
        if(mouseX >= (boxX+32) && mouseX <= (boxX+32)+boxWidth
            && mouseY >= boxY+32*1.5 && mouseY <= boxY+32*2){
              return true;
      }
    }
  return false;
  }
  
  boolean savePressed(){
    if(this.display){
        if(mouseX >= (boxX+32) && mouseX <= (boxX+32)+boxWidth
            && mouseY >= boxY+32*2.5 && mouseY <= boxY+32*3){
              return true;
      }
    }
  return false;
  }
  
   boolean loadPressed(){
    if(this.display){
      if(mouseX >= (boxX+32) && mouseX <= (boxX+32)+boxWidth
      && mouseY >= boxY+32*3.5 && mouseY <= boxY+32*4){
        return true;
      }
    }
  return false;
  }
  
   boolean quitPressed(){
    if(this.display){
      if(mouseX >= (boxX+32) && mouseX <= (boxX+32)+boxWidth
      && mouseY >= boxY+32*4.5 && mouseY <= boxY+32*5){
        return true;
      }
    }
  return false;
  }
  
} 
