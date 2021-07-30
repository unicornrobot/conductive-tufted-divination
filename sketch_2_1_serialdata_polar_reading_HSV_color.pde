import toxi.color.*;
import toxi.geom.*;
import toxi.math.*;

import processing.serial.Serial;
static final int PORT_INDEX = 2, BAUDS = 9600;
String serialData = "";


//Polar graph display
// keepers of transition state & target
float transition, transTarget;
// use a S-Curve to achieve an ease in/out effect
InterpolateStrategy is=new SigmoidInterpolation(3);
int len0,len1,len2,len3,len4 =0;


//VARIABLES
int currentScreen;

float touch0,touchBar0;
float touch1,touchBar1;
float touch2,touchBar2;
float touch3,touchBar3;
float touch4,touchBar4;

float start;
int startBtn = 1; //start the reading button

//Time
int begin; 
int countdownDuration = 10; //countdown
int time = 20;

// Initialise arrays of user data for 'reading' 
IntList touchData0 = new IntList(); 
IntList touchData1 = new IntList(); 
IntList touchData2 = new IntList(); 
IntList touchData3 = new IntList(); 
IntList touchData4 = new IntList(); 

int sum0,sum1,sum2,sum3,sum4; //  sums
int avg0,avg1,avg2,avg3,avg4; //  averages

///START
 
void setup() {
   start = millis();
   size(600,600);
   
   fill(255);
   textSize(32);
  colorMode (HSB, 360, 100, 100 ); // mode, rangeH, rangeS, RangeB
  background(0,0,100);
  begin = millis();
  noStroke();
  smooth(3);
  final String[] ports = Serial.list();
  //printArray(ports);
  new Serial(this, ports[PORT_INDEX], BAUDS).bufferUntil(ENTER);
}


  //translate(w2, h2);
   // update transition
  //transition += (transTarget - transition) * 0.01;
  Vec2D normUp = new Vec2D(0, -1);
  // define a color container using HSV
  TColor col = TColor.newHSV(0, 1, 1);

 
void draw() {
  //println(serialData);
  //background(255);
  float w2=width * 0.5;
float h2=height * 0.5;

//SCREEN UI
  switch(currentScreen) {
  case 0: drawScreenZero(); break;
  case 1: drawScreenOne(); break;
  case 2: drawScreenTwo(); break;
  default: background(0); break;
  }
}
 
void mousePressed() {
  currentScreen++;
  //if (currentScreen > 2) { currentScreen = 0; }
  if (currentScreen == 2) { saveFrame((System.currentTimeMillis()/1000)+".png"); }
  
}
 
void drawScreenZero() { // PRE READ
  fill(255);  
  background(0, 0, 0);
  text("get ready",5,25);
  start = millis();
}
 
void drawScreenOne() { // READ DATA
  
   background(0, 0, 0);
  text("READING...",500,height-80);
  drawGraph(); 
}
 
void drawScreenTwo() { // SHOW RESULTS
 background(0, 0, 100); //WHITE
  //text("results",5,5);
  //drawResult();
  drawPolar();
  
 // print(touchData0); //output to console
}

void serialEvent(final Serial s) {
  serialData = s.readString().trim();
  redraw = true;
}

