// Need G4P library
import g4p_controls.*;

// play/pause state of the simulation (connected to a button on the GUI)
boolean paused  = true;

Particle[] particles = {
  new Particle(100, 350, 10, 5, 0),
  new Particle(1100, 350, 10, 5, 180)
};

public void setup() {
  
  size(1200, 700);
  createGUI();

  // initialize particles
  particles[0].resetParticle1();
  particles[1].resetParticle2();
}

public void draw() {
  background(255);
  
  // if simulation is paused
  if(paused) {

    for (Particle p: particles) {
      
      // render particles without updating their positions
      p.render();
      p.renderData();
    }
  }
  
  // if simulation is playing
  else {
    
    // render particles
    for (Particle p: particles) {
      p.update();
      p.checkBorderCollision();
      p.render();
      p.renderData();
    }

    // check for collision
    particles[0].checkParticleCollision(particles[1]);

    // TESTING PURPOSES ONLY
    /*for (Particle p: particles) {
      println("particle heading: " + p.velocity.heading());
      println("particle speed: " + p.velocity.mag());
      println("velocity x: " + p.velocity.x);
      println("velocity y: " + p.velocity.y);
    }*/
  }
}
