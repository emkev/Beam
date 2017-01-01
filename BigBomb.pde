
/* 2017.01.02 am 02:46 */

class BigBomb extends Particle {
 
  float setTimeSpan ;
  
  BigBomb( PVector l , PVector v ) {
    super( l , v ) ;
    setTimeSpan = 80 ;
  }
  
  void run() {
    super.run();
    setTimeSpan -= 2 ;
  }
  
  void display() {

    fill(50 , 50 , 50);

    ellipse( location.x , location.y , 32 , 32 );

    pushMatrix();
    translate( location.x , location.y ) ;
    rotate( PI/4 ) ;
    rect( -8 , -18 , 16 , 12 ) ;
    rect( -1 , -30 , 2  , 12 ) ;
    popMatrix();
  }
  
}
