class Cat {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass = 1;
  float maxMass = 3;

  Cat(){
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
  void drawGame(){
    background(255);

    float shortest = sqrt(width*width + height*height);
    int f_i = 0;
    for (int i = 0; i < cat_foods.size(); i++) {
      Cat_food f = cat_foods.get(i);
      float distance = f.getDistance(cat);
      if (shortest > distance) {
        shortest = distance;
        f_i = i;
      }
      if (f.eaten(cat)) {
        cat_foods.remove(i);
        cat.addMass(0.1);
        if (f_i > 0){
          f_i -= 1;
        }
      }

      float c = 0.01;
      PVector friction = f.velocity.get();
      float m = f.mass;
      PVector gravity = new PVector(0,0.1*m);
      friction.mult(-1);
      friction.normalize();
      friction.mult(c);
      f.applyForce(gravity);
      f.applyForce(friction);
      f.update();
      f.checkEdges();
      f.display();
    }
    if (cat_foods.size() > 0) {
      Cat_food f = cat_foods.get(f_i);
      cat.attract(f.location);
    }
    cat.update();
    cat.display();
  }
}
