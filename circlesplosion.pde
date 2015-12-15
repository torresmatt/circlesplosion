// We'll store all the game's circles in this arraylist
ArrayList<Circle> circles;

void setup() {
  // Clear the screen to white
  background(255);
  fullScreen();
  // Initialize the list of circles
  circles = new ArrayList<Circle>();
}

void mousePressed() {
  // Using a for loop, make a random number of new circles at the mouse's location.
  for (int i = 0; i < random(5,15); i++) {
    circles.add(new Circle(mouseX,mouseY));
  }
}

void draw() {
  background(255);
  // Add a text message in the upper left to show how many circles are in the list
  text("" + circles.size() + "",10,10,70,80);
  // Call check circles to make sure all circles that have left the screen are removed
  checkCircles();
  // Don't want to try to draw circles if there aren't any
  if (circles.size() > 0) {
    // Draw every circle in the list of circles
    for (Circle c : circles) {
      c.draw();
    }
  }
}

void checkCircles() {
  // Go through the entire list of circles
  for (int i = 0; i < circles.size(); i++) {
    // If the current circle is off any edge of the screen, remove it
    if (circles.get(i).offScreen()) {
      circles.remove(i);
    }
  }
}

class Circle {
  private PVector position;
  private PVector velocity;
  private PVector acceleration;
  private float s; // size
  private float c; // color
  
  Circle(float x, float y) {
    s = random(5,25); // size set to random value between 5 and 25
    c = random(0,240); // color set to random value between 0 and 240 (don't want anything too light)
    position = new PVector(x,y); // set position to passed-in values
    velocity = new PVector(random(-.75,.75),random(-.75,.75)); // random starting speed
    
    acceleration = new PVector(0,0); // set acceleration to 0 by default
    // set acceleration to random values based on the direction the sphere is going 
    // (don't want it to change directions)
    // (ex: if velocity less than 0, acceleration needs to be less than 0, etc)
    if (velocity.x < 0) {
      acceleration.x = random(velocity.x,0) / 10;
    }
    else {
      acceleration.x = random(0,velocity.x) / 10;
    }  
    if (velocity.y < 0) {
      acceleration.y = random(velocity.y,0) / 10;
    }
    else {
      acceleration.y = random(0,velocity.y) / 10;
    }
  }
  
  public void draw() {
    stroke(c);
    fill(c);
    // add some acceleration
    velocity.add(acceleration);
    // move the Circle
    position.add(velocity);
    // draw the circle
    ellipse(position.x,position.y,s,s);
  }
  
  public boolean offScreen() {
    // return whether or not either the x or y is off the screen either direction
    return (position.x < 0 ||
            position.x > width ||
            position.y < 0 ||
            position.y > height);
  }

}