#include<Servo.h>
#include<LIDARLite.h>

LIDARLite myLidarLite;

Servo myservo;
int servoVal;
int servoState;
int x;
int y;
int rawX;
int rawY;
int D=50;
int D_data= 25;


void setup() {
 Serial.begin(9600);
  myservo.attach(5);
 myLidarLite.begin(0,true);
 myLidarLite.configure(0);


  

}

void loop() {
  if(servoState==1){
    if(servoVal>=180){
        servoState=0;
      }
      else{
          delay(D);
          servoVal++;
        }
  }
  if(servoState ==0){
    if(servoVal<=0){
      servoState =1;
    }
    else{
      delay(D);
      servoVal--;
    }
  } 
  myservo.write(servoVal);

  rawX=servoVal;
  rawY=myLidarLite.distance();
  
  Serial.print(rawX);
  Serial.print(",");
  Serial.print(rawY);
  Serial.print("/");

  delay(D_data);

}
