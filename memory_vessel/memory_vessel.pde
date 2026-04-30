//Melanie Liu
//2-2
//Apr 24, 2026
//Memory vessel

color darkblue = #4F71CE;
color outline = #7FC2F7;
color earsred = #B499B2;
color earsyellow = #D4E289;
color lightblue = #B6ECFD;
color gearyellow = #F9DA52;
color gearred = #E84C4D;
color geargreen = #8DD252;
color[] warmColors = {#F25F5F, #F28B82, #F6B26B, #FFD966, #EFA7A7};

int numBalls = 14;
float Ear_left, Ear_right, Gear_Y, Gear_R, Gear_G;

float[] bx = new float[numBalls];
float[] by = new float[numBalls];
float[] br = new float[numBalls];
float[] vx = new float[numBalls];
float[] vy = new float[numBalls];

PGraphics ballsLayer;
PGraphics maskLayer;

boolean gearTurn = true;

void setup() {
  size(800, 650);

  ballsLayer = createGraphics(width, height);
  maskLayer = createGraphics(width, height);

  for (int i = 0; i < numBalls; i++) {
    br[i] = random(15, 55);

    float startAngle = random(TWO_PI);
    float distance = random(0, 195 + 100);
    bx[i] = 400 + cos(startAngle) * distance;
    by[i] = 400 + sin(startAngle) * distance;

    float speed = 1.3;
    float moveAngle = random(TWO_PI);
    vx[i] = cos(moveAngle) * speed;
    vy[i] = sin(moveAngle) * speed;
  }
}

void draw() {
  background(#99BA87);
  
  pushMatrix();
  translate(0, -50);
  
  noStroke();
  gear_Y(400, 780, 9);
  fill(#4962CB);
  ellipse(400, 800, 850, 700);
  toodle(0, 50);
  if (gearTurn) Gear_Y += radians(3);
  Ear_left += radians(8);
  Ear_right -= radians(8);
  
  if (frameCount % 10 == 0) gearTurn = !gearTurn;
  
  popMatrix();
}

void toodle(int x, int y) {
  pushMatrix();
  translate(x, y);
  
  //base
  fill(darkblue);
  circle(400, 400, 450);
  circle(190, 170, 240);
  circle(610, 170, 240);
  
  //head
  movingBalls();
  noFill();
  stroke(outline);
  strokeWeight(15);
  circle(400, 400, 400);
  
  //ears
  noStroke();
  spinningEars(190, 170, Ear_left);
  spinningEars(610, 170, Ear_right);

  popMatrix();
}

void movingBalls() {
  ballsLayer.beginDraw();
  ballsLayer.clear();
  ballsLayer.fill(lightblue);
  ballsLayer.noStroke();
  ballsLayer.circle(400, 400, 195 * 2);
  ballsLayer.noStroke();

  for (int i = 0; i < numBalls; i++) {
    bx[i] += vx[i];
    by[i] += vy[i];
    float d = dist(bx[i], by[i], 400, 400);

    if (d - br[i] > 195) {
      float nx = (bx[i] - 400) / d;
      float ny = (by[i] - 400) / d;
      float dot = vx[i] * nx + vy[i] * ny;

      vx[i] = vx[i] - 2 * dot * nx;
      vy[i] = vy[i] - 2 * dot * ny;
      bx[i] = 400 + nx * (195 + br[i]);
      by[i] = 400 + ny * (195 + br[i]);
    }
    ballsLayer.fill(warmColors[i % warmColors.length], 150);
    ballsLayer.circle(bx[i], by[i], br[i] * 2);
  }

  ballsLayer.endDraw();
  maskLayer.beginDraw();
  maskLayer.background(0);
  maskLayer.noStroke();
  maskLayer.fill(255);
  maskLayer.circle(400, 400, 195 * 2);
  maskLayer.endDraw();

  PImage clippedBalls = ballsLayer.get();
  clippedBalls.mask(maskLayer.get());
  image(clippedBalls, 0, 0);
}

void spinningEars(int x, int y, float a) {// x coordinate, y coordinate, rotate degree
  pushMatrix();
  translate(x, y);
  rotate(a);
  
  fill(outline);
  circle(0, 0, 190);
  fill(earsred);
  arc(-8, -8, 140, 140, PI, PI + HALF_PI);
  arc(8, 8, 140, 140, 0, HALF_PI);
  fill(earsyellow);
  arc(8, -8, 140, 140, PI + HALF_PI, TWO_PI);
  arc(-8, 8, 140, 140, HALF_PI, PI);
  fill(outline);
  circle(0, 0, 40);
  fill(darkblue);
  circle(0, 0, 30);

  popMatrix();
}

void gear_Y(int x, int y, int s) {// x coordinate, y coordinate, scale
  pushMatrix();
  translate(x, y);
  scale(s);
  rotate(Gear_Y);
  
  fill(gearyellow);
  circle(0, 0, 100);
  for (int i = 0; i < 13; i += 1){
    rect(-8, -56, 16, 112);
    rotate(PI/6);
  }
  
  popMatrix();
}

void gear_R(int x, int y, int s) {
  pushMatrix();
  translate(x, y);
  scale(s);
  rotate(Gear_R);
  
  fill(gearred);
  circle(0, 0, 100);
  for(int i = 0; i < 9; i += 1) {
    circle(0, 0, 100);
  }
  
  popMatrix();
}
