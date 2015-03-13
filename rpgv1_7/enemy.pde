class enemy{

  
  int level;
  String name;
  String[] moves = new String[2];
  int[] damagePoints = new int[2];
  int HP;
  int num;

  int vertY = 0;
  int vertX = 0;
  
  enemy(int _level, String _name, int _num, String move1, String move2){
    num = _num;
    level = _level;
    name = _name;
    HP = level * 5;
    moves[0] = move1;
    moves[1] = move2;
    damagePoints[0] = level*1;
    damagePoints[1] = level*2;
  }
  

  
  int getHP(){
    return HP;
  }
  
  
  String getEnemyName(){
    return name;
  }
  
  void enemyTileAnimation(){
    if(frameCount % 15 == 0){
      if(vertY >= 96){
        vertY = 0;
      }
      if(vertX >= 64){
         vertX = 0;
         vertY += 32;
      }else{
        vertX += 32;
      }
    }
  }
  
   
}
