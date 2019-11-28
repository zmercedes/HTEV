class UI{
  
  Player player;
  GameState state;
  float score = 0;
  float barsHeight = 30;
  float barsTall = 20;
  
  PFont titleFont;
  PFont smallFont;
  PFont bigFont;
  
  boolean start = true;
  float currentFrame;
  
  UI(Player player){
    this.player = player;
    this.state = GameState.TITLE;
    titleFont = loadFont("Aero.vlw");
    bigFont = loadFont("Ubuntu_big.vlw");
    smallFont = loadFont("Ubuntu_small.vlw");
    currentFrame = frameCount + 30;
  }
  
  void update(){
    fill(0);
    switch(state){
      case TITLE:
        title();
        break;
      case GAME:
        inGame();
        break;
      case PAUSE:
        inGame();
        paused();
        break;
      case OVER:
        inGame();
        gameOver();
        break;
    }
  }
  
  void setState(GameState state){
    this.state = state;
  }
  
  void setScore(float newScore){
    this.score = newScore;
  }
  
  void title(){
    textAlign(CENTER);
    textFont(titleFont);
    textSize(50);
    text("Hop", width/2 - 30,height/6);
    textSize(25);
    text("to",width/2 + 40,height/6);
    textSize(60);
    text("ESCAPE", width/2 - 30,height/6 + 50);
    text("VELOCITY", width/2 + 10,height/6 + 100);
    textFont(bigFont);
    textSize(25);
    
    if(frameCount > currentFrame){
      start = !start;
      currentFrame = frameCount + 30;
    }
    
    if(start) text("Press Enter to start", width/2,height*.75);
  }
  
  void inGame(){
    textFont(smallFont);
    rect(width/2,30,width-1,60);
    fill(255);
    textAlign(CENTER);
    textSize(15);
    text("Energy Gauge",width/2,15);
    
    stroke(255);
    
    for(int i = 1;i<=player.maxFuel;i++){
      strokeWeight(3);
      fill(0);
      rect((width/4) * i - 50,barsHeight, width/5, barsTall);
      fill(255);
      strokeWeight(1);
      if(player.fuel >=i) 
        rect((width/4) * i - 50,barsHeight, width/5, barsTall);
      else if(player.fuel < i && player.fuel > i-1){
        float wide = (player.fuel - (i-1)) * width/5;
        rect((width/4) * i - 50,barsHeight, wide,barsTall);
      }
      
      if(player.booster > 0){
        fill(255,255,0);
        if(player.booster >= i) 
          rect((width/4) * i - 50,barsHeight, width/5, barsTall);
        else if(player.booster < i && player.booster > i-1){
          float wide = (player.booster - (i-1)) * width/5;
          rect((width/4) * i - 50,barsHeight, wide,barsTall);
        }
        fill(0);
      }
      fill(0);
    }
    stroke(0);
    fill(255);
    textSize(15);
    text("Height: " + String.format("%.2f",score), width/2,55);
  }
  
  void paused(){
    textFont(bigFont);
    fill(0);
    textSize(40);
    textAlign(CENTER);
    text("PAUSED", width/2,height/2);
  }
  
  void gameOver(){
    textFont(bigFont);
    fill(0);
    textSize(40);
    textAlign(CENTER);
    text("Crashed!", width/2,height/2);
    textSize(25);
    text("Press Enter to start over", width/2, height/2 + 20);
    text("Press Esc to quit", width/2, height/2 + 40);
  }
}
