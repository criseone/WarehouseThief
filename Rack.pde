class Rack extends GameObject {
  int id;
  Rack(PVector position, PVector direction)
  {
    super(position, direction, 7, 10, 1);   // position,  direction,  diameter, speed, damper
  }

  void display()
  {
    super.display();
    if (display) {
      pushStyle();
      fill(palette3);
      noStroke();
      ellipse(position.x, position.y, 60, 60);
      popStyle();
    }
  }
  void screenWrap() {
    // overide screenWrap and hide Racks if they are off screen 
    if (position.x > width || position.x < 0 || position.y > height || position.y < 0) {
      display = false;
    }
  }
}
