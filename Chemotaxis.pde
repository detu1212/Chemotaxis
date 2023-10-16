import processing.core.PApplet;

class Microorganism {
    float x, y; // Position of the microorganism
    float speed; // Speed of movement
    float angle; // Angle of movement
    ////int color; // Color of the microorganism
    boolean isAlive;

    public Microorganism(float x, float y) {
        this.x = x;
        this.y = y;
        this.speed = 1.3;
        this.angle = random(TWO_PI); // Random initial angle
       //// this.color = color(0, 255, 0); // Green color
        this.isAlive = true;
    }

    void moveTowards(float targetX, float targetY) {
        float dx = targetX - x;
        float dy = targetY - y;
        angle = atan2(dy, dx);
        x += cos(angle) * speed;
        y += sin(angle) * speed;
    }

    void display() {
        if (isAlive) {
          ////  fill(color);
            ellipse(x, y, 20, 20); // Display the microorganism
        }
    }
}

PApplet sketch;

Microorganism[] organisms;
float foodX, foodY;

void setup() {
    size(640, 640);
    sketch = this;

    organisms = new Microorganism[10]; // Create an array of microorganisms
    for (int i = 0; i < organisms.length; i++) {
        organisms[i] = new Microorganism(random(width), random(height)); // Spread them randomly
    }

    foodX = random(width);
    foodY = random(height);
}

void draw() {
    background(335);

    // Display and move the microorganisms
    for (Microorganism organism : organisms) {
        organism.display();
        if (organism.isAlive) {
            organism.moveTowards(foodX, foodY);
        }
    }

    ///Display the food
    fill(355, 330, 330);
    ellipse(foodX, foodY, 30, 30);

    // Check if any microorganism reaches the food
    for (Microorganism organism : organisms) {
        if (organism.isAlive && dist(organism.x, organism.y, foodX, foodY) < 15) {
            organism.isAlive = false;
        }
    }
}

void mousePressed() {
    // Move the food to the mouse click location
    foodX = mouseX;
    foodY = mouseY;
}
