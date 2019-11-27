/* Hop to Escape Velocity
 * Author: Zoilo Mercedes
 * This game was inspired by Github Game Off 2019.
 * 
 */
final float gravity = 0.075;
GameManager gm;

void setup(){
  size(400,760);
  rectMode(CENTER);
  gm = new GameManager();
}

void draw(){
  background(220);
  gm.update();
}

void keyPressed(){
  gm.setKey(key, true);
}

void keyReleased(){
  gm.setKey(key, false);
}
