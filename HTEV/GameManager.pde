class GameManager {
  
  Player player;
  final float gravity = 0.3;
  
  GameManager(){
    player = new Player();
  }
  
  void update(){
    player.update();
  }
}
