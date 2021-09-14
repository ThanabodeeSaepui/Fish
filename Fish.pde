class Fish {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass = 1;
  float maxMass = 3;
  Fish(){
    location = new PVector(random(0,width),height/2);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }
  void addMass(float m_) {
    mass += m_;
    massLimit();
  }
  void massLimit() {
    if (mass > maxMass) {
      mass = maxMass;
    }
  }
  boolean isInside(Liquid l) {
  if (location.x>l.x && location.x<l.x+l.w && location.y>l.y && location.y<l.y+l.h)
    {
      return true;
    } else {
      return false;
    }
  }
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
    update();
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
  void attract(PVector foodLocation) {
    PVector dir = PVector.sub(foodLocation,location);
    dir.normalize();
    dir.mult(0.04);
    acceleration = dir;
  }
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration = PVector.mult(acceleration,0);
  }
  void display() {
    stroke(0);
    fill(175,0,255,255);
    ellipse(location.x,location.y,mass*20,mass*20);
  }
  void checkWater(Liquid l) {
    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
    } else if (location.x < 0) {
      velocity.x *= -1;
      location.x = 0;
    }
    if (location.y + mass*10> height) {
      velocity.y *= -1;
      location.y = height - mass*10;
    } else if (location.y - mass*10 < (height-l.h)) {
      velocity.y *= -1;
      location.y = height-l.h + mass*10;
    }
  }
}