void drawGraph(){
     String[] list = split(serialData, ',');
      //println(list);

      /*turn the string into a number * then scale it to window height */
      touch0 = float(list[0]); touchBar0 = touch0 / 100 *height ; 
      touch1 = float(list[1]); touchBar1 = touch1 / 100 *height ;
      touch2 = float(list[2]); touchBar2 = touch2 / 100 *height ;
      touch3 = float(list[3]); touchBar3 = touch3 / 100 *height ;
      touch4 = float(list[4]); touchBar4 = touch4 / 100 *height ;
      
      //rectMode(CENTER);
      //Draw the bars
      int barHeight = 70;
      
      rect(10, height-(touchBar0 - barHeight), 70, touchBar0); //(x,y,width,height) - //-140 for a bit short of the top of screen)
      rect(100, height-(touchBar1 - barHeight), 70, touchBar1);
      rect(200, height-(touchBar2 - barHeight), 70, touchBar2);
      rect(300, height-(touchBar3 - barHeight), 70, touchBar3);
      rect(400, height-(touchBar4 - barHeight), 70, touchBar4);
      
      //write the numbers on screen
      textSize(32);
      text(list[0], 20, 30); // (data, x, y )
      text(list[1], 120, 30); 
      text(list[2], 220, 30); 
      text(list[3], 320, 30); 
      text(list[4], 420, 30); 
     
      
  //Record the readings in an array for the duration of the countdown    
    if (time > 0){  //if countdown in progress
    time = countdownDuration - (millis() - begin)/1000;
    //print the time - bottom right
    text(time+"s", 500, height-30); 
    //add data to the 5 'reading' arrays
       touchData0.append(int(touch0)); 
       touchData1.append(int(touch1)); 
       touchData2.append(int(touch2)); 
       touchData3.append(int(touch3)); 
       touchData4.append(int(touch4)); 
       
      
       
       //println(touchData0);
       //println("Sensor 0 Sum : " + sum0 + " \tAverage: " + avg0);
      //text(avg0,500,height-60);
      textSize(13);
      text("time left:",500,height-60);
      textSize(14);
      /*
      text("avg "+avg0, 20, 40); // vertical / horizontal
      text("avg "+avg1, 120, 40); 
      text("avg "+avg2, 220, 40); 
      text("avg "+avg3, 320, 40); 
      text("avg "+avg4, 420, 40); 
      */
  } else // countdown has reached zero
  
  drawScreenTwo(); //show results
  
  //Save Data 
  


}
  //end of timer
  
  
void drawPolar(){
  float w2=width * 0.5;
  float h2=height * 0.5;
  translate(w2, h2);
  
  for(int i = 0; i <  360 ; i += 1) { // start point on the circle / 360 (degrees) / width between bars
    float theta = radians(i);
    // create a polar coordinate
    
    //SIZE OF THE CIRCLES
    Vec2D polar0 = new Vec2D(200,theta); //SIZE OF CIRCLE
    Vec2D polar1 = new Vec2D(175,theta);
    Vec2D polar2 = new Vec2D(125,theta);
    Vec2D polar3 = new Vec2D(75,theta);
    Vec2D polar4 = new Vec2D(50,theta);
    
    // use theta as color hue (ensure theta is properly wrapped)
    //col.setHue((polar.y / TWO_PI) % 1); //CYCLE HUE
   
    
    
    // also use theta to manipulate line length
    
    //ORIGINAL
    //float len = noise (polar.y *4) *100;
    
    //RANDOM BARS
   /* float len0 = noise (polar0.y *4) *100;
    float len1 = noise (polar1.y *4) *100;
    float len2 = noise (polar2.y *4) *100;
    float len3 = noise (polar3.y *4) *100;
    float len4 = noise (polar4.y *4) *100;
*/

    //READ THE DATA  
    len0 = touchData0.get(i);
    len1 = touchData1.get(i);
    len2 = touchData2.get(i);
    len3 = touchData3.get(i);
    len4 = touchData4.get(i);
    //len = linedata0[i]; //Length of the line
    //print(len+" ");
    
    //IntList
    /*
    touchData0.append(linedata0[i]); // add the array 
    len0 = touchData0.get(i);
    touchData1.append(linedata1[i]); // add the array 
    len1 = touchData1.get(i);
    touchData2.append(linedata2[i]); // add the array 
    len2 = touchData2.get(i);
    touchData3.append(linedata3[i]); // add the array 
    len3 = touchData3.get(i);
    touchData4.append(linedata4[i]); // add the array 
    len4 = touchData4.get(i);
    */
    
    //
     // convert polar coord into cartesian space (to obtain position on a circle)
    Vec2D circ0 = polar0.copy().toCartesian();
    Vec2D circ1 = polar1.copy().toCartesian();
    Vec2D circ2 = polar2.copy().toCartesian();
    Vec2D circ3 = polar3.copy().toCartesian();
    Vec2D circ4 = polar4.copy().toCartesian();
    
    // create another coord splicing the circle at the top and using theta difference as position on a line
    Vec2D linear0 = new Vec2D((MathUtils.THREE_HALVES_PI - polar0.y) * w2 / PI + w2, 0);
    Vec2D linear1 = new Vec2D((MathUtils.THREE_HALVES_PI - polar1.y) * w2 / PI + w2, 0);
    Vec2D linear2 = new Vec2D((MathUtils.THREE_HALVES_PI - polar2.y) * w2 / PI + w2, 0);
    Vec2D linear3 = new Vec2D((MathUtils.THREE_HALVES_PI - polar3.y) * w2 / PI + w2, 0);
    Vec2D linear4 = new Vec2D((MathUtils.THREE_HALVES_PI - polar4.y) * w2 / PI + w2, 0);
    
    // interprete circular position as normal/direction vector 
    Vec2D dir0 = circ0.getNormalized();
    Vec2D dir1 = circ0.getNormalized();
    Vec2D dir2 = circ0.getNormalized();
    Vec2D dir3 = circ0.getNormalized();
    Vec2D dir4 = circ0.getNormalized();
    
    // interpolate both position & normal based on current transition state
    //circ0.interpolateToSelf(linear0, transition,is);
    dir0.interpolateToSelf(linear0, transition,is).normalizeTo(len0);//linear0 was normup
    //circ1.interpolateToSelf(linear1, transition,is);
    dir1.interpolateToSelf(linear1, transition,is).normalizeTo(len1);
   // circ2.interpolateToSelf(linear2, transition,is);
    dir2.interpolateToSelf(linear2, transition,is).normalizeTo(len2);
   // circ3.interpolateToSelf(linear3, transition,is);
    dir3.interpolateToSelf(linear3, transition,is).normalizeTo(len3);
    //circ4.interpolateToSelf(linear4, transition,is);
    dir4.interpolateToSelf(linear4, transition,is).normalizeTo(len4);
   
   //LINE WEIGHT
    strokeWeight(1);
    
    // apply color & draw line
    col.setHSV(0.09,1,1); //ORANGE  
    stroke(col.toARGB());  
    line(circ0.x, circ0.y, circ0.x + dir0.x, circ0.y + dir0.y);
    
    col.setHSV(0.02,1,1); //RED
    stroke(col.toARGB());
    line(circ1.x, circ1.y, circ1.x + dir1.x, circ1.y + dir1.y);
    
       col.setHue(0.7); // TEAL
    stroke(col.toARGB());
    line(circ2.x, circ2.y, circ2.x + dir2.x, circ2.y + dir2.y);
    
    col.setHue(0.2); // LIME
    stroke(col.toARGB());
    line(circ3.x, circ3.y, circ3.x + dir3.x, circ3.y + dir3.y);
    
       col.setHue(0.9); // PINK
    stroke(col.toARGB());
    line(circ4.x, circ4.y, circ4.x + dir4.x, circ4.y + dir4.y);

  }
}

