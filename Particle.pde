
/* 2016.12.08 */

class Particle
{
  PVector location ;
  PVector velocity ;
  PVector acceleration ;
  
  float maxSpeed ;
  float area ;
  float cell_color ; 
  
  //float lifeSpan ;
  
  Particle() {

    location = new PVector( random(width) , random(height) ) ;
    velocity = new PVector(1 , 1) ;
    acceleration = new PVector(0 , 0) ;
    
    maxSpeed = 10 ;
    area = 16 ;
    cell_color = 200 ;
  }
  
  Particle( PVector l ) {
    location = l.get() ;
    velocity = new PVector(0 , 0) ;
    acceleration = new PVector(0 , 0) ;
    
    maxSpeed = 10 ;
    area = 16 ;
    cell_color = 200 ;
  }

  Particle( PVector l , PVector v ) {
    location = l.get() ;
    velocity = v.get() ;
    acceleration = new PVector(0 , 0) ;
    
    maxSpeed = 10 ;
    area = 16 ;
    cell_color = 200 ;
    
    //lifeSpan = 255 ;
  }
  
  Particle(PVector l , PVector v , float len , float c) {
    
    location = l.get();
    velocity = v.get();
    acceleration = new PVector(0 , 0) ;
    
    maxSpeed = 10 ;
    area = len ;
    cell_color = c ;
  }
  
  void applyForce(PVector f) {
    acceleration.add(f);
  }
  
  void run() {
    update();
    checkEdge();
    display();
  }
  
  void update() {
    
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
    
    acceleration.mult(0);
  }
  
  void checkEdge() {
    
    if( ((location.x-area/2) < 0) || ((location.x+area/2) > width) )
      velocity.x = (-1) * velocity.x ;
     
    if( ((location.y-area/2) < 0) || ((location.y+area/2) > height) )
      velocity.y = (-1) * velocity.y ; 
  }
  
  void display() {
    fill(cell_color);
    ellipse(location.x , location.y , area , area) ;
  }
  
}
