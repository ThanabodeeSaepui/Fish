class Cat_food {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  Cat_food(float x_, float y_, float mass_) {
    mass = mass_;
    location = new PVector(x_,y_);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }
  boolean eaten(Cat cat){
    float x = location.array()[0];
    float y = location.array()[1];
    float cat_x = cat.location.array()[0];
    float cat_y = cat.location.array()[1];
    float cat_size = cat.mass*10;
    if ((cat_x - cat_size < x) && (x < cat_x + cat_size)) {
      if ((cat_y - cat_size < y) && (y < cat_y + cat_size)) {
        return true;
      }
    }
    return false;
  }
  float getDistance(Cat cat){
    float x = location.array()[0];
    float y = location.array()[1];
    float cat_x = cat.location.array()[0];
    float cat_y = cat.location.array()[1];
    float distance = sqrt((cat_x-x)*(cat_x-x) + (cat_y-y)*(cat_y-y));
    return distance;
  }
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration = PVector.mult(acceleration,0);
  }
  void display() {
    stroke(0);
    fill(240);
    ellipse(location.x,location.y,mass*width/30,mass*width/30);
  }
  void checkEdges() {
    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
    } else if (location.x < 0) {
      velocity.x *= -1;
      location.x = 0;
    }
    if (location.y + mass*8> height) {
      velocity.y *= -1;
      location.y = height - mass*8;
    }
  }
}
