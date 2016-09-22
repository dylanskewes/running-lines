//user variables
float lineLength;
float lineSpeed;
float lineQuantity;
float lineColour;

// Create a shader object
PShader shaderToy;

ArduinoInput input;
SoundInput sound;

//-------------------------------------
void setup() {
  size(640, 480, P2D);
  noStroke();
  background(0);

  shaderToy = loadShader("myShader.glsl"); // Load our .glsl shader from the /data folder
  shaderToy.set("iResolution", float(width), float(height), 0); // Pass in our xy resolution to iResolution uniform variable in our shader

input = new ArduinoInput(this);
sound = new SoundInput(this);

}
//-----------------------------------------
void update_shader_params(){
  float[] sensorValues = input.getSensor();
    
    lineColour = map(sensorValues[0], 0,1023,0.1,1.0);
    lineSpeed = map(sensorValues[1], 0,1023,1.0,10.0);
    lineLength = map(sound.getVolume(), 0.0,1.0,5.0,80.0);
    lineQuantity = map(sound.getVolume(), 0.0,1.0,0.02,0.5);
    
  shaderToy.set("lineColour", lineColour);
  shaderToy.set("lineSpeed", lineSpeed);
  shaderToy.set("lineLength", lineLength);
  shaderToy.set("lineQuantity", lineQuantity);
}
//-------------------------------------
void draw() {
  
  update_shader_params();

  
  shaderToy.set("iGlobalTime", millis() / 1000.0); // pass in a millisecond clock to enable animation 
  shaderToy.set("iMouse", float(mouseX), float(mouseY), 0.0, 0.); // Pass in our mouse coordinates to the shader
  //shaderToy.set("sepeartion", 0.5+(sin(millis()*0.00003)*0.5)*4.0);
  shader(shaderToy); 
  rect(0, 0, width, height); // We draw a rect here for our shader to draw onto
}