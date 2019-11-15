class GameManager {
  
  Player player;
  PlatformManager pm;
  float score = 0;
  
  boolean climbing = false;
  
  GameManager(){
    player = new Player();
    pm = new PlatformManager(player);
  }
  
  void update(){
    player.update();
    pm.update();
    scoreCounter();
    fill(0);
    textSize(25);
    text("Score: " + score/10, 10,30);
    text("Fuel:  " + player.fuel, 10,55);
    fill(255);
  }
  
  void scoreCounter(){
    if(player.y <= height/2 && !climbing) climbing = true;
    if(!climbing){
      score = score > (height - player.y) ? score:height-player.y;
    } else {
      if(player.y == height/2 && player.speedY < -0.2){
        score -= player.speedY;
      }
    }
  }
  
  void setKey(char k, boolean b){
    player.setKey(k,b);
  }
}
