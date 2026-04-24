//Melanie Liu
//2-2
//Apr 24, 2026
//Memory v

color darkblue = #618CE0;

void setup() {//------------------------------------------------------
  size(800, 800);
  
}//------------------------------------------------------------------

void draw() {//------------------------------------------------------
  background(255);
  fill(darkblue);
  noStroke();
  circle(400, 400, 450);
  fill(darkblue);
  noStroke();
  circle(200, 180, 240);
  fill(darkblue);
  noStroke();
  circle(600, 180, 240);
  guidelines();
}//------------------------------------------------------------------

void guidelines() {
  
  strokeWeight(1);
  line(0, mouseY, width, mouseY);
  line(mouseX, 0, mouseX, height);
  fill(#000000);
  text("(" + mouseX + ", " + mouseY + ")", mouseX+20, mouseY+20);
}
