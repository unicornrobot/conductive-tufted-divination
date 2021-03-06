//Graphica Library - 

//addPoint reference - https://github.com/jagracar/grafica/blob/master/src/grafica/GPlot.java#L1928


void drawGraph() {
 // Prepare the points for the plot
  int nPoints = 10;
  GPointsArray points = new GPointsArray(nPoints);

  for (int i = 0; i < nPoints; i++) {
    points.add(i, 10*noise(0.1*i));
    //points.add(i, float(list[0]));
  }

  // Create a new plot and set its position on the screen
  GPlot plot = new GPlot(this);
  plot.setPos(25, 25);
  // or all in one go
  // GPlot plot = new GPlot(this, 25, 25);

  // Set the plot title and the axis labels
  plot.setTitleText("A very simple example");
  plot.getXAxis().setAxisLabelText("x axis");
  plot.getYAxis().setAxisLabelText("y axis");

  // Add the points
  //plot.setPoints(points);
  plot.addPoint(float(list[0]),float(list[0]));
  plot.setPoints(points);

  // Draw it!
  plot.defaultDraw();
}
