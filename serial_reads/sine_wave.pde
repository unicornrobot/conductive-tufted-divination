/**
 * Sine Wave
 * by Daniel Shiffman.  
 // https://processing.org/examples/sinewave.html
 * 
 * Render a simple sine wave. 
 */
 
int xspacing = 16;   // How far apart should each horizontal location be spaced
int w = 1024+16;              // Width of entire wave

float theta = 0.0;  // Start angle at 0
float amplitude0;//map(float(list[0]),0,100,10,75);//75.0;  // Height of wave
float amplitude1;
float amplitude2;
float amplitude3;
float amplitude4;
//
float period = 500.0;  // How many pixels before the wave repeats
float dx = (TWO_PI / period) * xspacing;  // Value for incrementing X, a function of period and xspacing
float[] yvalues; // Using an array to store height values for the wave

void sineWave(){
  yvalues = new float[w/xspacing];  // Using an array to store height values for the wave 
  
  amplitude0 = map(float(list[0]),0,100,10,75);
  
  amplitude1 = map(float(list[1]),0,100,10,75);
  amplitude2 = map(float(list[2]),0,100,10,75);
  amplitude3 = map(float(list[3]),0,100,10,75);
  amplitude4 = map(float(list[4]),0,100,10,75);
  
 // println(amplitude);
  calcWave();
  renderWave(37);
  renderWave(347);
}

void calcWave() {
  noFill();
  // Increment theta (try different values for 'angular velocity' here
  theta += 0.02;

  // For every x value, calculate a y value with sine function
  float x = theta;
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = sin(x)*amplitude0;
    x+=dx;
  }
}

void renderWave(int waveColour) {
  
  noFill();
  //fill(37,100,100,20);
  // A simple way to draw the wave with an ellipse at each location
  for (int x = 0; x < yvalues.length; x++) {
    stroke(waveColour,100,100,5);
    ellipse(x*xspacing, height/2+yvalues[x], 16, 16);
    /*
    stroke(347,100,100,20);
    ellipse(x*xspacing, height/2+yvalues[x], 16, 16);
    stroke(177,100,100,20);
    ellipse(x*xspacing, height/2+yvalues[x], 16, 16);
    stroke(70100,100,20);
    ellipse(x*xspacing, height/2+yvalues[x], 16, 16);
    stroke(316,100,100,20);
    ellipse(x*xspacing, height/2+yvalues[x], 16, 16);
    */
  }
}