void drawResult(){
  if (time == 0){  //when timer runs out - show result
  
      //get the average of reading
      int sum0 = touchData0.sum(), avg0 = sum0/touchData0.size();//undocumented size() method
      int sum1 = touchData1.sum(), avg1 = sum1/touchData1.size();
      int sum2 = touchData2.sum(), avg2 = sum2/touchData2.size();
      int sum3 = touchData3.sum(), avg3 = sum3/touchData3.size();
      int sum4 = touchData4.sum(), avg4 = sum4/touchData4.size();
      
      background(0); //clear screen
      drawCircle(avg0, width/2, height/2); //draw circle in the centre
      drawCircle(avg1, width/2, height/2);
      drawCircle(avg2, width/2, height/2);
      drawCircle(avg3, width/2, height/2);
      drawCircle(avg4, width/2, height/2);
      
      //SHOW AVERAGES
      text(avg0, 20, 30); // (data, x, y )
      text(avg1, 120, 30); 
      text(avg2, 220, 30); 
      text(avg3, 320, 30); 
      text(avg4, 420, 30); 
      textSize(10);
      
      //text(touchData0.toString(), 20, 60); // (data, x, y )
     
      
    } //end of timer  
}

void drawCircle(int average, int xloc, int yloc){
  noFill();
  noLoop();
  //map the ranges to colour values
  float sizeMap = map(average, 0, 100, 200, 550);
  float hueMap = map(average, 0, 100, 10, 225);
  float strokeMap = map(average, 0, 100, 10, 60);// 
  //text(average, xloc, height-50); 
  //print("avg: ");print(average);print("  size: ");println(strokeMap);
  //float ellipse0 = map(average, touchData0.min(), touchData0.max(), 200,400);
 
    strokeWeight(30);                                     //lower limit, upper limit
    stroke ( hueMap, 255, 255, 150 );   //H,S,B,alpha - value, min, max, alpha
    ellipse (xloc, yloc, sizeMap, sizeMap );          //x,y,w,h 
    noFill(); 
    
}
