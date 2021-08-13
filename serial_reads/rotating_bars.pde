  int barX = 200;
  int barY = 550;

void rotatingBars(){ 
  noStroke();
  float sensor0 = map(float(list[0]),0,100,20,90);
  float sensor1 = map(float(list[1]),0,100,20,90);
  float sensor2 = map(float(list[2]),0,100,20,90);
  float sensor3 = map(float(list[3]),0,100,20,90);
  float sensor4 = map(float(list[4]),0,100,20,90);
  
  drawBars(sensor0,37);
  drawBars(sensor1,347);
  drawBars(sensor2,177);
  drawBars(sensor3,70);
  drawBars(sensor4,316);
}

void drawBars(float bardata, int barhue){
  if (frameCount % 5 == 0) {
    fill(barhue,100,100,bardata+10);
    pushMatrix();
    translate(barX, barY);
    rotate(radians(frameCount * 2  % 360));
    rect(10, 0, bardata, 10);
    
     //Blank out with bars
     /*
    rotate(radians(frameCount * 0.5  % 360));
    fill(0,100,100,0);
    rect(0, 10, 0, 0);
    */
    popMatrix();
    
  }
  
}
