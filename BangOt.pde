
/* 2016.12.08 ,
   2016.12.09
   2016.12.16
   2017.01.11
*/

class BangOt extends Particle {

  float lifeSpan ;
  
  BangOt( PVector l , PVector v , int s , float lSpan ) {
    super( l , v );
    
    // normal is 40.0
    lifeSpan = lSpan ;

    // normal is 6
    size = s ;
    bodyColor1 = 180.0 ;
    bodyColor2 = 50.0 ;
    bodyColor3 = 50.0 ;
    
  }
  
  void run() {
    super.run();
    lifeSpan-- ;
  }
  
}
