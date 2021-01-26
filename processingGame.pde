//SOURCE:
//https://forum.processing.org/two/discussion/1573/spoof-of-pacman-game-for-project

float radius = 15;
int direction = 1;
int direction2 = 0;
int food=0; // collected food
int lives = 3; // number of lives at the start
int hs = 0; // high score
float x = 250;
float y = 250;
int numberofFood = 20; // food to spawn
int numberOfPoison = 80; // poison to spawn
int numberOfHeal = 0; // heal to spown (inreases further in the code)
ArrayList<Particle> foodArray = new ArrayList();
ArrayList<Poison> poison = new ArrayList();
ArrayList<Heal> heal = new ArrayList();
 
void setup() {
  foodArray.clear();
  poison.clear();
  heal.clear();
  size(500, 500);
  ellipseMode(RADIUS);
  for (int i=0; i<numberofFood; i++) { 
    Particle P = new Particle((int)random(width), (int)random(height));
    foodArray.add(P);
  }
  for (int i=0; i<numberOfPoison; i++) { 
    Poison P = new Poison((int)random(width), (int)random(height));
    poison.add(P);
  }
  radius = 15;
  direction = 1;
  direction2 = 0;
  food=0; 
  lives = 3;
  x = 250;
  y = 250;
}
 
void draw() {
  background(255);
  fill (0, 175, 255);
  smooth ();
  noStroke();
  render();
  for (int i=0;i<foodArray.size();i++) {
    Particle Pn = (Particle) foodArray.get(i);
    Pn.display();
    if (dist(x, y, Pn.x, Pn.y)<radius) { // checking if Pacman is over the food 
      foodArray.remove(i);
      radius=radius+0.1; // increasing radius with every food eaten
      food =food+1; // numbers of food has been eaten
      if(food == 3){
        numberOfHeal = 1;
          if(numberOfHeal == 1){
          numberOfHeal = 0;
          heal.add(new Heal((int)random(width), (int)random(height)));
          numberOfHeal = 0;
          }
        numberOfHeal = 0;
      }
    }
  }
    for (int i=0;i<poison.size();i++) {
      Poison poisonD = (Poison) poison.get(i);
      poisonD.display();
      if (dist(x, y, poisonD.x, poisonD.y)<radius) { // checking if Pacman is over the poison 
        poison.remove(i);
        radius = radius - 5; // decreasing radius with every poison eaten
        lives = lives - 1; // numbers of lives 
      }
    }
    for (int i=0;i<heal.size();i++) {
      Heal H = (Heal) heal.get(i);
      H.display();
      if (dist(x, y, H.x, H.y)<radius) { // checking if Pacman is over the heal 
        heal.remove(i);
        radius=radius + 1; // increasing radius with heal
        lives = lives + 1; // add 1 to lives
      }
  }
  
  
  textAlign(RIGHT);
  textSize(16);
  fill(#31de31);
  text("Lives: " + lives, 75, 20);
  text("Food: " + food, 75, 40);
  text("HighScore: " + hs, 115, 60);

  if(lives <= 0){
    hs = food;
    textAlign(CENTER);
    textSize(48);
    fill(#FF0000);
    text("YOU LOST!", width/2, height/2);
  }
}

// restarts the game
void mouseClicked(){
  hs = food;
  setup();
}

// --------------- FOOD CLASS ----------------
class Particle { 
  int x, y;
  Particle(int x, int y) {
    this.x = x;
    this.y = y;
  }
  void display() {
    noStroke();
    fill(#FCA900);
    ellipse(x, y, 5, 5);
  }
}
// --------------- POISON CLASS ----------------
class Poison { 
  int x, y;
  Poison(int x, int y) {
    this.x = x;
    this.y = y;
  }
  void display() {
    noStroke();
    fill(#FC0000);
    ellipse(x, y, 5, 5);
  }
}
// --------------- HEAL CLASS ----------------
class Heal { 
  int x, y;
  Heal(int x, int y) {
    this.x = x;
    this.y = y;
  }
  void display() {
    noStroke();
    fill(#00FC04);
    ellipse(x, y, 5, 5);
  }
}

void render() {
  for ( int i=-1; i < 2; i++) {
    for ( int j=-1; j < 2; j++) {
      pushMatrix();
      translate(x + (i * width), y + (j*height));
      if ( direction == -1) { 
        rotate(PI);
      }
      if ( direction2 == 1) { 
        rotate(HALF_PI);
      }
      if ( direction2 == -1) { 
        rotate( PI + HALF_PI );
      }
      arc(0, 0, radius, radius, map((millis() % 500), 0, 500, 0, 0.52), map((millis() % 500), 0, 500, TWO_PI, 5.76) );
      popMatrix();
      // mouth movement //
    }
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      x = x - 10; //  what if x-10< 0  // so when it goes beyond the 0 you should reset it to  x = width  
      direction = -1;
      direction2 = 0;
      if(x <= 0){
        x = width;
      }
    }
    else if (keyCode == RIGHT) {  
      x = x + 10; // what if x+10 > width // so when it goes beyond the width you should reset it to  x = 0  
      direction = 1;
      direction2 = 0;
      if(x >= width){
        x = 0;
      }
    }
    else if (keyCode == UP) {
      y = y - 10; // what if y-10 <0  // so when it goes beyond the 0 you should reset it to  y = height  
      direction = 0;
      direction2 = -1;
      if(y <= 0){
        y = height;
      }
    }
    else if (keyCode == DOWN) { 
      y = y + 10; // what if y+10 >height // so when it goes beyond the height you should reset it to x = 0  
      direction = 0;
      direction2 = 1;
      if(y >= height){
        y = 0;
      }
    }
  }
}
