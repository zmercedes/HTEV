enum GameState {
  TITLE, GAME, PAUSE, OVER
}

class GameManager {
  
  Player player;
  PlatformManager pm;
  UI ui;
  
  float score;
  boolean climbing;
  GameState state;
  
  GameManager(){
    reset();
    ui = new UI(player);
  }
  
  void update(){
    
    for(int i =0;i<2;i++){
      player.update();
      pm.update();
    }
    switch(state){
      case TITLE:
        break;
      case GAME:
        scoreCounter();
        break;
      case PAUSE:
        break;
      case OVER:
        break;
    }
    ui.update();
    ui.setState(state);
    
    if(player.crashed){
      state = GameState.OVER;
      
    }
    fill(255);
  }
  
  void reset() {
    player = new Player();
    pm = new PlatformManager(player);
    state = GameState.GAME;
    climbing = false;
    score = 0;
    if(ui != null) ui.player = player;
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
    ui.setScore(score);
  }
  
  void setKey(char k, boolean b){
    switch(k){
      case ESC:
        key = 0;
        if(state == GameState.OVER) exit();
        else if(keyPressed) setPause();
        break;
      case ENTER:
        if(state == GameState.OVER) reset();
        break;
      default:
        player.setKey(k,b);
        break;
    }
  }
  
  void setPause(){
    if(state == GameState.PAUSE) state = GameState.GAME;
    else if(state == GameState.GAME) state = GameState.PAUSE;
    
    player.setState(state);
    pm.setState(state);
  }
}
