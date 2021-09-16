import java.util.Arrays;
Fish fish;
Cat cat;
ArrayList<Food> foods;
ArrayList<Cat_food> cat_foods;
void setup() {
  size(640,320);
  background(255);
  //fish = new Fish();
  //foods = new ArrayList<Food>();
  
  cat = new Cat();
  cat_foods = new ArrayList<Cat_food>();
}
void mousePressed() {
  //Food f = new Food(mouseX,mouseY,0.8);
  //foods.add(f);
  
  Cat_food f = new Cat_food(mouseX,mouseY,0.8);
  cat_foods.add(f);
  //cat.jump();
}
void draw() {
  //fish.drawGame();
  cat.drawGame();
}
