class Animation {
  
  PImage[] images;
  int imageCount;
  int frame;
  
  Animation(String imagePrefix, int count) {
    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      String filename = imagePrefix + (i+1) + ".png";
      images[i] = loadImage(filename);
      images[i].resize(30,50);
    }
  }
  
  void displayRight(float xpos, float ypos) {
    if(frameCount % 6 == 0){
      frame -= 1;
      if(frame < 0) frame = 3;
    }
    display(xpos,ypos);
  }
  
  void displayLeft(float xpos, float ypos) {
    if(frameCount % 6 == 0) frame = (frame+1) % imageCount;
    display(xpos,ypos);
  }

  void display(float xpos, float ypos) {
    image(images[frame], xpos - getWidth()/2, ypos - getHeight()*.3);
  }
  
  int getWidth() {
    return images[frame].width;
  }
  
  int getHeight() {
    return images[frame].height;
  }
}
