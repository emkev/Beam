
/* 2016.12.08 */

class Fighter extends Particle {
 
  Fighter(PVector l) {
    super(l);
  }
  
  Fighter(PVector l , PVector v , float len , float c) {
    super( l , v , len , c );
  }
  
  void display() {
    fill(204 , 102 , 0) ;
    ellipse( location.x , location.y , 20 , 20 );
    ellipse( location.x , location.y ,  8 ,  8 );
    
    // four circles
    ellipse( location.x-8  , location.y , 2 , 2 );
    ellipse( location.x+8 , location.y ,  2 , 2 );
    ellipse( location.x , location.y-8 ,  2 , 2 );
    ellipse( location.x , location.y+8 ,  2 , 2 );
  }
  
}
