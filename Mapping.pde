import processing.serial.*;

String X;
String Y;
float rawx;
float rawy;
float x;
float y;
float prevX;
float prevY;
String coordinate = "";
int index1 = 0;

float[] linex1 = new float[1810];
float[] liney1 = new float[1810];
float[] linex2 = new float[1810];
float[] liney2 = new float[1810];

Serial myPort;

void setup() {
  size(1200, 780);
  frameRate(30);
  myPort = new Serial(this, "COM12", 9600);
  myPort.bufferUntil('/');
}

void serialEvent(Serial myPort) {
  coordinate = myPort.readStringUntil('/');
  coordinate = coordinate.substring(0, coordinate.length()-1);
  index1 = coordinate.indexOf(",");
  X = coordinate.substring(0, index1);
  Y = coordinate.substring(index1+1, coordinate.length());
  
  rawx = float(X);
  rawy = float(Y);
}

void draw() {
  float xscale = 1.5;
  float yscale = 1.5;
  x = rawy*(cos(rawx*(PI/180)));
  y = rawy*(sin(rawx*(PI/180)));
  x = ((x)*xscale) + 650;
  y = ((y*-1)*yscale) + 800;
  background(0, 0, 0);
  
  for (int i = 0; i <= 1800; i++) {
    if (i == rawx) {
      linex1[i] = prevX;
      liney1[i] = prevY;
      linex2[i] = x;
      liney2[i] = y;
      // Draw distance text
      float textX = (linex1[i] + linex2[i]) / 2;
      float textY = (liney1[i] + liney2[i]) / 2;
      drawDistanceText(textX, textY, rawy);
    }
    stroke(255);
    strokeWeight(10);
    drawCurve(linex1[i], liney1[i], linex2[i], liney2[i]);
  }
  

  
  prevX = x;
  prevY = y;
}

void drawDistanceText(float x, float y, float distance) {
  fill(255);
  textSize(16);
  textAlign(CENTER);
  text(nf(distance, 0, 2), x, y);
}

void drawCurve(float x1, float y1, float x2, float y2) {
  float ctrlX1 = x1;
  float ctrlY1 = y1 - 50;
  float ctrlX2 = x2;
  float ctrlY2 = y2 + 50;
  noFill();
  stroke(255, 255, 255);
  curve(ctrlX1, ctrlY1, x1, y1, x2, y2, ctrlX2, ctrlY2);
}
