
/* 2016.12.08 
   2017.01.05 , add DNA class as run-force , and add life span .
   2017.01.07 , add applying the gene vector as force .
   2017.01.11 , using common size and displaying function of Parent class .
*/

class Object extends Particle {

  DNA dna ;
  int lifeSpan ;
  boolean isBang ;
  int geneCount ;
  
  Object( DNA _dna , int s ) {
    super();
    dna = _dna ;
    isBang = false ;
    lifeSpan = 500 ;
    geneCount = 0 ;

    // normal is 16
    size = s ;
    
    bodyColor1 = 50.0 ;
    bodyColor2 = 50.0 ;
    bodyColor3 = 100.0 ;

  }
  
  void run() {
    super.run() ;
    //lifeSpan -= 1 ;
  }
    
}
