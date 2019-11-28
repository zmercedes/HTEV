class Player {
  
  // position
  private float x;
  private float y;
  
  // collider info
  private float bottom;
  private float top;
  private float left;
  private float right;
  
  private float ground = 0;
  
  // movement info
  private float speedX = 2;
  private float speedY = 0;
  private float jumpSpeed = -3.5;
  
  // shape dimensions
  private float wide = 30;
  private float tall = 50;
  
  // player state
  private boolean jumping = false;
  private boolean forward = false;
  private boolean backward = false;
  private boolean isFalling = false;
  private boolean boosting = false;
  
  // fuel gauge
  private float fuel = 2;
  private float maxFuel = 4;
  private float booster = 0;
  
  private boolean crashed = false;
  
  GameState state;
  
  Player(){
    this.x = width/2;
    this.y = height-50;
    this.ground = height-tall/2;
    this.bottom = y + tall/2;
    this.top = y - tall/2;
    this.left = x - wide/2;
    this.right = x + wide/2;
    this.state = GameState.TITLE;
  }
  
  void jump(){
    if(!jumping){
      jumping = true;
      if(ground == height -25)
        speedY = jumpSpeed * 2;
      else {
        ground = height -25;
        if(booster >= 1 && !boosting){
          float addedJump = jumpSpeed * booster;
          speedY = jumpSpeed + addedJump;
          fuel -= booster;
          booster = 0;
        } else
          speedY = jumpSpeed;
      }
    } 
  }
  
  void activateBooster(boolean b){
    if(b){
      if(booster >= maxFuel) booster = maxFuel;
      else booster += 0.005;
    } else { 
      booster = floor(booster);
      if(fuel < booster)
        booster = 0;
    }
  }
  
  void addFuel(float amount){
    if(fuel + amount > maxFuel) fuel = maxFuel;
    else fuel += amount;
  }
  
  void update(){
    switch(state){
      case TITLE:
        break;
      case GAME:
        this.move();
        this.display();
        break;
      case PAUSE:
        this.display();
        break;
      case OVER:
        break;
    }
    if(fuel <=0) fuel = 0;
    else if(fuel >= maxFuel) fuel = maxFuel;
    
  }
  
  void move(){
    y += speedY;
    bottom = y + tall/2;
    top = y - tall/2;
    left = x - wide/2;
    right = x + wide/2;
    isFalling = speedY > 0;
    
    if(y >= ground){
      if(ground == height - tall/2 && !crashed){
        if(fuel >=2) fuel -= 2;
        else crashed = true;
      } 
      jumping = false;
      if(!crashed){
        y = ground;
        speedY = 0;
        jump();
      } else 
        ground = height + tall;
    } else
      speedY += gravity;
     
    if(y >= height + tall){
      y = ground;
      speedY = 0;
    }
    
    if(y <= height/2){
      y = height/2;
    }
      
    if(x < -wide/2)
      x = width + wide/2;
      
    if(x > width + wide/2)
      x = -wide/2;
      
    if(this.forward)
      x += speedX;
    
    if(this.backward)
      x -= speedX;
      
    activateBooster(boosting);
  }
  
  void display(){
    rect(x,y,wide,tall);
  }
  
  void setState(GameState state){
    this.state = state;
  }
  
  void setKey(char k, boolean b){
    switch(k){
      case 'a':
        this.backward = b;
        break;
      case 'A':
        this.backward = b;
        break;
      case 'D':
        this.forward = b;
        break;
      case 'd':
        this.forward = b;
        break;
      case ' ':
        this.boosting = b; 
        break;
    }
  }
}
