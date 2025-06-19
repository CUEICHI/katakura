#include <CapacitiveSensor.h>

CapacitiveSensor   cs_9_10 = CapacitiveSensor(9,10);        // 10M resistor between pins 4 & 2, pin 2 is sensor pin, add a wire and or foil if desired

void setup()                    
{
   cs_9_10.set_CS_AutocaL_Millis(0xFFFFFFFF);     // turn off autocalibrate on channel 1 - just as an example
   Serial.begin(115200);
}

void loop()                    
{
    long start = millis();
    int val =  cs_9_10.capacitiveSensor(30);
    //Serial.println(val);
    if(val < 800){
        Serial.write(0);
    }else{
        Serial.write(255);
    }
    delay(100);                             // arbitrary delay to limit data to serial port 
}
