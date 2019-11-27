enum GameState {
  TITLE, GAME, PAUSE, OVER
}

class GameManager {
  
  Player player;
  PlatformManager pm;
  float score;
  boolean climbing;
  GameState state;
  
  GameManager(){
    reset();
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
        textAlign(CENTER);
        text("Crashed!", width/2,height/2);
        textSize(25);
        text("Press Enter to start over", width/2, height/2 + 20);
        text("Press Esc to quit", width/2, height/2 + 40);
        break;
    }
    textAlign(LEFT);
    textSize(25);
    text("Height: " + String.format("%.2f",score), 10,30);
    text("Fuel:  " + player.fuel, 10,55);
    text("Boost: " + String.format("%.2f",player.booster), 10, 80);
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
