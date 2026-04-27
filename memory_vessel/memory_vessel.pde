//Melanie Liu
//2-2
//Apr 24, 2026
//Memory v

color darkblue = #4F71CE;
color outline = #7FC2F7;
color earsred = #B499B2;
color earsyellow = #D4E289;
float angle1, angle2;

void setup() {//----------------------------------------------------
  size(800, 800);
}//-----------------------------------------------------------------

void draw() {//-----------------------------------------------------
  background(255);
  toodle(0, 50);
  angle1 += radians(8);
  angle2 -= radians(8);
  guidelines();
}//-----------------------------------------------------------------

void toodle(int x, int y) {//----------------------------------------------
  pushMatrix();
  translate(x, y);
  
  //dark blue base
  fill(darkblue);
  noStroke();
  circle(400, 400, 450);
  fill(darkblue);
  noStroke();
  circle(190, 170, 240);
  fill(darkblue);
  noStroke();
  circle(610, 170, 240);
  
  //spinning ears
  spinningEars(190, 170, angle1);
  spinningEars(610, 170, angle2);
  
  popMatrix();
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

void guidelines() {//-----------------------------------------------
  line(0, mouseY, width, mouseY);
  line(mouseX, 0, mouseX, height);
  fill(#000000);
  text("(" + mouseX + ", " + mouseY + ")", mouseX+20, mouseY+20);
}//-----------------------------------------------------------------
