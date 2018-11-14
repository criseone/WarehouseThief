
class Guard extends GameObject {
  Guard(PVector position, PVector direction, float diameter, float speed, float damper) {
    super(position, direction, diameter, speed, damper);
  }
  void display() {
    super.display();
    pushStyle();
    pushMatrix();
    translate(position.x, position.y);
    rotate(rotation.heading());
    imageMode(CENTER);
    PImage img;
    img = loadImage("Guard.png");
    image(img, 0, 0);
    popMatrix();
    popStyle();
 
  }
}
