class Particle {
  int xPos; // used to calculate position
  int yPos; // used to calculate position
  int heading; // used to calculate velocity
  int speed; // used to calculate velocity
  int mass;
  PVector position; // particle position
  PVector positionDefault; // default particle position (for reset function)
  PVector velocity; // particle velocity (m/s)

  // constructor
  Particle(int x, int y, int m, int s, int h) {

    float radAngle = degToRad(h);
    float a = getVelocityA(s, radAngle);
    float b = getVelocityB(s, radAngle);

    // assignments
    position = new PVector(x, y);
    velocity = new PVector(a, b);
    mass = m;
  }

  // update particle position
  void update() {
    position.add(velocity);
  }

  // change the speed of the particle
  void changeSpeed(int speed) {
    this.speed = speed;
    float radAngle = degToRad(this.heading);
    float a = getVelocityA(speed, radAngle);
    float b = getVelocityB(speed, radAngle);
    this.velocity = new PVector(a, b);
  }

  // change the direction of tbe particle
  void changeHeading(int heading) {
    this.heading = heading;
    float radAngle = degToRad(heading);
    float a = getVelocityA(this.speed, radAngle);
    float b = getVelocityB(this.speed, radAngle);
    this.velocity = new PVector(a, b);
  
  }

  // checks for collision with the borders of the window
  void checkBorderCollision() {
    if (position.x > width - 25) {
      position.x = width - 25;
      velocity.x *= -1;
    } else if (position.x < 25) {
      position.x = 25;
      velocity.x *= - 1;
    } else if (position.y > height - 25) {
      position.y = height - 25;
      velocity.y *= -1;
    } else if (position.y < 25) {
      position.y = 25;
      velocity.y *= -1;
    }
  }

  // checks for collision between a given particle and another particle
  void checkParticleCollision(Particle p) {
    
    // create a distance vector between the other particle and this particle
    PVector distanceVector = PVector.sub(p.position, this.position);
    float magSq = distanceVector.magSq();
    float twoR = 25 + 25; // the two particles both have a radius of 25px
    float twoRSq = pow(twoR, 2);
    
    // if the particles are touching
    if(magSq <= twoRSq) {
      
      // unit vector s in the direction of the force imparted on one particle by the other
      PVector sHat = distanceVector.normalize();

      float k = this.velocity.dot(sHat) - p.velocity.dot(sHat);
      PVector ks = PVector.mult(sHat, k);
      p.velocity.add(ks);
      this.velocity.sub(ks);
      
      // clumping fix
      PVector spacer = PVector.mult(sHat, twoR);
      p.position = PVector.add(this.position, spacer);
    }
  }

  void render() {
    fill(0);
    circle(position.x, position.y, 50);
    circle(position.x + 8*(velocity.x), position.y + 7*(velocity.y), 10);
  }
  
  void renderData() {
    textSize(30);
    textAlign(CENTER);
    text(nf(this.velocity.mag(), 0, 2) + " m/s", position.x, position.y - 75);
    text(str(this.heading) + "\u00B0", position.x, position.y - 40);
  }
  
  void resetParticle1() {
    particles[0].changeSpeed(5);
    speed1.setValue(5);
    particles[0].changeHeading(0);
    heading1.setValue(0);
    particles[0].position.x = 100;
    particles[0].position.y = 350;
    println("particle 1 reset"); // testing purposes
  }
  
  void resetParticle2() {
    particles[1].changeSpeed(5);
    speed2.setValue(5);
    particles[1].changeHeading(180);
    heading2.setValue(180);
    particles[1].position.x = 1100;
    particles[1].position.y = 350;
    println("particle 2 reset"); // testing purposes
  }
}
