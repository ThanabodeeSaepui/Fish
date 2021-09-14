class Food {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  Food(float x_, float y_, float mass_) {
    mass = mass_;
    location = new PVector(x_,y_);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }
  boolean eaten(Fish fish){
    float x = location.array()[0];
    float y = location.array()[1];
    float fish_x = fish.location.array()[0];
    float fish_y = fish.location.array()[1];
    float fish_size = fish.mass*10;
    if ((fish_x - fish_size < x) && (x < fish_x + fish_size)) {
      if ((fish_y - fish_size < y) && (y < fish_y + fish_size)) {
        return true;
      }
    }
    return false;
  }
  float getDistance(Fish fish){
    float x = location.array()[0];
    float y = location.array()[1];
    float fish_x = fish.location.array()[0];
    float fish_y = fish.location.array()[1];
    float distance = sqrt((fish_x-x)*(fish_x-x) + (fish_y-y)*(fish_y-y));
    return distance;
  }
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  void drag(Liquid l) {
    float speed = velocity.mag();
    float dragMagnitude = l.c * speed * speed;
    PVector drag = velocity.get();
    drag.mult(-1);
    drag.normalize();
    drag.mult(dragMagnitude);
    applyForce(drag);
  }
  boolean isInside(Liquid l) {
  if (location.x>l.x && location.x<l.x+l.w && location.y>l.y && location.y<l.y+l.h)
    {
      return true;
    } else {
      return false;
    }
  }
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration = PVector.mult(acceleration,0);
  }
  void display() {
    stroke(0);
    fill(240);
    ellipse(location.x,location.y,mass*16,mass*16);
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
