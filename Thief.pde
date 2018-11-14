class Thief extends GameObject {

  Thief(float x, float y, float diameter, float speed, float damper)
  {
    super(new PVector(x, y), new PVector(1, 1), diameter, speed, damper);
  }

  void display()
  {

    super.display();
    pushStyle();
    pushMatrix();
    translate(position.x, position.y);
    rotate(rotation.heading());
    imageMode(CENTER);
    PImage img;
    img = loadImage("Thief.png");
    image(img, 0, 0);
    popMatrix();
    popStyle();
  }

  void updateSpeed() {
    PVector rotationStep = rotation.copy();
    rotationStep.mult(speed);
    velocity.add(rotationStep);
  }
  
    void updateSpeedInverse() {
    PVector rotationStep = rotation.copy();
    rotationStep.mult(speed);
    velocity.sub(rotationStep);
  }

  void updateAngle(float theta) { 
    rotation.rotate(theta);
  }
  
    void collision() {
    // draw explosion 
    fill(palette3);
    ellipse(position.x, position.y, 100, 100);
  };
}
