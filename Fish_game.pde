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
void draw() {
  background(255);
  liquid.display();
  if (mousePressed) {
    Food f = new Food(mouseX,mouseY,0.8);
    foods.add(f);
  }
  
  for (Food f: foods) {
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
  fish.display();
}
