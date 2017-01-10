
/* 2016.12.08 
   2017.01.11 , add 'size' variable to display() .
*/

class Particle
{
  PVector location ;
  PVector velocity ;
  PVector acceleration ;
  
  float maxSpeed ;
  float size ;
  float bodyColor1 , bodyColor2 , bodyColor3 ; 
  
  Particle() {

    location = new PVector( random(width) , random(height) ) ;
    velocity = new PVector(1 , 1) ;
    acceleration = new PVector(0 , 0) ;
    
    maxSpeed = 10 ;
    size = 16 ;
    bodyColor1 = 50.0 ;
    bodyColor2 = 50.0 ;
    bodyColor3 = 50.0 ;
  }
  
  Particle( PVector l ) {
    location = l.get() ;
    velocity = new PVector(0 , 0) ;
    acceleration = new PVector(0 , 0) ;
    
    maxSpeed = 10 ;
    size = 16 ;
    bodyColor1 = 50.0 ;
    bodyColor2 = 50.0 ;
    bodyColor3 = 50.0 ;
  }

  Particle( PVector l , PVector v ) {
    location = l.get() ;
    velocity = v.get() ;
    acceleration = new PVector(0 , 0) ;
    
    maxSpeed = 10 ;
    size = 16 ;
    bodyColor1 = 50.0 ;
    bodyColor2 = 50.0 ;
    bodyColor3 = 50.0 ;
  }
  
  Particle(PVector l , PVector v , float s , float c) {
    
    location = l.get();
    velocity = v.get();
    acceleration = new PVector(0 , 0) ;
    
    maxSpeed = 10 ;
    size = s ;
    bodyColor1 = 50.0 ;
    bodyColor2 = 50.0 ;
    bodyColor3 = 50.0 ;
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
    
    if( ((location.x-size/2) < 0) || ((location.x+size/2) > width) )
      velocity.x = (-1) * velocity.x ;
     
    if( ((location.y-size/2) < 0) || ((location.y+size/2) > height) )
      velocity.y = (-1) * velocity.y ; 
  }
  
  void display() {
    fill( bodyColor1 , bodyColor2 , bodyColor3 );
    ellipse(location.x , location.y , size , size) ;
  }
  
}
