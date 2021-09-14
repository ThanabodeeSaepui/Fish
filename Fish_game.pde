import java.util.Arrays;
Liquid liquid;
Fish fish;
ArrayList<Food> foods;
void setup() {
  size(640,320);
  background(255);
  liquid = new Liquid(0, height*1/5, width, height*4/5, 0.1);
  fish = new Fish();
  foods = new ArrayList<Food>();
}
void mousePressed() {
  Food f = new Food(mouseX,mouseY,0.8);
  foods.add(f);
}
void draw() {
  background(255);
  liquid.display();
  float shortest = sqrt(width*width + height*height);
  PVector route;
  int f_i;
  for (int i = 0; i < foods.size(); i++) {
    Food f = foods.get(i);
    float distance = f.getDistance(fish);
    if (shortest > distance) {
      shortest = distance;
      f_i = i;
      println(shortest);
    }
    if (f.eaten(fish)) {
      foods.remove(i);
      fish.addMass(0.1);
    }
    if (f.isInside(liquid)) {
      f.drag(liquid);
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
    f.display();
    f.checkEdges();
  }
  fish.attract(new PVector(mouseX,mouseY));
  fish.drag(liquid);
  fish.update();
  fish.display();
  fish.checkWater(liquid);
}
