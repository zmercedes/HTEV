/* Hop to Escape Velocity
 * Author: Zoilo Mercedes
 * This game was inspired by Github Game Off 2019.
 * 
 */

GameManager gm;

void setup(){
  size(400,800);
  gm = new GameManager();
}

void draw(){
  gm.update();
}