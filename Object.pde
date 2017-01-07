
/* 2016.12.08 
   2017.01.05 , add DNA class as run-force , and add life span .
   2017.01.07 , add applying the gene vector as force .  
*/

class Object extends Particle {

  DNA dna ;
  int lifeSpan ;
  boolean isBang ;
  int geneCount ;
  
  Object( DNA _dna ) {
    super();
    dna = _dna ;
    isBang = false ;
    lifeSpan = 500 ;
    geneCount = 0 ;
  }
  
  void run() {
    super.run() ;
    lifeSpan -= 1 ;
  }
  
  void display() {
    fill(50 , 50 , 100);
    ellipse(location.x , location.y , 16 , 16) ;
  }
  
}
