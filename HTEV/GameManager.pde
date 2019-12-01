enum GameState {
  TITLE, GAME, PAUSE, OVER
}

class GameManager {
  
  Player player;
  PlatformManager pm;
  UI ui;
  PImage planet;
  PImage space;
  float planetx;
  float planety;
  float scale = 0.38;
  
  float score;
  boolean climbing;
  GameState state;
  
  GameManager(){
    state = GameState.TITLE;
    reset();
    ui = new UI(player);
    space = loadImage("space/milkyway.jpg");
    planet = loadImage("world/globe.png");
    planetx = random(20, width -20);
    planety = height*scale;
  }
  
  void update(){
    imageMode(CENTER);
    image(space,width/2, height/2);
    imageMode(CORNER);
    
    switch(state){
      case TITLE:
        image(planet,0,height*.2);
        break;
      case GAME:
        scoreCounter();
        imageMode(CENTER);
        image(planet,planetx, planety);
        imageMode(CORNER);
        break;
      case PAUSE:
        imageMode(CENTER);
        image(planet,planetx, planety);
        imageMode(CORNER);
        break;
      case OVER:
        imageMode(CENTER);
        image(planet,planetx, planety);
        imageMode(CORNER);
        scoreCounter();
        break;
    }
    for(int i =0;i<2;i++){
      player.update();
      pm.update();
    }
    
    ui.update();
    ui.setState(state);
    planetMove();
    
    if(player.crashed || gravity < 0) state = GameState.OVER;
      
    fill(255);
  }
  
  void reset() {
    player = new Player();
    pm = new PlatformManager(player);
    climbing = false;
    score = 0;
    gravity = 0.075;
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
    gravityReduction();
    ui.setScore(score);
  }
  
  void gravityReduction(){
    float gravReduce = score/25000; 
    if(gravity > 0) gravity = lerp(0.075,0,gravReduce);
    else gravity = -0.01;
  }
  
  void planetMove(){
    float gravReduce = score/25000;
    scale = lerp(0.4,1.25, gravReduce);
    planety = height*scale;
  }
  
  void setKey(char k, boolean b){
    switch(k){
      case ESC:
        key = 0;
        if(state == GameState.OVER) exit();
        else if(b) setPause();
        break;
      case ENTER:
        if(state == GameState.OVER) {
          state = GameState.GAME;
          reset();
        } else if(state == GameState.TITLE)
          state = GameState.PAUSE;
        
        player.setState(state);
        pm.setState(state);
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
