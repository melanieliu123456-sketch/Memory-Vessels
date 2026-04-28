//Melanie Liu
//2-2
//Apr 24, 2026
//Memory vessel

color darkblue = #4F71CE;
color outline = #7FC2F7;
color earsred = #B499B2;
color earsyellow = #D4E289;
color lightblue = #B6ECFD;
color[] warmColors = {#F25F5F, #F28B82, #F6B26B, #FFD966, #EFA7A7};

int numBalls = 14;
float bigX = 400;
float bigY = 400;
float bigR = 195;
float angle1, angle2;

float[] bx = new float[numBalls];
float[] by = new float[numBalls];
float[] br = new float[numBalls];
float[] vx = new float[numBalls];
float[] vy = new float[numBalls];

PGraphics ballsLayer;
PGraphics maskLayer;

void setup() {
  size(800, 800);

  ballsLayer = createGraphics(width, height);
  maskLayer = createGraphics(width, height);

  for (int i = 0; i < numBalls; i++) {
    br[i] = random(15, 55);

    float startAngle = random(TWO_PI);
    float distance = random(0, bigR + 100);
    bx[i] = bigX + cos(startAngle) * distance;
    by[i] = bigY + sin(startAngle) * distance;

    float speed = 1.3;
    float moveAngle = random(TWO_PI);
    vx[i] = cos(moveAngle) * speed;
    vy[i] = sin(moveAngle) * speed;
  }
}

void draw() {
  background(255);
  noStroke();
  toodle(0, 50);
  
  angle1 += radians(8);
  angle2 -= radians(8);
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
  spinningEars(190, 170, angle1);
  spinningEars(610, 170, angle2);

  popMatrix();
}

void movingBalls() {
  ballsLayer.beginDraw();
  ballsLayer.clear();
  ballsLayer.fill(lightblue);
  ballsLayer.noStroke();
  ballsLayer.circle(bigX, bigY, bigR * 2);
  ballsLayer.noStroke();

  for (int i = 0; i < numBalls; i++) {
    bx[i] += vx[i];
    by[i] += vy[i];
    float d = dist(bx[i], by[i], bigX, bigY);

    if (d - br[i] > bigR) {
      float nx = (bx[i] - bigX) / d;
      float ny = (by[i] - bigY) / d;
      float dot = vx[i] * nx + vy[i] * ny;

      vx[i] = vx[i] - 2 * dot * nx;
      vy[i] = vy[i] - 2 * dot * ny;
      bx[i] = bigX + nx * (bigR + br[i]);
      by[i] = bigY + ny * (bigR + br[i]);
    }
    ballsLayer.fill(warmColors[i % warmColors.length], 150);
    ballsLayer.circle(bx[i], by[i], br[i] * 2);
  }

  ballsLayer.endDraw();
  maskLayer.beginDraw();
  maskLayer.background(0);
  maskLayer.noStroke();
  maskLayer.fill(255);
  maskLayer.circle(bigX, bigY, bigR * 2);
  maskLayer.endDraw();

  PImage clippedBalls = ballsLayer.get();
  clippedBalls.mask(maskLayer.get());
  image(clippedBalls, 0, 0);
}

void spinningEars(int x, int y, float a) {
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
