
/* 2017.01.02 am 02:46 
   2017.01.11 
*/

class BigBomb extends Particle {
 
  float setTimeSpan ;
  
  BigBomb( PVector l , PVector v ) {
    super( l , v ) ;
    setTimeSpan = 80 ;

    size = 32 ;
    bodyColor1 = 50.0 ;
    bodyColor2 = 50.0 ;
    bodyColor3 = 50.0 ;
    
  }
  
  void run() {
    super.run();
    setTimeSpan -= 2 ;
  }
  
  void display() {

    fill( bodyColor1 , bodyColor2 , bodyColor3 ) ;

    ellipse( location.x , location.y , size , size );

    pushMatrix();
    translate( location.x , location.y ) ;
    rotate( PI/4 ) ;
    rect( -8 , -18 , 16 , 12 ) ;
    rect( -1 , -30 , 2  , 12 ) ;
    popMatrix();
  }
  
}
