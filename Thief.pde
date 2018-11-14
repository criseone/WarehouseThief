PShape Boy;

class Thief extends GameObject {
  
  Thief(PShape, float x, float y, float speed, float damper)
  {
    super(new PShape, new PVector(x, y), new PVector(1, 1), speed, damper);
  }

  void display()
  {
   
    Boy = loadShape("Thief.svg");
    shape(Boy);
    super.display();
    //pushStyle();
    //pushMatrix();
    ////fill(255, 255, 255);
    //translate(position.x, position.y);
    //rotate(rotation.heading());
    ////fill(palette2);
    ////triangle(diameter/1.5, 0, -diameter/2, diameter/2, -diameter/2, -diameter/2),
    //shape(Boy);
    //popMatrix();
    //popStyle();
  }

  void updateSpeed() {
    PVector rotationStep = rotation.copy();
    rotationStep.mult(speed);
    velocity.add(rotationStep);
    drawTail();
  }

  void updateAngle(float theta) { 
    rotation.rotate(theta);
  }

  void collision() {
    // draw explosion 
    fill(palette3);
    ellipse(position.x, position.y, 100, 100);
  };

  void shoot() {
    Items.add(new Item(position.copy(), rotation.copy()));
  }

  void drawTail() {  
    int alternator = int(position.x + position.y);
    alternator = alternator%2; // Modulo symbol %, finds the remainder when one number is divided by another 
    if (alternator == 0) {
      pushMatrix();
      translate(position.x, position.y);
      rotate(rotation.heading());
      fill(palette3);
      translate(-diameter/2, 0);
      triangle(-diameter*2, 0, -diameter/5, diameter/5, -diameter/5, -diameter/5);
      popMatrix();
    }
  };
}
