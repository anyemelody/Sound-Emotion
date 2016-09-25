import netP5.*;//defines a netAddress for communication over UPT protocol
import oscP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(400, 400);
  frameRate(30);
  //declare the OSC object who will receive on port 12000
  oscP5 = new OscP5(this, 12000);
/* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  myRemoteLocation = new NetAddress("192.168.0.8", 12000);
}

void draw() {
  background(0);
}

//declare the event which will pull data of the message
float value;
float firstValue;

void oscEvent(OscMessage theOscMessage) {
  //check if "/first" is in the sent data
  if (theOscMessage.checkAddrPattern("/test")==true) {
      firstValue = theOscMessage.get(0).floatValue();
    
  }
    if (theOscMessage.checkAddrPattern("/tttt")==true) {
      value = theOscMessage.get(0).floatValue();
     
  }
    println("values01:"+firstValue);
     println("values02:"+value);
}