enum GameState {
  TITLE, GAME, PAUSE, OVER
}

class GameManager {
  
  Player player;
  PlatformManager pm;
  float score = 0;
  boolean climbing = false;
  GameState state = GameState.GAME;
  
  GameManager(){
    player = new Player();
    pm = new PlatformManager(player);
  }
  
  void update(){
    for(int i =0;i<2;i++){
      player.update();
      pm.update();
    }
    
    fill(0);
    switch(state){
      case TITLE:
        break;
      case GAME:
        scoreCounter();
        break;
      case PAUSE:
        textSize(40);
        textAlign(CENTER);
        text("PAUSED", width/2,height/2);
        break;
      case OVER:
        textSize(40);
        text("Crashed!", 10,90);
        break;
    }
    textAlign(LEFT);
    textSize(25);
    text("Score: " + String.format("%.2f",score), 10,30);
    text("Fuel:  " + player.fuel, 10,55);
    if(player.crashed){
      state = GameState.OVER;
    }
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
  
  void setPause(){
    switch(state){
      case TITLE:
        break;
      case GAME:
        state = GameState.PAUSE;
        break;
      case PAUSE:
        state = GameState.GAME;
        break;
      case OVER:
        exit();
        break;
    }
    player.setState(state);
    pm.setState(state);
  }
}
