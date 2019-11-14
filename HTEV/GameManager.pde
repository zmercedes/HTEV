class GameManager {
  
  Player player;
  PlatformManager pm;
  
  GameManager(){
    player = new Player();
    pm = new PlatformManager(player);
  }
  
  void update(){
    player.update();
    pm.update();
  }
  
  void setKey(char k, boolean b){
    player.setKey(k,b);
  }
}
