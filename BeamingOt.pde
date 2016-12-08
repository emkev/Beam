
/* 2016.12.08 */

class BeamingOt extends Particle {

  float lifeSpan ;
  
  BeamingOt( PVector l , PVector v ) {
    super( l , v );
    
    lifeSpan = 255 ;
  }
  
  void run() {
    super.run();
    lifeSpan -= 2 ;
  }
  
  void display() {
    ellipse( location.x , location.y , 4 , 4 ) ;
  }
  
}
