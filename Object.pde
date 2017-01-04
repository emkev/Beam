
/* 2016.12.08 
   2017.01.05 add DNA class as run-force , and add life span .
*/

class Object extends Particle {

  DNA dna ;
  int lifeSpan ;
  boolean isBang ;
  
  Object( DNA _dna ) {
    super();
    dna = _dna ;
    isBang = false ;
    lifeSpan = 200 ;
  }
  
  void run() {
    super.run() ;
    lifeSpan -= 2 ;
  }
  
  void display() {
    fill(50 , 50 , 100);
    ellipse(location.x , location.y , 16 , 16) ;
  }
  
}
