// RULES OF THE SKETCH:
//  - Balls should spin as a semicircle in the center of the screen.
//  - Generate a random point, which is "flying" free. When it collides with the border, it should bump away.
//  - The point is connected with every ball.
//  - When the point hits the border, the color of the balls and the point itself should change to a random color from the predefined colorpalette.

int size = 5; // Size of the balls
int diameter = 20;  // Diameter
int numCircles = 20;  // Number of balls
int outerDiameter;

// Position, direction and speed of the balls at the starting point.
float positionX;
float positionY;
int directionX = 1;
int directionY = 1;
float speedX = 3;
float speedY = 5;

void setup() {
  size(1000, 1000);
  background(0);
  strokeWeight(3);
  outerDiameter = width/2;

  // Generate the circle within the canvas
  positionX = random(0 + diameter, width - diameter);
  positionY = random(0 + diameter, height - diameter);

  generateColor();
}

void draw() {
  background(25);
  
  positionX = positionX + ( speedX * directionX );
  positionY = positionY + ( speedY * directionY );
  
  circle(positionX, positionY, size);

  if (positionX >= width - size || positionX < size) {
    directionX *= -1;
    generateColor();
  }
  if (positionY >= height - size || positionY < size) {
    directionY *= -1;
    generateColor();
  }

  for (int n = 0; n < numCircles; n++) {
    // sin and cos return the sine cosine of a giving angle (or offset)
    // sin() and cos() expect this angle to be between 0..2*PI
    // the radians() function allows us to convert a degree value (0..360) to a
    // corresponding radians value (0..2*PI)    
    float angle = map(n, 0, numCircles-1, -90, 90);

    float sinWave = sin(radians(angle + frameCount));
    float cosWave = cos(radians(angle + frameCount));

    // remap the sinWave and cosWave values by multiplying them
    // by a giving range
    // by the use of (width/2 - diameter/2) as range value,
    // the circles will use the full canvas size to for their horizontal movement
    // by subtracing -diameter/2 from the width/2, the circles will never
    // exceed the canvas size and will stop right before the borders / edges of the canvas 
    cosWave = map(cosWave, -1, 1, -outerDiameter/2, outerDiameter/2);
    sinWave = map(sinWave, -1, 1, -outerDiameter/2, outerDiameter/2);
    
    float x1 = width/2 + cosWave;
    float y1 = height/2 + sinWave;
    
    circle(x1, y1, diameter);
    line(x1, y1, positionX, positionY);
  }
}

void generateColor() {
  int selected = (int)random(0, 3);
  int choicesR[] = {214, 255, 224};
  int choicesG[] = {238, 102, 255};
  int choicesB[] = {255, 99, 79};
  color c = color(choicesR[selected], choicesG[selected], choicesB[selected]);
  
  fill(c);
  stroke(c, 50);
}
