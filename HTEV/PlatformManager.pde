class PlatformManager {
  
  ArrayList<Platform> platforms;
  Player player;
  
  PlatformManager(Player player){
    this.player = player;
    this.platforms = new ArrayList<Platform>();
    float xPos = random(20,width-20);
    this.platforms.add(new Platform(xPos, height -60));
  }
  
  void update(){
    if(player.y == height/2 && !player.isFalling)
        move(-player.speedY);

    generatePlatform();
    String platformPos = "";
    for(int i = 0; i< platforms.size(); i++){
      Platform platform = platforms.get(i);
      
      if(platform.y >= height + platform.tall){
        platforms.remove(i);
        i--;
        continue;
      }
      
      platform.display();
    }
    print(platformPos);
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
}
