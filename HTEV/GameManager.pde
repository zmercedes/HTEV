class GameManager {
  
  Player player;
  
  GameManager(){
    player = new Player();
  }
  
  void update(){
    player.update();
  }
  
  void setKey(char k, boolean b){
    player.setKey(k,b);
  }
}
