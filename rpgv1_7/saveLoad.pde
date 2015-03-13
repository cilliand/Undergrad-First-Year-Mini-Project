class saveLoad {

  BufferedReader reader;
  PrintWriter output;
  String line;

  int posX, posY, map, level, HP;
  boolean showSave;

  void load() {
    reader = createReader("data/saveGame.txt");   

    try {
      line = reader.readLine();
    } 
    catch (IOException e) {
      e.printStackTrace();
      line = null;
    }
    if (line == null) {
      // Stop reading because of an error or file is empty
      noLoop();
    } 
    else {
      String[] pieces = split(line, ',');
      posX = int(pieces[0]);
      posY = int(pieces[1]);
      map = int(pieces[2]);
      HP = int(pieces[3]);
      level = int(pieces[4]);
    }

    player.setX(posX);
    player.setY(posY);
    mapBuilder[currentMap].setMap(map);
    player.setLevel(level);
  }   

  void save() {
    output = createWriter("data/saveGame.txt"); 
    //out put players data (posx, posy, currentmap, hp, level.  
    output.println(player.posX+","+player.posY+","+currentMap+","+player.getHP()+","+player.getLevel());
    output.flush(); // Writes the remaining data to the file
  }
}//end of class

