class Item extends GameObject {
  int id;
  Item(PVector position, PVector direction)
  {
    super(position, direction, 7, 10, 1);   // position,  direction,  diameter, speed, damper
  }

  void display()
  {
    super.display();
    if (display) {
     pushStyle();
    pushMatrix();
    translate(position.x, position.y);
    rotate(rotation.heading());
    imageMode(CENTER);
    PImage img;
    img = loadImage("item.png");
    image(img, 0, 0);
    popMatrix();
    popStyle();
    }
  }
  void screenWrap() {
    // overide screenWrap and hide Items if they are off screen 
    if (position.x > width || position.x < 0 || position.y > height || position.y < 0) {
      display = false;
    }
  }
}
