// converting degrees to radians (GUI input in degrees, converted to radians for processing math functions)
float degToRad(int degAngle) {
  float radAngle = (PI/180) * degAngle;
  return radAngle;
}

// calculating A component of the velocity vector of a given particle
float getVelocityA(int speed, float radAngle) {
  float a = speed*cos(radAngle);
  return a;
}

// calculating B component of the velocity vector of a given particle
float getVelocityB(int speed, float radAngle) {
  float b = speed*sin(radAngle);
  return b;
}
