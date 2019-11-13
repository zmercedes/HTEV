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
  private float speedX = 4;
  private float speedY = 0;
  private float jumpSpeed = -7;
  
  // shape dimensions
  private float wide = 30;
  private float tall = 50;
  
  // player state
  private boolean jumping = false;
  private boolean forward = false;
  private boolean backward = false;
  private boolean isFalling = false;
  
  Player(){
    this.x = width/2;
    this.y = height-50;
    this.ground = height-tall/2;
    this.bottom = y + tall/2;
    this.top = y - tall/2;
    this.left = x - wide/2;
    this.right = x + wide/2;
  }
  
  void jump(){
    if(!jumping){
      jumping = true;
      if(ground == height -25)
        speedY = jumpSpeed * 2;
      else
        speedY = jumpSpeed;
    }
  }
  
  void update(){
    this.move();
    this.display();
  }
  
  void move(){
    y += speedY;
    bottom = y + tall/2;
    top = y - tall/2;
    left = x - wide/2;
    right = x + wide/2;
    isFalling = speedY > 0;
    
    if(y >= ground){
      jumping = false;
      y = ground;
      speedY = 0;
      jump();
    } else
      speedY += gravity;
      
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
  }
  
  void display(){
    rect(x,y,wide,tall);
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
    }
  }
}
