  int polygonX = 800;
  int polygonY = 550;
  
void drawPentagons() {
  pushMatrix();
  translate(polygonX, polygonY);
  rotate(frameCount / 50.0); //Speed  - lower is faster
  float shape0 = map(float(list[0]), 0,100, 10,100);
  float shape1 = map(float(list[1]), 0,100, 10,100);
  float shape2 = map(float(list[2]), 0,100, 10,100);
  float shape3 = map(float(list[3]), 0,100, 10,100);
  float shape4 = map(float(list[4]), 0,100, 10,100);
  polygon(0, 0, shape0, 5, 35);  
  polygon(0, 0, shape1, 5, 347); 
  polygon(0, 0, shape2, 5, 177); 
  polygon(0, 0, shape3, 5, 70); 
  polygon(0, 0, shape4, 5, 316); 
  
  popMatrix();
}


void polygon(float x, float y, float radius, int npoints, int colour) {
  //noStroke();
  stroke(0,0,0,20);
  strokeWeight(2);
  float angle = TWO_PI / npoints;
  fill(colour,100,100,10); //HSB,Alpha
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
