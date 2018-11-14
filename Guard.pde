
class Guard extends GameObject {
  Guard(PVector position, PVector direction, float diameter, float speed, float damper) {
    super(position, direction, diameter, speed, damper);
  }
  void display() {
    super.display();
    if (display) {
      fill(palette4);
      ellipse(position.x, position.y, diameter, diameter);
    }
  }
  void collision() {
    // draw explosion 
    fill(palette3);
    ellipse(position.x, position.y, 60, 60);
    super.collision();
  };
}
