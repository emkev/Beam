
/* 2016.12.08 */

class Fighter extends Particle {
 
  Fighter(PVector l) {
    super(l);
  }
  
  Fighter(PVector l , PVector v , float len , float c) {
    super( l , v , len , c );
  }
  
  void display() {
    ellipse(location.x , location.y , 8 , 8);
  }
  
}
