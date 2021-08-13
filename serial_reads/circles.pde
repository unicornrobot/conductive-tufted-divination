int circleX = 500;
int circleY = 550;

void circles(){
  fill(35,100,100,20);//HSB,Alpha, (ORANGE)
  float circle0 = map(float(list[0]), 0,100, 10,200);
  ellipse (circleX,circleY, circle0,circle0);
  
  fill(347,100,100,20);//RED
  float circle1 = map(float(list[1]), 0,100, 10,200);
  ellipse (circleX,circleY, circle1,circle1);
  
  fill(177,100,60,20);//TURQUOSE
  float circle2 = map(float(list[2]), 0,100, 10,200);
  ellipse (circleX,circleY, circle2,circle2);
  
  fill(70,100,100,20);//LIME
  float circle3 = map(float(list[3]), 0,100, 10,200);
  ellipse (circleX,circleY, circle3,circle3);
  
  fill(316,70,100,20);//PINK
  float circle4 = map(float(list[4]), 0,100, 10,200);
  ellipse (circleX,circleY, circle4,circle4);
}
