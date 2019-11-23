class PlatformManager {
  
  ArrayList<Platform> platforms;
  Player player;
  GameState state;
  
  PlatformManager(Player player){
    this.player = player;
    this.platforms = new ArrayList<Platform>();
    float xPos = random(20,width-20);
    this.platforms.add(new Platform(xPos, height -60));
    this.state = GameState.GAME;
  }
  
  void update(){
    switch(state){
      case TITLE:
        break;
      case GAME:
        if(player.y == height/2 && !player.isFalling)
          move(-player.speedY);
        break;
      case PAUSE:
        break;
      case OVER:
        break;
    }
    generatePlatform();
    for(int i = 0; i< platforms.size(); i++){
      Platform platform = platforms.get(i);
      
      if(platform.y >= height + platform.tall){
        platforms.remove(i);
        i--;
      } else
        platform.display();
    }
    if(player.isFalling) detectCollision();
  }
  
  void detectCollision(){
    for(Platform platform: platforms){
      if(platform.collider(player)) break;
    }
  }
  
  void generatePlatform(){
    Platform top = platforms.get(platforms.size()-1);
    if(top.y > 50){
      float xPos = random(35,width-35);
      float y = random(60,70);
      platforms.add(new Platform(xPos,top.y-y));
    }
  }
  
  void move(float speed){
    if(speed > 0.2){
      for(Platform platform: platforms){
        platform.move(speed);
      }
    }
  }
  
  void setState(GameState state){
    this.state = state;
  }
}
