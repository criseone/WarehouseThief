class GameObject {
  boolean   display;
  PVector   position = new PVector();
  PVector   velocity = new PVector();
  PVector   rotation = new PVector();
  float     damper;
  float     diameter;
  float     speed;
  float     radius;

  GameObject(PVector position, PVector direction, float diameter, float speed, float damper)
  {
    this.position = position;
    this.velocity = direction.normalize();
    this.damper = damper; // damper acts like resistance againsts the object, slowing it down over time
    this.rotation = velocity.copy();
    this.speed = speed;
    this.velocity.mult(speed); //velocity is the combination of speed and direction 
    this.diameter = diameter;
    this.radius = diameter/2;
    this.display = true;
  }

  void display()
  {
    if (display) {
      velocity.mult(damper);
      position.add(velocity);
      screenWrap();
    }
  }

  void collision() {
    display = false;
  };

  boolean checkCollision(GameObject otherObject) {
    // Circle Collision Detection
    float distance = dist(position.x, position.y, otherObject.x(), otherObject.y());
    if (distance < radius + otherObject.radius) {
      this.collision();
      otherObject.collision();
      return true;
    } else {
      return false;
    }
  }

  float x() {
    return position.x;
  }

  float y() {
    return position.y;
  }

  void screenWrap() {
    // make sure objects always stay on screen by wraping the game space.
    // check if object is off screen to the right
    if (position.x > width+radius)
    {
      position.x = 0-radius;
    }
    // check if object is off screen to the left
    if (position.x < 0-radius)
    {
      position.x = width+radius;
    }
    // check if object is off screen to the bottom
    if (position.y > height+radius)
    {
      position.y = 0-radius;
    }
    // check if object is off screen to the top
    if (position.y < 0-radius)
    {
      position.y = height+radius;
    }
  }
}
