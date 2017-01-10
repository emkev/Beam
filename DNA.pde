
/* 2017.01.05 am 01:19 
   DNA class as the force about the object-ship flying . 
   2017.01.07
   2017.01.10 , correct Mutation Rate function .
*/

class DNA {
 
  PVector[] genes ;
  int geneSum ;
  float maxStrength ;
  
  DNA() {
    geneSum = 50 ;
    maxStrength = 0.25 ;
    genes = new PVector[geneSum] ;
    
    for(int i = 0 ; i < geneSum ; i++) {
      PVector randomVec = new PVector( random(-100 , 100) , random(-100 , 100) ) ;
      randomVec.normalize();
      randomVec.mult( maxStrength );
      genes[i] = randomVec ;
    }
    
  }

  DNA( PVector[] newGenes ) {
    geneSum = newGenes.length ;
    maxStrength = 0.25 ;
    genes = newGenes ;
  }
  
  
  DNA CrossOver( DNA partnerDNA ) {
    
    PVector[] childGenes = new PVector[geneSum] ;
    
    int midPoint = (int)random( 0 , geneSum-1 ) ;
    
    for(int i = 0 ; i <= midPoint ; i++) {
      childGenes[i] = genes[i] ;
    }
    
    for(int j = midPoint+1 ; j < geneSum ; j++) {
      childGenes[j] = partnerDNA.genes[j] ;
    }
    
    DNA childDNA = new DNA( childGenes ) ;
    
    return childDNA ;
  }
  
  /* Mutation activity is about Whether mutate for each GENE . */
  void Mutate( float mutationRate ) {
    
    for(int k = 0 ; k < geneSum ; k++) {
    
      if( random(1) < mutationRate ) {
      
        PVector newPoint = new PVector( random(-100 , 100) , random(-100 , 100) ) ;
        newPoint.normalize();
        newPoint.mult( maxStrength );
        genes[k] = newPoint ;

      }
    } /*  for(int k = 0 ; k < geneSum ; k++)  */
    
  }
 
}

