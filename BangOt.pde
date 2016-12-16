
/* 2016.12.08 ,
   2016.12.09
   2016.12.16
*/

class BangOt extends Particle {

  float lifeSpan ;
  
  BangOt( PVector l , PVector v ) {
    super( l , v );
    lifeSpan = 40 ;
  }
  
  void run() {
    super.update();
    super.checkEdge();
    display();
    lifeSpan-- ;
  }
  
  void display() {
    fill(180 , 50 , 50);
    ellipse(location.x , location.y , 6 , 6 );
  }
  
}
