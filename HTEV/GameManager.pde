class GameManager {
  
  Player player;
  
  GameManager(){
    player = new Player();
  }
  
  void update(){
    player.update();
  }
}
