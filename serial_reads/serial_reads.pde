import processing.serial.Serial;
import grafica.*;

//SERIAL
static final int PORT_INDEX = 2, BAUDS = 9600;
String serialData = "";
String[] list; //contains the seraildata

// Initialise arrays of user data for 'reading' 
IntList touchData0 = new IntList(); 
IntList touchData1 = new IntList(); 
IntList touchData2 = new IntList(); 
IntList touchData3 = new IntList(); 
IntList touchData4 = new IntList(); 

//Center Screen
float w2;
float h2;

void setup() {
   size(1024,700); 
   w2 = width /2;
   h2 = height /2;
   //noFill();
   
  smooth();
  colorMode (HSB, 360, 100, 100 ); // mode, rangeH, rangeS, RangeB
  background(0,0,0);//WHITE
  stroke(0,0,100); //BLACK
  strokeWeight(4);
  
  final String[] ports = Serial.list();
  //printArray(ports);
  new Serial(this, ports[PORT_INDEX], BAUDS).bufferUntil(ENTER);
}

void draw() {
  //DEBUG 
   // println(serialData); //DEBUG INCOMING SERIAL DATA
  //println(list);
 
  circles(); 
  //vertexes();
  drawPentagons();
  
  rotatingBars();
  sineWave();
  
  drawGraph();
}

void serialEvent(final Serial s) {
  serialData = s.readString().trim();
  redraw = true;
  list = split(serialData, ',');
}
