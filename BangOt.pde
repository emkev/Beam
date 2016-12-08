
/* 2016.12.08 ,
   2016.12.09
*/

class BangOt extends Particle {

  float lifeSpan ;
  
  BangOt( PVector l , PVector v ) {
    super( l , v );
    lifeSpan = 100 ;
  }
  
  void run() {
    super.update();
    super.checkEdge();
    display();
    lifeSpan-- ;
  }
  
  void display() {
    ellipse(location.x , location.y , 6 , 6 );
  }
  
}
