
/* 2016.12.08 */

class Object extends Particle {

  boolean isBang ;
  
  Object() {
    super();
    isBang = false ;
  }
  
  void display() {
    fill(50 , 50 , 100);
    ellipse(location.x , location.y , 16 , 16) ;
  }
  
}
